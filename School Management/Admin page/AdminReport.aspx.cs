using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
namespace School_Management
{
    public partial class Report : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStats();
                LoadRecentLogins();
            }
        }

        private void LoadStats()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                // Total Courses
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Courses", con))
                {
                    lblTotalCourses.Text = cmd.ExecuteScalar().ToString();
                }

                // Total Users
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Users", con))
                {
                    lblTotalUsers.Text = cmd.ExecuteScalar().ToString();
                }

                // Active Users
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE IsActive = 1", con))
                {
                    lblActiveUsers.Text = cmd.ExecuteScalar().ToString();
                }

                // Recent Logins (last 7 days)
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE LastLogin >= DATEADD(DAY, -7, GETDATE())", con))
                {
                    lblRecentLogins.Text = cmd.ExecuteScalar().ToString();
                }

                con.Close();
            }
        }

        private void LoadRecentLogins()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT TOP 10 FullName, Email, Role, LastLogin FROM Users ORDER BY LastLogin DESC", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptRecentLogins.DataSource = dt;
                rptRecentLogins.DataBind();
            }
        }

        protected string GetRoleCssClass(string role)
        {
            switch (role.ToLower())
            {
                case "admin":
                    return "badge-admin";
                case "student":
                    return "badge-student";
                case "lecturer":
                    return "badge-lecturer";
                default:
                    return "badge-default";
            }
        }



    }
}