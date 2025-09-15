using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;
using System.Configuration;


namespace School_Management
{
    public partial class User : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUsers();
                ClearData();
            }
        }

        private void LoadUsers()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT UserID, FullName, Email, Role, Phone, IsActive FROM Users where role != 'Admin'", conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvUsers.DataSource = dt;
                gvUsers.DataBind();
            }
        }

        private void ClearData()
        {
            txtName.Text = "";
            txtEmail.Text = "";
            txtPassword.Text = "";
            txtPhone.Text = "";
        }

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    string query = "INSERT INTO Users (FullName, Email, PasswordHash,Phone, Role, IsActive) VALUES (@Name, @Email, @Password, @Phone, @Role, 1)";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", CreateMD5(txtPassword.Text.Trim())); // Ideally hash the password
                    cmd.Parameters.AddWithValue("@Role", ddlRole.SelectedValue);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    message.Text = "Infromation Saved ";
                    conn.Close();
                }
                LoadUsers();
                ClearData();
            }
            catch (Exception ex)
            {
                message.Text = "Error Occured " + ex.Message;
            }
        }

        protected void gvUsers_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            gvUsers.EditIndex = e.NewEditIndex;
            LoadUsers();
            ClearData();

        }

         protected void gvUsers_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
            {
                // Set DropDownList selected value when in edit mode
                if (e.Row.RowType == System.Web.UI.WebControls.DataControlRowType.DataRow && gvUsers.EditIndex == e.Row.RowIndex)
                {
                    DropDownList ddlEditRole = (DropDownList)e.Row.FindControl("ddlEditRole");
                    if (ddlEditRole != null)
                    {
                        string currentRole = DataBinder.Eval(e.Row.DataItem, "Role").ToString();
                        ddlEditRole.SelectedValue = currentRole;
                    }
                }
            }

    protected void gvUsers_RowUpdating(object sender, GridViewUpdateEventArgs e)
{
    int userId = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);

    GridViewRow row = gvUsers.Rows[e.RowIndex];
    string name = ((TextBox)row.FindControl("txtEditName")).Text.Trim();
    string email = ((TextBox)row.FindControl("txtEditEmail")).Text.Trim();
    string phone = ((TextBox)row.FindControl("txtEditPhone")).Text.Trim();
    string role = ((DropDownList)row.FindControl("ddlEditRole")).SelectedValue;

    using (SqlConnection conn = new SqlConnection(connString))
    {
        string query = "UPDATE Users SET FullName=@Name, Email=@Email, Role=@Role, Phone=@Phone WHERE UserID=@UserId";
        SqlCommand cmd = new SqlCommand(query, conn);
        cmd.Parameters.AddWithValue("@Name", name);
        cmd.Parameters.AddWithValue("@Email", email);
        cmd.Parameters.AddWithValue("@Role", role);
        cmd.Parameters.AddWithValue("@Phone", phone);
        cmd.Parameters.AddWithValue("@UserId", userId);

        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
    }

    gvUsers.EditIndex = -1;
    LoadUsers();
}


        protected void gvUsers_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            gvUsers.EditIndex = -1;
            LoadUsers();
        }

        protected void gvUsers_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            try
            {
                int userId = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    string query = "DELETE FROM Users WHERE UserID=@UserId";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
                LoadUsers();
                ClearData();
            }
            catch (Exception ex)
            {
                //
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
