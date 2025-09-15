using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace School_Management
{
    public partial class StudentCourse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //LoadMyCourses();
                LoadCourses();
               // BindCourses();
            }
        }


        private void LoadCourses()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;
            int studentId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT c.CourseID, c.CourseName,
                   CASE WHEN sc.StudentID IS NOT NULL THEN 1 ELSE 0 END AS IsEnrolled
            FROM Courses c
            LEFT JOIN StudentCourses sc 
                ON c.CourseID = sc.CourseID AND sc.StudentID = @StudentID";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                da.SelectCommand.Parameters.AddWithValue("@StudentID", studentId);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvCourses.DataSource = dt;
                gvCourses.DataBind();
            }
        }


        protected void gvCourses_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Enroll")
            {
                string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;

                // 1️⃣ Ensure user is logged in
                if (Session["UserID"] == null)
                {
                    lblMessage.Text = "⚠️ Please log in before enrolling.";
                    return;
                }

                int courseId = Convert.ToInt32(e.CommandArgument);
                int studentId = Convert.ToInt32(Session["UserID"]);

                // 2️⃣ Get row + textbox
                GridViewRow row = ((Button)e.CommandSource).NamingContainer as GridViewRow;
                TextBox txtKey = row.FindControl("txtEnrollmentKey") as TextBox;

                if (txtKey == null)
                {
                    lblMessage.Text = "⚠️ Enrollment key box not found!";
                    return;
                }

                string enteredKey = txtKey.Text.Trim();

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // 3️⃣ Get course key
                    string keyQuery = "SELECT EnrollmentKey FROM Courses WHERE CourseID = @CourseID";
                    SqlCommand cmdKey = new SqlCommand(keyQuery, conn);
                    cmdKey.Parameters.AddWithValue("@CourseID", courseId);
                    string actualKey = cmdKey.ExecuteScalar()?.ToString();

                    if (actualKey == null)
                    {
                        lblMessage.Text = "❌ Course not found.";
                        return;
                    }

                    if (enteredKey != actualKey)
                    {
                        lblMessage.Text = "❌ Incorrect enrollment key!";
                        return;
                    }

                    // 4️⃣ Insert enrollment
                    string insertQuery = "INSERT INTO StudentCourses (StudentID, CourseID, EnrollmentDate) VALUES (@StudentID, @CourseID, GETDATE())";
                    SqlCommand cmdInsert = new SqlCommand(insertQuery, conn);
                    cmdInsert.Parameters.AddWithValue("@StudentID", studentId);
                    cmdInsert.Parameters.AddWithValue("@CourseID", courseId);

                    try
                    {
                        cmdInsert.ExecuteNonQuery();
                        lblMessage.CssClass = "text-success fw-bold";
                        lblMessage.Text = "✅ Successfully enrolled!";
                        LoadCourses(); // refresh GridView
                    }
                    catch (SqlException)
                    {
                        lblMessage.CssClass = "text-warning fw-bold";
                        lblMessage.Text = "⚠️ You are already enrolled in this course.";
                    }
                }
            }
        }






    }
}
