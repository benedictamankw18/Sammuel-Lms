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
    public partial class TeacherAttendance : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;


        protected void btnSave_Click(object sender, EventArgs e)
        {
            try{
            int totalStudents = gvAttendance.Rows.Count;
            int presentCount = 0, absentCount = 0, lateCount = 0;
            DateTime attendanceDate;
            if (!DateTime.TryParse(txtDate.Text, out attendanceDate))
            {
                lblMessage.Text = "❌ Please enter a valid date.";
                lblMessage.CssClass = "alert alert-danger";
                lblMessage.Visible = true;
                return;
            }
            foreach (GridViewRow row in gvAttendance.Rows)
            {
                DropDownList ddlStatus = row.FindControl("ddlStatus") as DropDownList;
                TextBox txtRemarks = row.FindControl("txtRemarks") as TextBox;

                if (ddlStatus == null || txtRemarks == null) continue;

                string status = ddlStatus.SelectedValue;

                if (status == "Present") presentCount++;
                else if (status == "Absent") absentCount++;
                else if (status == "Late") lateCount++;

                if (gvAttendance.DataKeys != null && gvAttendance.DataKeys.Count > row.RowIndex)
                {
                    int enrollmentId = Convert.ToInt32(gvAttendance.DataKeys[row.RowIndex].Value);
                    if (enrollmentId <= 0) continue; // Defensive check

                    string query = "INSERT INTO Attendance (EnrollmentID, AttendanceDate, Status, Remarks) " +
                                   "VALUES (@EnrollmentID, @Date, @Status, @Remarks)";

                    using (SqlConnection con = new SqlConnection(connectionString))
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@EnrollmentID", enrollmentId);
                        cmd.Parameters.AddWithValue("@Date", attendanceDate);
                        cmd.Parameters.AddWithValue("@Status", status);
                        cmd.Parameters.AddWithValue("@Remarks", txtRemarks.Text.Trim());

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }

            lblTotalStudents.Text = totalStudents.ToString();
            lblMessage.Text = $"✅ Attendance saved! Total: {totalStudents}, Present: {presentCount}, Absent: {absentCount}, Late: {lateCount}";
            lblMessage.CssClass = "alert alert-success";
            lblMessage.Visible = true;
        }catch (Exception ex)
        {
            lblMessage.Text = "❌ Error saving attendance: " + ex.Message;
            lblMessage.CssClass = "alert alert-danger";
            lblMessage.Visible = true;
        }
}


        protected void ddlCourses_SelectedIndexChanged(object sender, EventArgs e)
        {


            // Example: Load students for the selected course
            int courseId = Convert.ToInt32(ddlCourses.SelectedValue);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"SELECT e.EnrollmentID, u.FullName , u.UserID
                         FROM Enrollments e 
                         INNER JOIN Users u ON e.StudentID = u.UserID
                         WHERE e.CourseID = @CourseID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CourseID", courseId);
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    gvAttendance.DataSource = reader;
                    gvAttendance.DataBind();
                    con.Close();
                }
            }

            // Update total students label immediately when course changes
            lblTotalStudents.Text = gvAttendance.Rows.Count.ToString();
        }


        private void LoadCourses()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;


            using (SqlConnection con = new SqlConnection(connectionString))
            {
                if (Session["UserId"] == null) {
                    Response.Redirect("~/web1.aspx");
                    return;
                }
                string query = "SELECT CourseID, CourseName FROM Courses where InstructorID = " + Convert.ToInt32(Session["UserId"].ToString()); // adjust if table name differs
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    ddlCourses.DataSource = reader;
                    ddlCourses.DataTextField = "CourseName";   // what shows in dropdown
                    ddlCourses.DataValueField = "CourseID"; // actual value behind each item
                    ddlCourses.DataBind();
                    con.Close();
                }
            }

            ddlCourses.Items.Insert(0, new ListItem("-- Select Course --", "0"));
        }

        protected void Page_Load(object sender, EventArgs e)
{
    if (!IsPostBack) // only the first time, not on every postback
    {
        LoadCourses();
    }
}


    }
}