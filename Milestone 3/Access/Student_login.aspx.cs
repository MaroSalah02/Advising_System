using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone_3.Access
{
    public partial class Student_login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            int id;
            String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
            SqlConnection c = new SqlConnection(connectstr);


            if (TextBox1.Text.Equals("") || TextBox2.Text.Equals(""))
            {
                status.InnerText = "Empty Entries";
            }
            else
            {
                id = Int16.Parse(TextBox1.Text);
                String password = TextBox2.Text;

                String query = "select dbo.FN_StudentLogin(" + id + ",N'" + password + "')";
                SqlCommand func = new SqlCommand(query, c);

                c.Open();
                bool result = Convert.ToBoolean(func.ExecuteScalar());
                c.Close();
                if (!result)
                {
                    status.InnerText = "Wrong Entries";
                }
                else
                {
                    Session["id"] = id;
                    Response.Redirect("~/Student/studentMainMenu.aspx");
                }
            }
        }
    }
}