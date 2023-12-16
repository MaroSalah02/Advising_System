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

namespace Milestone_3.Admin
{
    public partial class NewRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["id"] == null || !Session["id"].Equals("-1"))
            {
                Response.Redirect("~/Login/Login.aspx");
            }
        }

        protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        protected void Register_for_student_click(object sender, EventArgs e)
        {
            String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
            SqlConnection c = new SqlConnection(connectstr);
            SqlCommand proc = new SqlCommand("Procedures_StudentRegistration", c);
            proc.CommandType = CommandType.StoredProcedure;

            if(Textb1.Text.Equals("") || Textb2.Text.Equals("") || Textb3.Text.Equals("") || Textb4.Text.Equals("") || Textb5.Text.Equals("") || Textb6.Text.Equals("") || Textb7.Text.Equals(""))
            {
                alert();
            }
            else
            {
                String first_name = Textb1.Text; 
                proc.Parameters.Add(new SqlParameter("@first_name", first_name));

                String last_name = Textb2.Text; 
                proc.Parameters.Add(new SqlParameter("@last_name", last_name));

                String password = Textb3.Text;
                proc.Parameters.Add(new SqlParameter("@password", password));

                String faculty = Textb4.Text;
                proc.Parameters.Add(new SqlParameter("@faculty", faculty));
                    
                String email = Textb5.Text;
                proc.Parameters.Add(new SqlParameter("@email", email));

                String major = Textb6.Text;
                proc.Parameters.Add(new SqlParameter("@major", major));

                int Semester = Int16.Parse(Textb7.Text);
                proc.Parameters.Add(new SqlParameter("@Semester", Semester));

                SqlParameter result = new SqlParameter("@Student_id", SqlDbType.Int);

                result.Direction = ParameterDirection.Output;

                proc.Parameters.Add(result);

                c.Open();
                    proc.ExecuteNonQuery();
                    String alert = "New student id is " + result.Value.ToString();
                    string script = "alert('"+alert+"');";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                c.Close();
            }
        }
        private void alert()
        {
            string script = "alert('There is one or more empty fields!');";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
        }

        protected void Register_for_advisor_click(object sender, EventArgs e)
        {
            String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
            SqlConnection c = new SqlConnection(connectstr);
            SqlCommand proc = new SqlCommand("Procedures_AdvisorRegistration", c);
            proc.CommandType = CommandType.StoredProcedure;

            if (Textb9.Text.Equals("") || Textb10.Text.Equals("") || Textb11.Text.Equals("") || Textb12.Text.Equals("")) 
            {
                alert();
            }
            else
            {
                String advisor_name = Textb9.Text;
                proc.Parameters.Add(new SqlParameter("@advisor_name", advisor_name));

                String password = Textb10.Text;
                proc.Parameters.Add(new SqlParameter("@password", password));

                String email = Textb11.Text;
                proc.Parameters.Add(new SqlParameter("@email", email));

                String office = Textb12.Text;
                proc.Parameters.Add(new SqlParameter("@office", office));

                SqlParameter result = new SqlParameter("@Advisor_id", SqlDbType.Int);

                result.Direction = ParameterDirection.Output;

                proc.Parameters.Add(result);

                c.Open();
                    proc.ExecuteNonQuery();
                    String alert = "New advisor id is " + result.Value.ToString();
                    string script = "alert('"+alert+"');";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                c.Close();
            }
        }

        protected void Back(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}