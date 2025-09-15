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
    public partial class AdminSettings : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Session["UserEmail"] != null)
            {
                LoadUserProfile();
            }
        }

        private void LoadUserProfile()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT FullName, Email FROM Users WHERE Email = @Email";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", Session["UserEmail"].ToString());

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtFullName.Text = reader["FullName"].ToString();
                    txtEmail.Text = reader["Email"].ToString();
                }
            }
        }

        protected void btnUpdateProfile_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "UPDATE Users SET FullName = @FullName, Email = @Email WHERE Email = @OldEmail";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@OldEmail", Session["UserEmail"].ToString());

                cmd.ExecuteNonQuery();
                lblProfileMessage.CssClass = "success-message";
                lblProfileMessage.Text = "Profile updated successfully!";
                Session["UserEmail"] = txtEmail.Text.Trim();
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            if (txtNewPassword.Text != txtConfirmPassword.Text)
            {
                lblPasswordMessage.CssClass = "error-message";
                lblPasswordMessage.Text = "Passwords do not match!";
                return;
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string checkQuery = "SELECT PasswordHash FROM Users WHERE Email = @Email";
                SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
                checkCmd.Parameters.AddWithValue("@Email", Session["UserEmail"].ToString());

                string currentHash = CreateMD5(txtCurrentPassword.Text.Trim());
                string storedHash = checkCmd.ExecuteScalar()?.ToString();

                if (storedHash != currentHash)
                {
                    lblPasswordMessage.CssClass = "error-message";
                    lblPasswordMessage.Text = "Current password is incorrect!";
                    return;
                }

                string updateQuery = "UPDATE Users SET PasswordHash = @NewPasswordHash WHERE Email = @Email";
                SqlCommand updateCmd = new SqlCommand(updateQuery, conn);
                updateCmd.Parameters.AddWithValue("@NewPasswordHash", CreateMD5(txtNewPassword.Text.Trim()));
                updateCmd.Parameters.AddWithValue("@Email", Session["UserEmail"].ToString());

                updateCmd.ExecuteNonQuery();
                lblPasswordMessage.CssClass = "success-message";
                lblPasswordMessage.Text = "Password changed successfully!";
                txtCurrentPassword.Text = txtNewPassword.Text = txtConfirmPassword.Text = "";
            }
        }

        private string CreateMD5(string input)
        {
            using (var md5 = System.Security.Cryptography.MD5.Create())
            {
                byte[] inputBytes = System.Text.Encoding.ASCII.GetBytes(input);
                byte[] hashBytes = md5.ComputeHash(inputBytes);
                return BitConverter.ToString(hashBytes).Replace("-", "").ToLower();
            }
        }
    }
}