using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data; // For DataTable
using System.Data.SqlClient;
using System.Configuration;

namespace School_Management
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboardData();
                LoadStats();
            }
        }

        private void LoadDashboardData()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT COUNT(*) AS TotalUsers FROM Users";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                lblTotalUsers.Text = dt.Rows[0]["TotalUsers"].ToString();
            }
        }

        private void LoadStats()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Total Users
                SqlCommand cmdUsers = new SqlCommand("SELECT COUNT(*) FROM Users", conn);
                lblTotalUsers.Text = cmdUsers.ExecuteScalar().ToString();

                // Total Courses
                SqlCommand cmdCourses = new SqlCommand("SELECT COUNT(*) FROM Courses", conn);
                lblTotalCourses.Text = cmdCourses.ExecuteScalar().ToString();

                // Active Users
                SqlCommand cmdActive = new SqlCommand("SELECT COUNT(*) FROM Users WHERE IsActive = 1", conn);
                lblActiveUsers.Text = cmdActive.ExecuteScalar().ToString();

                // Pending Tasks (example placeholder)
                lblPendingTasks.Text = "5";
            }
        }

        private void LoadRecentLogins()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT TOP 5 FullName, Email, Role, LastLogin, LastLogout FROM Users ORDER BY LastLogin DESC", conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvRecentLogins.DataSource = dt;
                gvRecentLogins.DataBind();
            }
        }
    }
}