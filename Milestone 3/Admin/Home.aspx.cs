using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone_3.Admin
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void viewAllAdvisors(object sender, EventArgs e)
        { 
            Response.Redirect("ViewAdvisors.aspx");
        }

        protected void viewStudentsWithAdvisors(object sender, EventArgs e)
        {
            Response.Redirect("ViewStudentsWithAdvisors.aspx");
        }

        protected void viewPendingRequests(object sender, EventArgs e)
        {
            Response.Redirect("ViewPendingRequests.aspx");
        }

        //protected void viewAllAdvisors(object sender, EventArgs e)
        //{
        //    Response.Redirect("~/Login/Login.aspx");
        //}

        //protected void viewAllAdvisors(object sender, EventArgs e)
        //{
        //    Response.Redirect("~/Login/Login.aspx");
        //}
    }
}