using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Web.UI;

namespace Samual_LMS.Admin
{
    public partial class Users : System.Web.UI.Page
    {
        // Get DB connection from Web.config
        string connStr = ConfigurationManager.ConnectionStrings["LMSConnection"].ConnectionString;

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

                // Show/hide controls based on role
                // pnlAddCourse.Visible = (role == "Admin");

                LoadUsers();
            }
        }

        // Load all students & teachers into GridView
        private void LoadUsers()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT UserID, FullName, Email, Phone, UserType FROM UsersDetails WHERE UserType IN ('Student','Teacher')";
                using (SqlDataAdapter da = new SqlDataAdapter(query, con))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvUsers.DataSource = dt;
                    gvUsers.DataBind();
                }
            }
        }

        // Show Add Form
        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            litFormTitle.Text = "Add New User";
            hfUserID.Value = "";
            txtFullName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            ddlUserType.SelectedIndex = 0;
            pnlForm.Visible = true;
        }

        // Cancel Form
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pnlForm.Visible = false;
        }

        protected void Application_Start(object sender, EventArgs e)
        {
            ScriptManager.ScriptResourceMapping.AddDefinition(
                "jquery",
                new ScriptResourceDefinition
                {
                    Path = "~/Scripts/jquery-3.7.1.min.js",
                    DebugPath = "~/Scripts/jquery-3.7.1.js",
                    CdnPath = "https://code.jquery.com/jquery-3.7.1.min.js",
                    CdnDebugPath = "https://code.jquery.com/jquery-3.7.1.js"
                }
            );
        }

        // Save User (Add / Update)
        protected void btnSave_Click(object sender, EventArgs e)
        {

            if (!Page.IsValid) return; // Stop if validation fails

            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();

            // Extra server-side checks (in case JS is bypassed)
            if (!System.Text.RegularExpressions.Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                System.Diagnostics.Debug.WriteLine("Invalid email entered: " + email);
                // Show error or log
                lblError.Text = "Invalid email address.";

                return;
            }

            if (!System.Text.RegularExpressions.Regex.IsMatch(phone, @"^\+?\d{10,15}$"))
            {
                // Show error or log
                lblError.Text = "Invalid phone number.";

                return;
            }


            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                SqlCommand cmd;

                if (string.IsNullOrEmpty(hfUserID.Value))
                {
                    // Insert
                    cmd = new SqlCommand("INSERT INTO UsersDetails (FullName, Email, Phone, UserType) VALUES (@FullName, @Email, @Phone, @UserType)", con);
                }
                else
                {
                    // Update
                    cmd = new SqlCommand("UPDATE UsersDetails SET FullName=@FullName, Email=@Email, Phone=@Phone, UserType=@UserType WHERE UserID=@UserID", con);
                    cmd.Parameters.AddWithValue("@UserID", hfUserID.Value);
                }

                cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
                cmd.Parameters.AddWithValue("@UserType", ddlUserType.SelectedValue);

                cmd.ExecuteNonQuery();
                con.Close();
            }

            pnlForm.Visible = false;
            LoadUsers();
        }

        // Handle GridView Edit/Delete
        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditUser")
            {
                int userID = Convert.ToInt32(e.CommandArgument);
                LoadUserForEdit(userID);
            }
            else if (e.CommandName == "DeleteUser")
            {
                int userID = Convert.ToInt32(e.CommandArgument);
                DeleteUser(userID);
                LoadUsers();
            }
        }

        // Load single user to form
        private void LoadUserForEdit(int userID)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM UsersDetails WHERE UserID=@UserID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserID", userID);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    hfUserID.Value = dr["UserID"].ToString();
                    txtFullName.Text = dr["FullName"].ToString();
                    txtEmail.Text = dr["Email"].ToString();
                    txtPhone.Text = dr["Phone"].ToString();
                    ddlUserType.SelectedValue = dr["UserType"].ToString();
                }
                con.Close();
            }

            litFormTitle.Text = "Edit User";
            pnlForm.Visible = true;
        }

        // Delete user
        private void DeleteUser(int userID)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM UsersDetails WHERE UserID=@UserID", con);
                cmd.Parameters.AddWithValue("@UserID", userID);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
    }
}
