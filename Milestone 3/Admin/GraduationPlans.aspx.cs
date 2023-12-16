using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Milestone_3
{
    public partial class GraduationPlans : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {




        }
        protected void get(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["con"].ToString();
            SqlConnection connection = new SqlConnection(connectionString);
            try
            {
                int id = Int16.Parse(studentID.Text);
                SqlCommand retriveAdvisors = new SqlCommand("select* from FN_StudentViewGP(" + id + ")", connection);

                connection.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(retriveAdvisors);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);
                View_Students.DataSource = dataTable;
                View_Students.DataBind();
            }
            catch (FormatException)
            {
                string script = "alert('Failure, The provided field was left empty, please try again');";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
            }
            catch (OverflowException)
            {
                string script = "alert('Failure, The provided was too large, please try again');";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
            }
           }
        protected void Back(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}