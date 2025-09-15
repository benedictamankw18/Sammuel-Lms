using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;

namespace School_Management.Student_Page
{
    public partial class ProfileAndSettings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProfile();
            }
        }

        private void LoadProfile()
        { 
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/web1.aspx");
                return;
            }

            int studentId = Convert.ToInt32(Session["UserID"]);
            lblStudentID.Text = studentId.ToString();

            string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT FullName, Email FROM Users WHERE UserID=@UserID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserID", studentId);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtFullName.Text = dr["FullName"].ToString();
                    txtEmail.Text = dr["Email"].ToString();
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Web1.aspx");
                return;
            }

            // ✅ Validate password fields
            if (txtPassword.Text.Trim() != txtConfirmPassword.Text.Trim())
            {
                lblMessage.Text = "❌ Password and Confirm Password do not match.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            int studentId = Convert.ToInt32(Session["UserID"]);

            string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "UPDATE Users SET FullName=@FullName, Email=@Email, PasswordHash=@Password WHERE UserID=@StudentID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Password", CreateMD5(txtPassword.Text.Trim()));
                cmd.Parameters.AddWithValue("@StudentID", studentId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            lblMessage.Text = "✅ Profile updated successfully!";
            lblMessage.ForeColor = System.Drawing.Color.Green;



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