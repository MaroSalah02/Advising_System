using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;

namespace Milestone_3.Admin
{
    public partial class ViewStudentsWithAdvisors : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["id"] == null || !Session["id"].Equals("-1"))
            {
                Response.Redirect("~/Login/Login.aspx");
            }
            string connectionString = WebConfigurationManager.ConnectionStrings["con"].ToString();
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand retriveStudentWithAdvisors = new SqlCommand("AdminListStudentsWithAdvisors", connection);
            retriveStudentWithAdvisors.CommandType = CommandType.StoredProcedure;

            connection.Open();
            SqlDataReader rdr = retriveStudentWithAdvisors.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                String student_id = rdr.GetInt32(rdr.GetOrdinal("student_id")).ToString();
                String f_name = rdr.GetString(rdr.GetOrdinal("f_name"));
                String l_name = rdr.GetString(rdr.GetOrdinal("l_name"));
                String advisor_id = rdr.GetInt32(rdr.GetOrdinal("advisor_id")).ToString();
                String advisor_name = rdr.GetString(rdr.GetOrdinal("advisor_name"));

                HtmlTableRow row = new HtmlTableRow();
                row.Cells.Add(new HtmlTableCell() { InnerText = student_id });
                row.Cells.Add(new HtmlTableCell() { InnerText = f_name });
                row.Cells.Add(new HtmlTableCell() { InnerText = l_name });
                row.Cells.Add(new HtmlTableCell() { InnerText = advisor_id });
                row.Cells.Add(new HtmlTableCell() { InnerText = advisor_name });

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