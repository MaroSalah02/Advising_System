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
    public partial class Payments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) //studentID,f_name,l_name,payment_id int,amount
                                                             //int,startdate ,deadline datetime,n_installments
                                                             //fund_percentage decimal,status number,student_id,
                                                             //semester_code string
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["con"].ToString();
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand retriveAdvisors = new SqlCommand("select* from Student_Payment", connection);
            SqlDataAdapter adapter = new SqlDataAdapter(retriveAdvisors);
            DataTable dataTable = new DataTable();
            adapter.Fill(dataTable);
            View_Students.DataSource = dataTable;
            View_Students.DataBind();
            connection.Open();
            
            
        }
          
        protected void Back(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }


    }
}