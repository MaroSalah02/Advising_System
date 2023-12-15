using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Milestone_3.Admin
{
    public partial class ViewAdvisors : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["MainConnection"].ToString();
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand retriveAdvisors = new SqlCommand("Procedures_AdminListAdvisors", connection);
            retriveAdvisors.CommandType = CommandType.StoredProcedure;

            connection.Open();
            SqlDataReader rdr = retriveAdvisors.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                String advisor_id = rdr.GetInt32(rdr.GetOrdinal("advisor_id")).ToString();
                String advisor_name = rdr.GetString(rdr.GetOrdinal("advisor_name"));
                String email = rdr.GetString(rdr.GetOrdinal("email"));
                String office = rdr.GetString(rdr.GetOrdinal("office"));
                String password = rdr.GetString(rdr.GetOrdinal("password"));
                //Label ID = new Label();
                //Label Name = new Label();
                //Label Email = new Label();
                //Label Office = new Label();
                //Label Password = new Label();
                //ID.Text = advisor_id;
                //Name.Text = advisor_name;
                //Email.Text = email;
                //Office.Text = office;
                //Password.Text = password + "<br>";
                //form1.Controls.Add(ID);
                //form1.Controls.Add(Name);
                //form1.Controls.Add(Email);
                //form1.Controls.Add(Office);
                //form1.Controls.Add(Password);

                HtmlTableRow row = new HtmlTableRow();
                row.Cells.Add(new HtmlTableCell() { InnerText = advisor_id });
                row.Cells.Add(new HtmlTableCell() { InnerText = advisor_name });
                row.Cells.Add(new HtmlTableCell() { InnerText = email });
                row.Cells.Add(new HtmlTableCell() { InnerText = office });
                row.Cells.Add(new HtmlTableCell() { InnerText = password });

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