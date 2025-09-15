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
    public partial class TeacherDashBoard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboardData();
                LoadRecentActivities();
            }
        }

        private void LoadDashboardData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;


            int instructorId = Convert.ToInt32(Session["UserId"]); // ensure UserId is stored at login

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // 🔹 My Courses
                SqlCommand cmdCourses = new SqlCommand("SELECT COUNT(*) FROM Courses WHERE InstructorID=@InstructorID", con);
                cmdCourses.Parameters.AddWithValue("@InstructorID", instructorId);
                lblCoursesCount.Text = cmdCourses.ExecuteScalar().ToString();

                // 🔹 Students (assume Enrollments table exists; otherwise adjust)
                SqlCommand cmdStudents = new SqlCommand(@"
                    SELECT COUNT(DISTINCT e.StudentID) 
                    FROM Enrollments e 
                    INNER JOIN Courses c ON e.CourseID = c.CourseID 
                    WHERE c.InstructorID=@InstructorID", con);
                cmdStudents.Parameters.AddWithValue("@InstructorID", instructorId);
                lblStudentsCount.Text = cmdStudents.ExecuteScalar().ToString();

                // 🔹 Quizzes
                SqlCommand cmdQuizzes = new SqlCommand("SELECT COUNT(*) FROM Quizzes WHERE CreatedBy=@InstructorID", con);
                cmdQuizzes.Parameters.AddWithValue("@InstructorID", instructorId);
                lblQuizzesCount.Text = cmdQuizzes.ExecuteScalar().ToString();


                SqlCommand cmdAttempt = new SqlCommand(@"SELECT COUNT(DISTINCT qa.QuizID) AS TotalQuizzes 
                                                        FROM QuizAnswers qa join Quizzes q on qa.QuizID = q.QuizID
                                                        where q.InstructorID = @InstructorID", con);
                cmdAttempt.Parameters.AddWithValue("@InstructorID", instructorId);
                lblAttemptsCount.Text = cmdAttempt.ExecuteScalar().ToString();
            }
        }

        private void LoadRecentActivities()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;


            int instructorId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT TOP 5 q.QuizTitle AS Activity, q.CreatedAt AS Date, c.CourseName
                    FROM Quizzes q
                    INNER JOIN Courses c ON q.CourseID = c.CourseID
                    WHERE q.CreatedBy=@InstructorID
                    ORDER BY q.CreatedAt DESC";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@InstructorID", instructorId);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvRecentActivity.DataSource = dt;
                gvRecentActivity.DataBind();
            }
        }
    }
}