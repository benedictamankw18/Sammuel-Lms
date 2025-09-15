using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace School_Management.Student_Page
{
    public partial class StudentsView : System.Web.UI.Page
    {
        protected void gvCourses_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int courseId = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "CourseID"));

                GridView gvQuizzes = (GridView)e.Row.FindControl("gvQuizzes");

                string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT QuizID, QuizTitle, TotalMarks, StartDate, EndDate FROM Quizzes WHERE CourseID = @CourseID";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@CourseID", courseId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvQuizzes.DataSource = dt;
                    gvQuizzes.DataBind();
                }
            }
        }

    }
}