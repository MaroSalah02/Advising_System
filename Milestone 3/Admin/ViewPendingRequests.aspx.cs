using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Milestone_3.Admin
{
    public partial class ViewPendingRequest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String ConnectionString = ConfigurationManager.ConnectionStrings["MainConnection"].ToString();
            SqlConnection connection = new SqlConnection(ConnectionString);

            SqlCommand retrievePendingRequest = new SqlCommand("SELECT * FROM all_Pending_Requests", connection);
            //retrievePendingRequest.CommandType = CommandType.StoredProcedure;

            connection.Open();
            SqlDataReader rdr = retrievePendingRequest.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                String credit_hours;
                String course_id;

                String request_id = rdr.GetInt32(rdr.GetOrdinal("request_id")).ToString();
                String type = rdr.GetString(rdr.GetOrdinal("type"));
                String comment = rdr.GetString(rdr.GetOrdinal("comment"));
                String status = rdr.GetString(rdr.GetOrdinal("status"));
                try { 
                    credit_hours = rdr.GetInt32(rdr.GetOrdinal("credit_hours")).ToString();
                } catch (SqlNullValueException) 
                {
                    credit_hours = "-";
                }
                try
                {
                    course_id = rdr.GetInt32(rdr.GetOrdinal("course_id")).ToString();
                }
                catch (SqlNullValueException)
                {
                    course_id = "-";
                }
                String student_id = rdr.GetInt32(rdr.GetOrdinal("student_id")).ToString();
                String advisor_id = rdr.GetInt32(rdr.GetOrdinal("advisor_id")).ToString();

                HtmlTableRow row = new HtmlTableRow();
                row.Cells.Add(new HtmlTableCell() { InnerText = request_id });
                row.Cells.Add(new HtmlTableCell() { InnerText = type });
                row.Cells.Add(new HtmlTableCell() { InnerText = comment });
                row.Cells.Add(new HtmlTableCell() { InnerText = status });
                row.Cells.Add(new HtmlTableCell() { InnerText = credit_hours });
                row.Cells.Add(new HtmlTableCell() { InnerText = course_id });
                row.Cells.Add(new HtmlTableCell() { InnerText = student_id });
                row.Cells.Add(new HtmlTableCell() { InnerText = advisor_id });

                table1.Rows.Add(row);
            }
            connection.Close();
        }

        protected void Back(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}