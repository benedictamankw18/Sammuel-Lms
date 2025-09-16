using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.Security;

namespace Samual_LMS
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Please enter both username and password.";
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["LMSConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT UserID, Role, PasswordHash FROM Users WHERE Username = @Username";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Username", username);
                con.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    string dbPassword = reader["PasswordHash"].ToString(); // This is now plain text
                    string role = reader["Role"].ToString();
                    int userId = Convert.ToInt32(reader["UserID"]);

                    if (BCrypt.Net.BCrypt.Verify(password, dbPassword))
                    {
                        Session["UserID"] = userId;
                        Session["Username"] = username;
                        Session["Role"] = role;

                        // Create auth cookie so ASP.NET knows you are logged in
                        FormsAuthentication.SetAuthCookie(username, false);
                        FormsAuthentication.SetAuthCookie(username, false);
                        Session["Role"] = role; // e.g., "Admin" or "User"

                        // Redirect to the original page or role dashboard
                        if (role == "Admin")
                            Response.Redirect("~/Admin/Default.aspx");
                        else if (role == "Teacher")
                            Response.Redirect("~/Teacher/Default.aspx");
                        else
                            Response.Redirect("~/Student/Default.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Invalid password.";
                    }
                }
                else
                {
                    lblMessage.Text = "User not found.";
                }
            }
        }
    }
}
