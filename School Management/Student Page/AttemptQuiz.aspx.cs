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
    public partial class AttemptQuiz : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["QuizID"] != null)
                {
                    int quizId = Convert.ToInt32(Request.QueryString["QuizID"]);
                    LoadQuestions(quizId);
                }
                else
                {
                    lblMessage.Text = "❌ No quiz selected.";
                }
            }
        }

        private void LoadQuestions(int quizId)
        {
            string query = "SELECT QuestionID, QuestionText, OptionA, OptionB, OptionC, OptionD FROM QuizQuestions WHERE QuizID = @QuizID";

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@QuizID", quizId);
                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();
                rptQuestions.DataSource = dr;
                rptQuestions.DataBind();
            }
        }

        protected void rptQuestions_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var row = (System.Data.Common.DbDataRecord)e.Item.DataItem;
                RadioButtonList rbl = (RadioButtonList)e.Item.FindControl("rblOptions");

                rbl.Items.Add(new ListItem("A. " + row["OptionA"].ToString(), "A"));
                rbl.Items.Add(new ListItem("B. " + row["OptionB"].ToString(), "B"));
                rbl.Items.Add(new ListItem("C. " + row["OptionC"].ToString(), "C"));
                rbl.Items.Add(new ListItem("D. " + row["OptionD"].ToString(), "D"));
            }
        }

        protected void btnSubmitQuiz_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                lblMessage.Text = "⚠️ You must log in first!";
                return;
            }

            int studentId = Convert.ToInt32(Session["UserId"]);
            int quizId = Convert.ToInt32(Request.QueryString["QuizID"]);
             
            string cs = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                foreach (RepeaterItem item in rptQuestions.Items)
                {
                    int questionId = Convert.ToInt32(((HiddenField)item.FindControl("hfQuestionID")).Value);
                    RadioButtonList rblOptions = (RadioButtonList)item.FindControl("rblOptions");

                    if (rblOptions.SelectedItem != null)
                    {
                        string correctOption = "";
                        string answer = rblOptions.SelectedValue.Substring(0,1);
                        string qcorrect = "select correctOption from QuizQuestions where QuizID = @QuizID and QuestionID = @QuestionID";
                             using (SqlCommand cmd = new SqlCommand(qcorrect, con))
                        {
                            cmd.Parameters.AddWithValue("@QuizID", quizId);
                            cmd.Parameters.AddWithValue("@QuestionID", questionId);

                            if (con.State == ConnectionState.Closed)
                                con.Open();
                            SqlDataReader dr = cmd.ExecuteReader();
                            if (dr.Read()) {
                                correctOption = dr["correctOption"].ToString();
                            }
                                con.Close();
                        }


                        string query = @"INSERT INTO QuizAnswers (QuizID, QuestionID, StudentID, AnswerText, SubmittedAt, IsCorrect) 
                                 VALUES (@QuizID, @QuestionID, @StudentID, @AnswerText, @SubmittedAt, @IsCorrect)";
                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            cmd.Parameters.AddWithValue("@QuizID", quizId);
                            cmd.Parameters.AddWithValue("@QuestionID", questionId);
                            cmd.Parameters.AddWithValue("@StudentID", studentId);
                            cmd.Parameters.AddWithValue("@AnswerText", answer);
                            cmd.Parameters.AddWithValue("@IsCorrect", String.Equals(answer,correctOption) ? 1 : 0);
                            cmd.Parameters.AddWithValue("@SubmittedAt", DateTime.Now);

                            if (con.State == ConnectionState.Closed)
                                con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                        }

                        double scoreResult = 0;
                        string querySelectScore = @"Select count(*) as Score from QuizAnswers where IsCorrect = 1 and StudentID = @StudentID and QuizID = @QuizID";
                        using (SqlCommand cmdScore = new SqlCommand(querySelectScore, con))
                        {
                            cmdScore.Parameters.AddWithValue("@QuizID", quizId);
                            cmdScore.Parameters.AddWithValue("@StudentID", studentId);
                            if (con.State == ConnectionState.Closed)
                                con.Open();
                            SqlDataReader dr = cmdScore.ExecuteReader();

                            if (dr.Read())
                            {
                                scoreResult = Convert.ToDouble(dr["Score"].ToString());
                            }
                            con.Close();
                        }
                            
                        string queryR = @"INSERT INTO Results (QuizID, StudentID, Score) 
                                           VALUES (@QuizID, @StudentID, @Score)";
                        using (SqlCommand cmdR = new SqlCommand(queryR, con))
                        {
                            cmdR.Parameters.AddWithValue("@QuizID", quizId);
                            cmdR.Parameters.AddWithValue("@StudentID", studentId);
                            cmdR.Parameters.AddWithValue("@Score", scoreResult);

                            if (con.State == ConnectionState.Closed)
                                con.Open();

                            cmdR.ExecuteNonQuery();
                            con.Close();
                            btnSubmitQuiz.Enabled = false;
                        }

                    }
                }
            }

            lblMessage.Text = "✅ Quiz submitted successfully!";
        }

        protected void gvCourses_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "AttemptQuiz")
            {
                int quizId = Convert.ToInt32(e.CommandArgument);

                // Redirect to quiz attempt page
                Response.Redirect("AttemptQuiz.aspx?QuizID=" + quizId);
            }
        }


    }
}