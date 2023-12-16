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
            string connectionString = WebConfigurationManager.ConnectionStrings["MainConnection"].ToString();
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand retriveAdvisors = new SqlCommand("select* from Student_Payment", connection);

            connection.Open();
            SqlDataReader rdr = retriveAdvisors.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                String studentID = rdr.GetInt32(rdr.GetOrdinal("studentID")).ToString();
                String f_name = rdr.GetString(rdr.GetOrdinal("f_name"));
                String l_name = rdr.GetString(rdr.GetOrdinal("l_name"));
                String semester_code = rdr.GetString(rdr.GetOrdinal("semester_code"));
                String payment_id = rdr.GetInt32(rdr.GetOrdinal("payment_id")).ToString();
                String amount = rdr.GetInt32(rdr.GetOrdinal("amount")).ToString();
                String startdate = rdr.GetDateTime(rdr.GetOrdinal("startdate")).ToString();
                String deadline = rdr.GetDateTime(rdr.GetOrdinal("deadline")).ToString();
                String n_installments = rdr.GetInt32(rdr.GetOrdinal("n_installments")).ToString();
                String fund_percentage = rdr.GetInt32(rdr.GetOrdinal("fund_percentage")).ToString();
                String status = rdr.GetInt32(rdr.GetOrdinal("status")).ToString();

                








               

                HtmlTableRow row = new HtmlTableRow();
                row.Cells.Add(new HtmlTableCell() { InnerText = studentID });
                row.Cells.Add(new HtmlTableCell() { InnerText = f_name });
                row.Cells.Add(new HtmlTableCell() { InnerText = l_name });
                row.Cells.Add(new HtmlTableCell() { InnerText = semester_code });
                row.Cells.Add(new HtmlTableCell() { InnerText = payment_id }); 
                row.Cells.Add(new HtmlTableCell() { InnerText = amount });
                row.Cells.Add(new HtmlTableCell() { InnerText = startdate });
                row.Cells.Add(new HtmlTableCell() { InnerText = deadline });
                row.Cells.Add(new HtmlTableCell() { InnerText = n_installments });
                row.Cells.Add(new HtmlTableCell() { InnerText = fund_percentage });
                row.Cells.Add(new HtmlTableCell() { InnerText = status });

                table1.Rows.Add(row);
            }
        }
          
        protected void Back(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }
    }
}