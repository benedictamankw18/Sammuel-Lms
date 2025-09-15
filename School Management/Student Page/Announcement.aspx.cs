using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace School_Management.Student_Page
{
    public partial class Announcement : System.Web.UI.Page
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
                LoadAnnouncements();
            }
        }

        private void LoadAnnouncements()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT a.Title, a.Message, a.AnnouncementDate, a.PostedBy FROM Announcement a
                                join StudentCourses sc on a.CourseID = sc.CourseID
                                where sc.StudentID = " + Convert.ToInt32(Session["UserId"].ToString()) +" ORDER BY AnnouncementDate DESC";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptAnnouncements.DataSource = dt;
                rptAnnouncements.DataBind();
            }
        }
    }
}