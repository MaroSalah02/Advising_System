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
    public partial class admin2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["MainConnection"].ToString();
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand retriveAdvisors = new SqlCommand("select* from  view_Students ", connection);

            connection.Open();
            SqlDataReader rdr = retriveAdvisors.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                String student_ID = rdr.GetInt32(rdr.GetOrdinal("student_id")).ToString();
                String f_name = rdr.GetString(rdr.GetOrdinal("f_name"));
                String l_name = rdr.GetString(rdr.GetOrdinal("l_name"));
                String password = rdr.GetString(rdr.GetOrdinal("password"));
                String gpa = rdr.GetDecimal(rdr.GetOrdinal("gpa")).ToString();
                String faculty = rdr.GetString(rdr.GetOrdinal("faculty")).ToString();
                String email = rdr.GetString(rdr.GetOrdinal("email")).ToString();
                String  major= rdr.GetString(rdr.GetOrdinal("major")).ToString();
                String financial_status = rdr.GetBoolean(rdr.GetOrdinal("financial_status")).ToString();
                String semster = rdr.GetInt32(rdr.GetOrdinal("semester")).ToString();
                String acquired_hours = rdr.GetInt32(rdr.GetOrdinal("acquired_hours")).ToString();
                String assigned_hours = rdr.GetInt32(rdr.GetOrdinal("assigned_hours")).ToString();
                String advisor_id = rdr.GetInt32(rdr.GetOrdinal("advisor_id")).ToString();












                HtmlTableRow row = new HtmlTableRow();
                row.Cells.Add(new HtmlTableCell() { InnerText = student_ID });
                row.Cells.Add(new HtmlTableCell() { InnerText = f_name });
                row.Cells.Add(new HtmlTableCell() { InnerText = l_name });
                row.Cells.Add(new HtmlTableCell() { InnerText = password });
                row.Cells.Add(new HtmlTableCell() { InnerText = gpa });
                row.Cells.Add(new HtmlTableCell() { InnerText = faculty });
                row.Cells.Add(new HtmlTableCell() { InnerText = email });
                row.Cells.Add(new HtmlTableCell() { InnerText = major });
                row.Cells.Add(new HtmlTableCell() { InnerText = financial_status });
                row.Cells.Add(new HtmlTableCell() { InnerText = semster });
                row.Cells.Add(new HtmlTableCell() { InnerText = acquired_hours });
                row.Cells.Add(new HtmlTableCell() { InnerText = assigned_hours });
                row.Cells.Add(new HtmlTableCell() { InnerText = advisor_id });


                table1.Rows.Add(row);
            }
        }
        protected void Back(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
  

}