using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Samual_LMS.Admin
{
    public partial class Default : System.Web.UI.Page
    {
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
                else
                {
                    lblUserName.Text = Session["Username"].ToString().ToUpper();
                }
            }

        }
    }
}