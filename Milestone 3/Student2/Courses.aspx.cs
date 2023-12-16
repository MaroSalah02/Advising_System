using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal
{
    public partial class Courses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MultiView.ActiveViewIndex = 0;
        }

        protected void View(object sender, EventArgs e)
        {
            switch ((sender as Button).ID)
            {
                case "prereqButton":
                    MultiView.ActiveViewIndex = 0;
                    break;

                case "slotButton":
                    MultiView.ActiveViewIndex = 1;
                    break;
            }
        }
    }
}