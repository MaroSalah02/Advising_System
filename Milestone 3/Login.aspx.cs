using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Net.Mime.MediaTypeNames;

namespace Milestone_3
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            int id;
            if (RadioButtonList1.SelectedItem.Text == "Advisor")
            {
                String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
                SqlConnection c = new SqlConnection(connectstr);

                id = Int16.Parse(TextBox1.Text);
                String password = TextBox2.Text;

                String query = "select dbo.FN_AdvisorLogin("+id+",N'"+password+"')";
                SqlCommand func = new SqlCommand(query, c);
                
                c.Open();
                    bool result = Convert.ToBoolean(func.ExecuteScalar());
                c.Close();
                if (!result)
                {
                    Response.Write("not valid");
                }
                else
                {
                    Session["id"] = id;  
                    
                    //HttpContext h = HttpContext.Current;
                    //Response.Write(h.Session["id"]);

                    //Response.Redirect();
                }
            }
            else
            {
                String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
                SqlConnection c = new SqlConnection(connectstr);

                id = Int16.Parse(TextBox1.Text);
                String password = TextBox2.Text;

                String query = "select dbo.FN_StudentLogin(" + id + ",N'" + password + "')";
                SqlCommand func = new SqlCommand(query, c);

                c.Open();
                bool result = Convert.ToBoolean(func.ExecuteScalar());
                c.Close();
                if (!result)
                {
                    Response.Write("not valid");
                }
                else
                {
                    Session["id"] = id;

                    //HttpContext h = HttpContext.Current;
                    //Response.Write(h.Session["id"]);

                    //Response.Redirect();
                }

            }
        }
        protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}