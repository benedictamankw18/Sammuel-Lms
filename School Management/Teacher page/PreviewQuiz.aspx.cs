using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace School_Management.Teacher_page
{
    public partial class PreviewQuiz : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["QuizID"] != null)
                {
                    int quizId = Convert.ToInt32(Request.QueryString["QuizID"]);
                    LoadQuizDetails(quizId);
                    LoadQuestions(quizId);
                }
                else
                {
                    lblMessage.Text = "⚠ No quiz selected to preview.";
                }
            }
        }

        private void LoadQuizDetails(int quizId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT QuizTitle, Description FROM Quizzes WHERE QuizID = @QuizID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@QuizID", quizId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    lblQuizTitle.Text = reader["QuizTitle"].ToString();
                    lblDescription.Text = reader["Description"].ToString();
                }
                else
                {
                    lblMessage.Text = "⚠ Quiz not found.";
                }
            }
        }

        private void LoadQuestions(int quizId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectAnswer FROM QuizQuestions WHERE QuizID = @QuizID";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@QuizID", quizId);

                DataTable dt = new DataTable();
                da.Fill(dt);

                rptQuestions.DataSource = dt;
                rptQuestions.DataBind();
            }
        }

        protected void btnPublish_Click(object sender, EventArgs e)
        {
            int quizId = Convert.ToInt32(Request.QueryString["QuizID"]);
            string connStr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "UPDATE Quizzes SET IsPublished = 1 WHERE QuizID = @QuizID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@QuizID", quizId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            lblMessage.CssClass = "text-success fw-bold";
            lblMessage.Text = "✅ Quiz has been published successfully!";
        }
    }
}