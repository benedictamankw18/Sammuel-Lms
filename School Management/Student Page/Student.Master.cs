using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace School_Management
{
    public partial class Student : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
            {
                //UserEmail.Text = Session["UserEmail"].ToString() + " - " + Session["UserPassword"].ToString() + " - " + Session["UserPasswordHash"].ToString();
            }
            else
            {
                Response.Redirect("~/web1.aspx");
            }
        }
    }
}