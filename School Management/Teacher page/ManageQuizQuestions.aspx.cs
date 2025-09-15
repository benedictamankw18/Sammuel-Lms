using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace School_Management.Teacher_page
{
    public partial class ManageQuizQuestions : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadQuizzes();
                PopulateQuizzes();
            }
        }

        protected void btnPublishQuiz_Click(object sender, EventArgs e)
        {
            try
            {
                int quizId = Convert.ToInt32(ddlQuizzes.SelectedValue);
                int point = 0;

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();

                    // Get the number of questions for this quiz
                    string qquery = "SELECT COUNT(*) FROM QuizQuestions WHERE QuizID = @QuizID";
                    using (SqlCommand cmdCount = new SqlCommand(qquery, con))
                    {
                        cmdCount.Parameters.AddWithValue("@QuizID", quizId);
                        point = Convert.ToInt32(cmdCount.ExecuteScalar());
                    }

                    // Update the quiz as published and set total marks
                    string query = "UPDATE Quizzes SET IsPublished = 1, TotalMarks = @TotalMark WHERE QuizId = @QuizId";
                    using (SqlCommand cmdUpdate = new SqlCommand(query, con))
                    {
                        cmdUpdate.Parameters.AddWithValue("@QuizId", quizId);
                        cmdUpdate.Parameters.AddWithValue("@TotalMark", point * 1); // 1 mark per question

                        int rowsAffected = cmdUpdate.ExecuteNonQuery();
                        lblMessage.Visible = true;

                        if (rowsAffected > 0)
                        {
                            lblMessage.Text = "✅ Quiz published successfully!";
                            lblMessage.CssClass = "alert alert-success";
                        }
                        else
                        {
                            lblMessage.Text = "⚠️ No quiz found to publish.";
                            lblMessage.CssClass = "alert alert-warning";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "❌ Error: " + ex.Message;
                lblMessage.CssClass = "alert alert-danger";
                lblMessage.Visible = true;
            }
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvQuestions.EditIndex = e.NewEditIndex;
            BindQuestions(); // reload data
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvQuestions.EditIndex = -1;
            BindQuestions();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int questionId = Convert.ToInt32(gvQuestions.DataKeys[e.RowIndex].Value);

            GridViewRow row = gvQuestions.Rows[e.RowIndex];
            string questionText = ((TextBox)row.Cells[1].Controls[0]).Text;
            string optionA = ((TextBox)row.Cells[2].Controls[0]).Text;
            string optionB = ((TextBox)row.Cells[3].Controls[0]).Text;
            string optionC = ((TextBox)row.Cells[4].Controls[0]).Text;
            string optionD = ((TextBox)row.Cells[5].Controls[0]).Text;
            string correctAnswer = ((TextBox)row.Cells[6].Controls[0]).Text;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"UPDATE QuizQuestions 
                         SET QuestionText=@QuestionText, OptionA=@OptionA, OptionB=@OptionB,
                             OptionC=@OptionC, OptionD=@OptionD, CorrectOption=@CorrectOption
                         WHERE QuestionID=@QuestionID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@QuestionText", questionText);
                cmd.Parameters.AddWithValue("@OptionA", optionA);
                cmd.Parameters.AddWithValue("@OptionB", optionB);
                cmd.Parameters.AddWithValue("@OptionC", optionC);
                cmd.Parameters.AddWithValue("@OptionD", optionD);
                cmd.Parameters.AddWithValue("@CorrectOption", correctAnswer);
                cmd.Parameters.AddWithValue("@QuestionID", questionId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            gvQuestions.EditIndex = -1;
            BindQuestions();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int questionId = Convert.ToInt32(gvQuestions.DataKeys[e.RowIndex].Value);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM QuizQuestions WHERE QuestionID=@QuestionID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@QuestionID", questionId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            BindQuestions();
        }

        protected void gvQuestions_RowCommand(object sender, GridViewCommandEventArgs e)
{
    int questionId;
    if (!int.TryParse(e.CommandArgument.ToString(), out questionId))
        return;

    if (e.CommandName == "EditRow")
{
    foreach (GridViewRow row in gvQuestions.Rows)
    {
        if (gvQuestions.DataKeys[row.RowIndex].Value.ToString() == questionId.ToString())
        {
            hfQuestionID.Value = questionId.ToString();
            txtUpdateQuestion.Text = ((Label)row.FindControl("lblQuestionText")).Text;
            txtUpdateOptionA.Text = ((Label)row.FindControl("lblOptionA")).Text;
            txtUpdateOptionB.Text = ((Label)row.FindControl("lblOptionB")).Text;
            txtUpdateOptionC.Text = ((Label)row.FindControl("lblOptionC")).Text;
            txtUpdateOptionD.Text = ((Label)row.FindControl("lblOptionD")).Text;
            ddlUpdateCorrectAnswer.SelectedValue = ((Label)row.FindControl("lblCorrectAnswer")).Text;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "var myModal = new bootstrap.Modal(document.getElementById('editModal')); myModal.show();", true);
            break;
        }
    }
}
    else if (e.CommandName == "DeleteRow")
    {
        // Set the hidden field and show the confirmation modal
        hfDeleteQuestionID.Value = questionId.ToString();
        ScriptManager.RegisterStartupScript(this, this.GetType(),
            "PopDelete", "var myModal = new bootstrap.Modal(document.getElementById('deleteModal')); myModal.show();", true);
    }
}


        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            int questionId = Convert.ToInt32(hfDeleteQuestionID.Value);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM QuizQuestions WHERE QuestionID=@QuestionID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@QuestionID", questionId);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            // Refresh the questions list
            int quizId = Convert.ToInt32(ddlQuizzes.SelectedValue);
            PopulateQuestions(quizId);

            lblMessage.Text = "Question deleted successfully!";
            lblMessage.CssClass = "alert alert-success";
            lblMessage.Visible = true;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            var dt = ViewState["Questions"] as DataTable;
            if (dt != null)
            {
                DataRow row = dt.Rows.Find(hfQuestionID.Value);
                if (row != null)
                {
                    row["QuestionText"] = txtQuestion.Text;
                    row["OptionA"] = txtOptionA.Text;
                    row["OptionB"] = txtOptionB.Text;
                    row["OptionC"] = txtOptionC.Text;
                    row["OptionD"] = txtOptionD.Text;
                    row["CorrectAnswer"] = ddlCorrectAnswer.SelectedItem;
                }

                ViewState["Questions"] = dt;
                BindQuestions();
            }

            // Close modal after save
            ScriptManager.RegisterStartupScript(this, this.GetType(),
                "HidePopup", "$('#editModal').modal('hide');", true);
        }


        protected void btnUpdate_Click(object sender, EventArgs e)
{
    int questionId = Convert.ToInt32(hfQuestionID.Value);

    using (SqlConnection conn = new SqlConnection(connectionString))
    {
        string query = @"UPDATE QuizQuestions 
                         SET QuestionText=@QuestionText, OptionA=@OptionA, OptionB=@OptionB,
                             OptionC=@OptionC, OptionD=@OptionD, CorrectOption=@CorrectOption
                         WHERE QuestionID=@QuestionID";

        SqlCommand cmd = new SqlCommand(query, conn);
        cmd.Parameters.AddWithValue("@QuestionText", txtUpdateQuestion.Text);
        cmd.Parameters.AddWithValue("@OptionA", txtUpdateOptionA.Text);
        cmd.Parameters.AddWithValue("@OptionB", txtUpdateOptionB.Text);
        cmd.Parameters.AddWithValue("@OptionC", txtUpdateOptionC.Text);
        cmd.Parameters.AddWithValue("@OptionD", txtUpdateOptionD.Text);
        cmd.Parameters.AddWithValue("@CorrectOption", ddlUpdateCorrectAnswer.SelectedValue); // or txtUpdateCorrectAnswer.Text
        cmd.Parameters.AddWithValue("@QuestionID", questionId);

        conn.Open();
        cmd.ExecuteNonQuery();
    }

    BindQuestions();

    // Hide modal after update
    ScriptManager.RegisterStartupScript(this, this.GetType(),
        "HidePopup", "$('#editModal').modal('hide');", true);
}

        private void PopulateQuizzes()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;

            if (Session["UserId"] == null)
            {
                Response.Redirect("~/web1.aspx");
                return;
            }
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT QuizID, Title FROM Quizzes where InstructorID = @InstructorID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@InstructorID", Convert.ToInt32(Session["UserId"].ToString()));
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    ddlQuizzes.DataSource = reader;
                    ddlQuizzes.DataTextField = "Title";  // What will display in dropdown
                    ddlQuizzes.DataValueField = "QuizID";    // The value behind the scenes
                    ddlQuizzes.DataBind();
                    conn.Close();
                }
            }

            // Optional: Add default item
            ddlQuizzes.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Quiz --", "0"));
        }

        DataTable dt;

        protected void LoadQuizzes()
        {
            if (!IsPostBack)
            {
                dt = new DataTable();
                dt.Columns.Add("QuestionID", typeof(int)); // Add this line
                dt.Columns.Add("QuestionText");
                dt.Columns.Add("OptionA");
                dt.Columns.Add("OptionB");
                dt.Columns.Add("OptionC");
                dt.Columns.Add("OptionD");
                dt.Columns.Add("CorrectOption");

                ViewState["Questions"] = dt;
                BindQuestions();
            }
        }

        private void BindQuestions()
        {
           

                if (Session["UserId"] == null) { Response.Redirect("~/web1.aspx"); return; }
                string query = @"SELECT qq.QuestionID, qq.QuestionText, qq.OptionA, qq.OptionB, qq.OptionC, qq.OptionD, qq.CorrectOption
                 FROM QuizQuestions qq
                 JOIN Quizzes q ON qq.QuizID = q.QuizID
                 WHERE q.InstructorID = @InstructorID";

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@InstructorID", Convert.ToInt32(Session["UserId"]));
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvQuestions.DataSource = dt;
                    gvQuestions.DataBind();
                }

            
           
        }




        protected void btnAddQuestion_Click(object sender, EventArgs e)
        {
            try
    {
            if (ddlQuizzes.SelectedIndex == 0)
            {
                lblMessage.Text = "Please select a quiz first.";
                lblMessage.CssClass = "alert alert-warning";
                lblMessage.Visible = true;
                return;
            }

            int quizId = Convert.ToInt32(ddlQuizzes.SelectedValue);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO QuizQuestions 
                        (QuizID, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectOption)
                        VALUES (@QuizID, @QText, @A, @B, @C, @D, @Ans)";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@QuizID", quizId);
                cmd.Parameters.AddWithValue("@QText", txtQuestion.Text.Trim());
                cmd.Parameters.AddWithValue("@A", txtOptionA.Text.Trim());
                cmd.Parameters.AddWithValue("@B", txtOptionB.Text.Trim());
                cmd.Parameters.AddWithValue("@C", txtOptionC.Text.Trim());
                cmd.Parameters.AddWithValue("@D", txtOptionD.Text.Trim());
                cmd.Parameters.AddWithValue("@Ans", ddlCorrectAnswer.SelectedValue);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            PopulateQuestions(quizId); // Use this for consistency

        // clear fields
        txtQuestion.Text = txtOptionA.Text = txtOptionB.Text = txtOptionC.Text = txtOptionD.Text = "";

        lblMessage.Text = "Question added successfully!";
        lblMessage.CssClass = "alert alert-success";
        lblMessage.Visible = true;
    }
    catch (Exception ex)
    {
        lblMessage.Text = "Error: " + ex.Message;
        lblMessage.CssClass = "alert alert-danger";
        lblMessage.Visible = true;
    }
        }

        // protected void btnSaveQuiz_Click(object sender, EventArgs e)
        // {
        //     try
        //     {
        //         string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;

        //         using (SqlConnection con = new SqlConnection(connectionString))
        //         {
        //             con.Open();
                    
        //             int quizId = Convert.ToInt32(ddlQuizzes.SelectedValue);

        //             DataTable dt = ViewState["Questions"] as DataTable;
        //             foreach (DataRow row in dt.Rows)
        //             {
        //                 SqlCommand cmdQ = new SqlCommand(@"INSERT INTO QuizQuestions 
        //                 (QuizID, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectAnswer)
        //                 VALUES (@QuizID, @QText, @A, @B, @C, @D, @Ans)", con);

        //                 cmdQ.Parameters.AddWithValue("@QuizID", quizId);
        //                 cmdQ.Parameters.AddWithValue("@QText", row["QuestionText"]);
        //                 cmdQ.Parameters.AddWithValue("@A", row["OptionA"]);
        //                 cmdQ.Parameters.AddWithValue("@B", row["OptionB"]);
        //                 cmdQ.Parameters.AddWithValue("@C", row["OptionC"]);
        //                 cmdQ.Parameters.AddWithValue("@D", row["OptionD"]);
        //                 cmdQ.Parameters.AddWithValue("@Ans", row["CorrectAnswer"]);
        //                 cmdQ.ExecuteNonQuery();
        //             }

        //             lblMessage.ForeColor = System.Drawing.Color.Green;
        //             lblMessage.Text = "Quiz saved successfully!";
        //         }
        //     }
        //     catch (Exception ex)
        //     {
        //         lblMessage.Text = "Error: " + ex.Message;
        //     }
        // }

        // protected void btnPublish_Click(object sender, EventArgs e)
        // {
        //     try
        //     {
        //         string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;

        //         using (SqlConnection con = new SqlConnection(connectionString))
        //         {
        //             SqlCommand cmd = new SqlCommand("UPDATE Quizzes SET IsPublished=1 WHERE QuizID=@QuizID", con);
        //             cmd.Parameters.AddWithValue("@QuizID", Convert.ToInt32(ddlQuizzes.SelectedValue));
        //             con.Open();
        //             cmd.ExecuteNonQuery();
        //         }

        //         lblMessage.ForeColor = System.Drawing.Color.Green;
        //         lblMessage.Text = "Quiz published successfully!";
        //     }
        //     catch (Exception ex)
        //     {
        //         lblMessage.Text = "Error: " + ex.Message;
        //     }
        // }

        //private void LoadQuizDetails(int quizId)
        //{
        //    try
        //    {
        //        string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;


        //        string query = "SELECT Title, Description FROM Quizzes WHERE QuizID = @QuizID";

        //        using (SqlConnection con = new SqlConnection(connectionString))
        //        using (SqlCommand cmd = new SqlCommand(query, con))
        //        {
        //            cmd.Parameters.AddWithValue("@QuizID", quizId);
        //            con.Open();
        //            SqlDataReader dr = cmd.ExecuteReader();

        //            if (dr.Read())
        //            {
        //                txtQuizTitle.Text = dr["Title"].ToString();
        //                txtDescription.Text = dr["Description"].ToString();
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        lblMessage.Text = "❌ Error loading quiz details: " + ex.Message;
        //        lblMessage.CssClass = "alert alert-danger";
        //        lblMessage.Visible = true;
        //    }
        //}



        protected void ddlQuizzes_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlQuizzes.SelectedValue != "0")
            {
                int quizId = Convert.ToInt32(ddlQuizzes.SelectedValue);
                //LoadQuizDetails(quizId); // 👈 This method loads quiz info

                if (quizId > 0)
                {
                    PopulateQuestions(quizId);
                }
                else
                {
                    gvQuestions.DataSource = null;
                    gvQuestions.DataBind();
                }
            }
        }


        private void PopulateQuestions(int quizId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;


            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT QuestionID, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectOption " +
                               "FROM QuizQuestions WHERE QuizID=@QuizID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@QuizID", quizId);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    gvQuestions.DataSource = reader;
                    gvQuestions.DataBind();
                    conn.Close();
                }
            }
        }
    }
}