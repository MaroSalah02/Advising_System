using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone_3.Login
{
    public partial class Admin_login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            if (TextBox1.Text == "0" && TextBox2.Text == "admin")
            {
                Session["id"] = "-1";
                Response.Redirect("~/Admin/Home.aspx");
            }
            else
            {
                status.InnerText = "Wrong Entry";
            }
        }
    }
}