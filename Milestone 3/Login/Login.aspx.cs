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
            if (TextBox1.Text == "0" && TextBox2.Text == "admin")
            {
                Session["id"] = "-1";
                Response.Redirect("~/Admin/Home.aspx");
            }
            int id;
            if (RadioButtonList1.SelectedItem.Text == "Advisor")
            {
                
                String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
                SqlConnection c = new SqlConnection(connectstr);

                if(TextBox1.Text.Equals("") || TextBox2.Text.Equals(""))
                {
                    alert();
                }
                else
                {
                    id = Int16.Parse(TextBox1.Text);
                    String password = TextBox2.Text;

                    String query = "select dbo.FN_AdvisorLogin(" + id + ",N'" + password + "')";
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
                        Response.Redirect("~/Advisor/Advisor.aspx");
                    }
                }
            }
            else
            {
                String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
                SqlConnection c = new SqlConnection(connectstr);


                if (TextBox1.Text.Equals("") || TextBox2.Text.Equals(""))
                {
                    alert();
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
                        Response.Write("not valid");
                    }
                    else
                    {
                        Session["id"] = id;
                        Response.Redirect("~/Student/studentMainMenu.aspx");
                        //HttpContext h = HttpContext.Current;
                        //Response.Write(h.Session["id"]);

                        //Response.Redirect();
                    }
                }
            }
        }
        private void alert()
        {
            string script = "alert('There is one or more empty fields!');";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
        }
    }
}