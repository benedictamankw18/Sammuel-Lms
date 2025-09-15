using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace School_Management.Student_Page
{
    public partial class StudentsQuizzessAndAssignment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadQuizzes();
                LoadAssignments();
            }
        }

        private void LoadQuizzes()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;

            // Get the current logged-in student's ID from session
            if (Session["UserID"] == null)
            {
                gvQuizzes.DataSource = null;
                gvQuizzes.DataBind();
                return;
            }
            int studentId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"  SELECT DISTINCT q.QuizID, q.Title, q.Description,
                          CASE 
                                WHEN EXISTS (
                                    SELECT 1 FROM QuizAnswers qa 
                                    WHERE qa.QuizID = q.QuizID AND qa.StudentID = @StudentID
                                ) THEN 1 ELSE 0
                            END AS HasAttempted
                        FROM Quizzes q
                        full JOIN Courses c ON c.CourseID = q.CourseID
                         full JOIN Enrollments e ON e.CourseID = c.CourseID
                        full JOIN Users u ON u.UserID = e.StudentID
                        WHERE q.IsPublished = 1 --AND u.Role = 'Student'";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                da.SelectCommand.Parameters.AddWithValue("@StudentID", studentId);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvQuizzes.DataSource = dt;
                gvQuizzes.DataBind();
            }
        }

        private void LoadAssignments()
        {
            string connStr = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT AssignmentID, AssignmentTitle, Description, DueDate FROM Assignments WHERE IsPublished = 1";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvAssignments.DataSource = dt;
                gvAssignments.DataBind();
            }
        }
    }
}