using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;
using BCrypt.Net;

namespace Samual_LMS.Admin
{
    public partial class Settings : System.Web.UI.Page
    {
        private readonly string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["LMSConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                string role = Session["Role"] as string;

                if (string.IsNullOrEmpty(role))
                {
                    Response.Redirect("~/Login.aspx");
                    return;
                }

                LoadSettings();
            }
        }

        private void LoadSettings()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"
                    SELECT ud.FullName, ud.Email, ud.Phone, ud.ProfilePicture,
                           u.Username
                    FROM UsersDetails ud
                    INNER JOIN Users u ON ud.UserID = u.UserID
                    WHERE ud.UserID = @UserID", con);

                cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtFullName.Text = dr["FullName"].ToString();
                    txtEmail.Text = dr["Email"].ToString();
                    txtPhone.Text = dr["Phone"].ToString();
                    txtUsername.Text = dr["Username"].ToString();
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string profilePath = null;

            // Upload profile picture
            if (fuProfilePic.HasFile)
            {
                string fileName = Path.GetFileName(fuProfilePic.FileName);
                profilePath = "~/Uploads/Profile/" + fileName;
                fuProfilePic.SaveAs(Server.MapPath(profilePath));
            }

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                SqlTransaction transaction = con.BeginTransaction();

                try
                {
                    // Update UsersDetails
                    SqlCommand cmd1 = new SqlCommand(@"
                        UPDATE UsersDetails
                        SET FullName = @FullName,
                            Email = @Email,
                            Phone = @Phone,
                            ProfilePicture = ISNULL(@ProfilePicture, ProfilePicture)
                        WHERE UserID = @UserID", con, transaction);

                    cmd1.Parameters.AddWithValue("@FullName", txtFullName.Text);
                    cmd1.Parameters.AddWithValue("@Email", txtEmail.Text);
                    cmd1.Parameters.AddWithValue("@Phone", txtPhone.Text);
                    cmd1.Parameters.AddWithValue("@ProfilePicture", (object)profilePath ?? DBNull.Value);
                    cmd1.Parameters.AddWithValue("@UserID", Session["UserID"]);
                    cmd1.ExecuteNonQuery();

                    // Update Users (username and password if changed)
                    string passwordHash = null;
                    if (!string.IsNullOrWhiteSpace(txtPassword.Text))
                    {
                        passwordHash = BCrypt.Net.BCrypt.HashPassword(txtPassword.Text);
                    }

                    SqlCommand cmd2 = new SqlCommand(@"
                        UPDATE Users
                        SET Username = @Username" +
                        (passwordHash != null ? ", PasswordHash = @PasswordHash" : "") +
                        " WHERE UserID = @UserID", con, transaction);

                    cmd2.Parameters.AddWithValue("@Username", txtUsername.Text);
                    if (passwordHash != null)
                        cmd2.Parameters.AddWithValue("@PasswordHash", passwordHash);
                    cmd2.Parameters.AddWithValue("@UserID", Session["UserID"]);
                    cmd2.ExecuteNonQuery();

                    transaction.Commit();
                    lblMessage.Text = "Settings updated successfully!";
                    pnlMessage.Visible = true;
                }
                catch
                {
                    transaction.Rollback();
                    lblMessage.Text = "Error updating settings!";
                    pnlMessage.Visible = true;
                }
            }
        }

    }
}