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
    public partial class ManageCourses : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadInstructors();
                LoadCourses();
            }
            // Register course IDs as valid event arguments
            foreach (GridViewRow row in gvCourses.Rows)
            {
                string id = gvCourses.DataKeys[row.RowIndex].Value.ToString();
                ClientScript.RegisterForEventValidation(btnLoadCourse.UniqueID, id);
            }
        }

        private void LoadInstructors()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT UserID, FullName FROM Users WHERE Role = 'Instructor' AND IsActive = 1";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    conn.Open();

                    ddlInstructors.DataSource = cmd.ExecuteReader();
                    ddlInstructors.DataTextField = "FullName";
                    ddlInstructors.DataValueField = "UserID";
                    ddlInstructors.DataBind();
                    conn.Close();

                    conn.Open();
                    UpdateddlInstructors.DataSource = cmd.ExecuteReader();
                    UpdateddlInstructors.DataTextField = "FullName";
                    UpdateddlInstructors.DataValueField = "UserID";
                    UpdateddlInstructors.DataBind();

                }
                
                // Insert a default option at the top
                ddlInstructors.Items.Insert(0, new ListItem("-- Select Instructor --", "0"));
                UpdateddlInstructors.Items.Insert(0, new ListItem("-- Select Instructor --", "0"));
            }
            catch (Exception ex)
            {
                // Handle error gracefully (optional: log it)
                lblMessage.Text = "Error loading instructors: " + ex.Message;
                lblMessage.CssClass = "text-danger";
            }
        }


        private void LoadCourses()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                SELECT c.CourseID, c.CourseName, c.Description, c.StartDate, c.EndDate, 
                       u.FullName AS InstructorName
                FROM Courses c
                LEFT JOIN Users u ON c.InstructorID = u.UserID";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvCourses.DataSource = dt;
                gvCourses.DataBind();
            }
        }


        protected void btnAddCourse_Click(object sender, EventArgs e)
        {
            if (ddlInstructors.SelectedValue == "0")
            {
                lblMessage.Text = "Please select an instructor.";
                lblMessage.CssClass = "text-danger";
                return;
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                DateTime startDate = DateTime.Parse(txtStartDate.Text);
                DateTime endDate = DateTime.Parse(txtEndDate.Text);
                string query = @"INSERT INTO Courses (CourseName, Description, StartDate, EndDate, InstructorID) 
                 VALUES (@CourseName, @Description, @StartDate, @EndDate, @InstructorID)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CourseName", txtCourseTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@StartDate", startDate);
                cmd.Parameters.AddWithValue("@EndDate", endDate);
                cmd.Parameters.AddWithValue("@InstructorID", ddlInstructors.SelectedValue);
                cmd.ExecuteNonQuery();
                
               
            }

            lblMessage.Text = "Course added successfully!";
            lblMessage.CssClass = "text-success";
            ClearFields();
            LoadCourses();
        }
        private void ClearFields()
        {
            txtCourseTitle.Text = "";
            txtDescription.Text = "";
            txtStartDate.Text = "";
            txtEndDate.Text = "";
            ddlInstructors.SelectedIndex = 0;
        }


        protected void gvCourses_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCourses.EditIndex = e.NewEditIndex;
            LoadCourses();
        }


        protected void gvCourses_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int courseId = Convert.ToInt32(gvCourses.DataKeys[e.RowIndex].Value);
            string courseName = ((TextBox)gvCourses.Rows[e.RowIndex].FindControl("txtCourseTitle")).Text;
            string description = ((TextBox)gvCourses.Rows[e.RowIndex].FindControl("txtDescription")).Text;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "UPDATE Courses SET CourseName=@CourseName, Description=@Description WHERE CourseID=@CourseID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CourseName", courseName);
                cmd.Parameters.AddWithValue("@Description", description);
                cmd.Parameters.AddWithValue("@CourseID", courseId);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            gvCourses.EditIndex = -1;
            LoadCourses();
        }

        protected void gvCourses_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int courseId = Convert.ToInt32(gvCourses.DataKeys[e.RowIndex].Value);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Courses WHERE CourseID=@CourseID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CourseID", courseId);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            LoadCourses();
        }

        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            int courseId = Convert.ToInt32(hdnDeleteId.Value);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Courses WHERE CourseID=@CourseID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CourseID", courseId);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            LoadCourses();
        }



        protected void gvCourses_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditRow")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                gvCourses.EditIndex = GetRowIndexByCourseId(rowIndex);
                LoadCourses();
            }
        }

        private int GetRowIndexByCourseId(int courseId)
        {
            for (int i = 0; i < gvCourses.Rows.Count; i++)
            {
                if (Convert.ToInt32(gvCourses.DataKeys[i].Value) == courseId)
                {
                    return i;
                }
            }
            return -1;
        }

        protected void gvCourses_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCourses.EditIndex = -1;
            LoadCourses();
        }

        // Load selected course into modal
        protected void btnLoadCourse_Click(object sender, EventArgs e)
        {
            int courseId = Convert.ToInt32(Request["__EVENTARGUMENT"]);
            hdnUpdateId.Value = courseId.ToString();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT c.CourseName, u.FullName, c.InstructorID  ,c.StartDate, c.EndDate, c.Description FROM Courses c
                LEFT JOIN Users u ON c.InstructorID = u.UserID WHERE c.CourseID=@CourseID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CourseID", courseId);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    UpdateTitle.Text = reader["CourseName"].ToString();
                    UpdateddlInstructors.SelectedValue = reader["InstructorID"].ToString();
                    UpdateStartDate.Text = Convert.ToDateTime(reader["StartDate"]).ToString("yyyy-MM-dd");
                    UpdateEndDate.Text = Convert.ToDateTime(reader["EndDate"]).ToString("yyyy-MM-dd");
                    UpdateDescription.Text = reader["Description"].ToString();
                }
                conn.Close();
            }

            // reopen modal after postback
            ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "var modal = new bootstrap.Modal(document.getElementById('updateModal')); modal.show();", true);
        }

        // Save changes
        protected void BtnUpdate_Click(object sender, EventArgs e)
        {
            int courseId = Convert.ToInt32(hdnUpdateId.Value);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"UPDATE Courses 
                         SET CourseName=@CourseName, InstructorID=@InstructorID, StartDate=@StartDate, EndDate=@EndDate, Description=@Description
                         WHERE CourseID=@CourseID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CourseName", UpdateTitle.Text);
                cmd.Parameters.AddWithValue("@InstructorID", UpdateddlInstructors.SelectedValue);
                cmd.Parameters.AddWithValue("@StartDate", UpdateStartDate.Text);
                cmd.Parameters.AddWithValue("@EndDate", UpdateEndDate.Text);
                cmd.Parameters.AddWithValue("@Description", UpdateDescription.Text);
                cmd.Parameters.AddWithValue("@CourseID", courseId);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            LoadCourses();
        }




    }
}