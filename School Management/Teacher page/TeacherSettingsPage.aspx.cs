using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;


namespace School_Management.Teacher_page
{
    public partial class TeavherSettingsPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadInstructorSettings();
            }
        }

        private void LoadInstructorSettings()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;


            int userId = Convert.ToInt32(Session["UserID"]); // Adjust depending on your session

           
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT FullName, Email, Role, Phone, DateOfBirth FROM Users WHERE UserID=@id";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@id", userId);
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        txtFullName.Text = reader["FullName"].ToString();
                        txtEmail.Text = reader["Email"].ToString();
                        txtPassword.Attributes["value"] = ""; // always blank for security
                        txtPhone.Text = reader["Phone"].ToString();
                        DateTime DaOBir;
                        if (!DateTime.TryParse(reader["DateOfBirth"].ToString(), out DaOBir))
                        {
                            lblMessage.Text = "❌ Please enter a Date of Birth.";
                            lblMessage.CssClass = "alert alert-danger";
                            lblMessage.Visible = true;
                            return;
                        }
                        txtDOB.Text = DaOBir.ToString("dd/mm/yyyy");
                    }
                }
            }
        }

        protected void btnSaveSettings_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;


            int userId = Convert.ToInt32(Session["UserID"]);
            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string dob = txtDOB.Text.Trim();
            string newPassword = txtPassword.Text.Trim();

           
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string updateQuery;

                if (!string.IsNullOrEmpty(newPassword))
                {
                    // Hash new password
                    string passwordHash = HashPassword(newPassword);
                    updateQuery = "UPDATE Users SET FullName=@FullName, Email=@Email, Phone=@Phone, DateOfBirth=@DOB, PasswordHash=@PasswordHash WHERE UserID=@id";

                    using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@FullName", fullName);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Phone", phone);
                        cmd.Parameters.AddWithValue("@DOB", dob);
                        cmd.Parameters.AddWithValue("@PasswordHash", passwordHash);
                        cmd.Parameters.AddWithValue("@id", userId);

                        con.Open();
                        int rows = cmd.ExecuteNonQuery();
                        ShowMessage(rows > 0);
                    }
                }
                else
                {
                    // Keep old password hash
                    updateQuery = "UPDATE Users SET FullName=@FullName, Email=@Email, Phone=@Phone, DateOfBirth=@DOB WHERE UserID=@id";

                    using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@FullName", fullName);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Phone", phone);
                        cmd.Parameters.AddWithValue("@DOB", dob);
                        cmd.Parameters.AddWithValue("@id", userId);

                        con.Open();
                        int rows = cmd.ExecuteNonQuery();
                        ShowMessage(rows > 0);
                    }
                }
            }
        }

        private string HashPassword(string password)
       {
            using (MD5 md5 = MD5.Create())
            {
                byte[] inputBytes = Encoding.ASCII.GetBytes(password);
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

        private void ShowMessage(bool success)
        {
            lblMessage.CssClass = success ? "text-success fw-bold" : "text-danger fw-bold";
            lblMessage.Text = success ? "✅ Settings updated successfully!" : "❌ Failed to update settings.";
        }
    }
}