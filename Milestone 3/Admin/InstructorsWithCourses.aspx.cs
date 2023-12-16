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
    public partial class InstructorsWithCourses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["id"] == null || !Session["id"].Equals("-1"))
            {
                Response.Redirect("~/Login/Login.aspx");
            }
            String ConnectionString = ConfigurationManager.ConnectionStrings["con"].ToString();
            SqlConnection connection = new SqlConnection(ConnectionString);

            SqlCommand retrieveInstructorsWithCourses = new SqlCommand("SELECT * FROM Instructors_AssignedCourses", connection);


            connection.Open();
            SqlDataReader rdr = retrieveInstructorsWithCourses.ExecuteReader(CommandBehavior.CloseConnection);

            while (rdr.Read())
            {
                String instructor_id = rdr.GetInt32(rdr.GetOrdinal("instructor_id")).ToString();
                String instructor_name = rdr.GetString(rdr.GetOrdinal("Instructor"));
                String course_id = rdr.GetInt32(rdr.GetOrdinal("course_id")).ToString();
                String course_name = rdr.GetString(rdr.GetOrdinal("Course"));

                HtmlTableRow row = new HtmlTableRow();
                row.Cells.Add(new HtmlTableCell() { InnerText = instructor_id });
                row.Cells.Add(new HtmlTableCell() { InnerText = instructor_name });
                row.Cells.Add(new HtmlTableCell() { InnerText = course_id });
                row.Cells.Add(new HtmlTableCell() { InnerText = course_name });

                table1.Rows.Add(row);
            }
        }

        protected void Back(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}