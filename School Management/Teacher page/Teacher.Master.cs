using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace School_Management
{
    public partial class Teacher : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserName"] != null)
            {
                lblUserName.Text = "Welcome, " + Session["UserName"].ToString();
            }
            else
            {
                Response.Redirect("~/web1.aspx");
            }
        }
    }
}