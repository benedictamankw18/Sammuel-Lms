using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace School_Management.Student_Page
{
    public partial class CourseDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadGradebook();
            }
        }

        private void LoadGradebook()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    int stuId = Convert.ToInt32(Session["UserId"].ToString());
                    string query = @"
                        SELECT c.CourseName, q.Title AS QuizTitle, r.Score, q.TotalMarks,
                               CAST((CAST(r.Score AS FLOAT) / q.TotalMarks) * 100 AS DECIMAL(5,2)) AS Percentage,
                               r.DateTaken
                        FROM Results r
                        INNER JOIN Quizzes q ON r.QuizID = q.QuizID
                        INNER JOIN Courses c ON q.CourseID = c.CourseID
                        WHERE r.StudentID = @StudentID";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@StudentID", stuId); // Assume logged-in student ID is stored in Session
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvGradebook.DataSource = dt;
                    gvGradebook.DataBind();

                    lblMessage.Visible = dt.Rows.Count == 0;
                    lblMessage.Text = dt.Rows.Count == 0 ? "⚠️ No grades available yet." : "";
                }
            }
            catch (Exception ex)
            {
                lblMessage.Visible = true;
                lblMessage.CssClass = "alert alert-danger d-block text-center";
                lblMessage.Text = "❌ Error loading gradebook: " + ex.Message;
            }
        }
    }
}