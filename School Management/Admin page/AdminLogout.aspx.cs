using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
namespace School_Management
{
    public partial class AdminLogout : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] != null)
            {
                // Optional: Log logout time
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    string query = "UPDATE Users SET LastLogout = @LogoutTime WHERE Email = @Email";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@LogoutTime", DateTime.Now);
                    cmd.Parameters.AddWithValue("@Email", Session["UserEmail"].ToString());
                    cmd.ExecuteNonQuery();
                }
            }

            // Clear session
            Session.Clear();
            Session.Abandon();
        }
    }
}