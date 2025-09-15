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
    public partial class TeachersAnnouncement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/web1.aspx");
                return;
            }
            if (!IsPostBack)
            {
                LoadCourses();
                LoadAnnouncement();
            }
        }

        private void LoadCourses()
        {
           
            string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;


                string query = "SELECT CourseID, CourseName FROM Courses where InstructorID = " + Convert.ToInt32(Session["UserId"].ToString());
                SqlConnection con = new SqlConnection(connectionString);
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                ddlCourse.DataSource = cmd.ExecuteReader();
                ddlCourse.DataTextField = "CourseName";
                ddlCourse.DataValueField = "CourseID";
                ddlCourse.DataBind();
        }

        private void LoadAnnouncement()
        {
            

            string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;

            string query = @"SELECT A.Title, A.Message, A.AnnouncementDate, C.CourseName 
                                 FROM Announcement A 
                                 INNER JOIN Courses C ON A.CourseID = C.CourseID 
								 where c.InstructorID = " + Convert.ToInt32(Session["UserId"].ToString()) + " and A.CourseID = " + ddlCourse.SelectedValue + " ORDER BY A.AnnouncementDate DESC";
            using (SqlConnection con = new SqlConnection(connectionString))
            {

            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
                rptAnnouncement.DataSource = dt;
                rptAnnouncement.DataBind();

            }

               
            }
        

        protected void btnPost_Click(object sender, EventArgs e)
        {

            string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;


            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO Announcement (CourseID, Title, Message, AnnouncementDate, PostedBy) 
                                 VALUES (@CourseID, @Title, @Message, GetDate(), @PostedBy)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CourseID", ddlCourse.SelectedValue);
                cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@Message", txtMessage.Text.Trim());
                cmd.Parameters.AddWithValue("@PostedBy", Session["UserName"].ToString());

                con.Open();
                cmd.ExecuteNonQuery();
            }

            // Refresh list
            LoadAnnouncement();
            txtTitle.Text = txtMessage.Text = "";
        }

        protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadAnnouncement();
        }
    }
}