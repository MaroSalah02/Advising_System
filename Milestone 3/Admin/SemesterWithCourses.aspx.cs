using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Milestone_3.Admin
{
    public partial class SemesterWithCourses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["id"] == null || !Session["id"].Equals("-1"))
            {
                Response.Redirect("~/Login/Login.aspx");
            }
            String ConnectionString = ConfigurationManager.ConnectionStrings["con"].ToString();
            SqlConnection connection = new SqlConnection(ConnectionString);

            SqlCommand retrieveSemsterWithCourses = new SqlCommand("SELECT * FROM Semster_offered_Courses", connection);


            connection.Open();
            SqlDataReader rdr = retrieveSemsterWithCourses.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                String Course_ID = rdr.GetInt32(rdr.GetOrdinal("course_id")).ToString();
                String Course_Name = rdr.GetString(rdr.GetOrdinal("name"));
                String Sem_code = rdr.GetString(rdr.GetOrdinal("semester_code"));

                HtmlTableRow row = new HtmlTableRow();
                row.Cells.Add(new HtmlTableCell() { InnerText = Sem_code });
                row.Cells.Add(new HtmlTableCell() { InnerText = Course_ID });
                row.Cells.Add(new HtmlTableCell() { InnerText = Course_Name });

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