using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Configuration;

namespace School_Management
{
    public partial class web1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session.Clear();
                if (Session["UserId"] != null)
                {
                    Response.Redirect("Dasshboard.aspx");
                }
            }
        }


        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string passwordHash = CreateMD5(txtPassword.Text.Trim());

            string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT * FROM Users WHERE Email = @Email AND PasswordHash = @PasswordHash AND IsActive = 1";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@PasswordHash", passwordHash);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                Session["UserId"] = reader["UserID"];
                                Session["UserName"] = reader["FullName"];
                                Session["UserRole"] = reader["Role"];
                                Session["UserEmail"] = email;
                                Session["UserPassword"] = txtPassword.Text;
                                RoleCheck(Session["UserRole"].ToString());
                            }
                            else
                            {
                                lblMessage.Text = "Invalid email or password.";
                            }
                        }
                        
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Database error: " + ex.Message;
                }
            }
        }

        private void RoleCheck(string userRole) {

            if (userRole.ToLower().Equals("admin"))
            {
                Response.Redirect("~/Admin page/WebForm1.aspx");
            } else if (userRole.ToLower().Equals("student"))
            {
                Response.Redirect("~/Student Page/StudentDashBoard.aspx");
            }
            else if (userRole.ToLower().Equals("instructor"))
            {
                Response.Redirect("~/Teacher page/TeacherDashBoard.aspx");
            }else
            {
                lblMessage.Text = "Who The Hell Are You!!!";
            }

        }

        private string CreateMD5(string input)
        {
            using (MD5 md5 = MD5.Create())
            {
                byte[] inputBytes = Encoding.ASCII.GetBytes(input);
                byte[] hashBytes = md5.ComputeHash(inputBytes);

                // Convert to hexadecimal string (works in .NET Framework)
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < hashBytes.Length; i++)
                {
                    sb.Append(hashBytes[i].ToString("x2"));
                }
                return sb.ToString();
            }
        }

      
    }
}