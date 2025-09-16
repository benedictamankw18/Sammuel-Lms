using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Samual_LMS.Admin
{
    public partial class Courses : System.Web.UI.Page
    {
        private readonly string connStr = ConfigurationManager.ConnectionStrings["LMSConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string role = Session["Role"] as string;

                if (string.IsNullOrEmpty(role))
                {
                    Response.Redirect("~/Login.aspx");
                    return;
                }

                // Show/hide controls based on role
               // pnlAddCourse.Visible = (role == "Admin");

                LoadCourses();
            }
        }

        private void LoadCourses()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                string sql = "SELECT * FROM Courses";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    using (SqlDataReader rdr = cmd.ExecuteReader())
                    {
                        GridView1.DataSource = rdr;
                        GridView1.DataBind();
                    }
                }
            }
        }

        protected void btnSaveCourse_ServerClick(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                if (string.IsNullOrEmpty(HiddenField1.Value))
                {
                    // Insert new
                    string insertSql = "INSERT INTO Courses (Title, Description, Instructor) VALUES (@Title, @Description, @Instructor)";
                    using (SqlCommand cmd = new SqlCommand(insertSql, con))
                    {
                        cmd.Parameters.AddWithValue("@Title", TextBox1.Text);
                        cmd.Parameters.AddWithValue("@Description", TextBox2.Text);
                        cmd.Parameters.AddWithValue("@Instructor", TextBox3.Text);
                        cmd.ExecuteNonQuery();
                    }
                }
                else
                {
                    // Update existing
                    string updateSql = "UPDATE Courses SET Title=@Title, Description=@Description, Instructor=@Instructor WHERE CourseID=@CourseID";
                    using (SqlCommand cmd = new SqlCommand(updateSql, con))
                    {
                        cmd.Parameters.AddWithValue("@Title", TextBox1.Text);
                        cmd.Parameters.AddWithValue("@Description", TextBox2.Text);
                        cmd.Parameters.AddWithValue("@Instructor", TextBox3.Text);
                        cmd.Parameters.AddWithValue("@CourseID", Convert.ToInt32(HiddenField1.Value));
                        cmd.ExecuteNonQuery();
                    }
                }
            }

            Panel1.Visible = false;
            LoadCourses();
        }
        protected void btnShowForm_Click(object sender, EventArgs e)
        {
            Panel1.Visible = !Panel1.Visible; // Toggle visibility
            litFormTitle.Text = "Add New Course";
            HiddenField1.Value = string.Empty;
            TextBox1.Text = string.Empty;
            TextBox2.Text = string.Empty;
            TextBox3.Text = string.Empty;
        }

        protected void gvCourses_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int courseId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "EditCourse")
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    string sql = "SELECT * FROM Courses WHERE CourseID = @CourseID";
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@CourseID", courseId);
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            HiddenField1.Value = reader["CourseID"].ToString();
                            TextBox1.Text = reader["Title"].ToString();
                            TextBox2.Text = reader["Description"].ToString();
                            TextBox3.Text = reader["Instructor"].ToString();
                        }
                    }
                }

                litFormTitle.Text = "Edit Course";
                Panel1.Visible = true; // Show form
            }
            else if (e.CommandName == "DeleteCourse")
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    string sql = "DELETE FROM Courses WHERE CourseID = @CourseID";
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@CourseID", courseId);
                        cmd.ExecuteNonQuery();
                    }
                }
                LoadCourses();
            }
        }

    }
}
