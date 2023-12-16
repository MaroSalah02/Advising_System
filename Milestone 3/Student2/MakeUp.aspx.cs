using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing.Printing;

namespace Portal
{
    public partial class MakeUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Register(object sender, EventArgs e)
        {
            int student = (int)Session["id"];
            String courseText = courseID.Text;
            String semester = semesterID.Text;
            String type = examType.SelectedValue;

            int course;
            try
            {
                course = Int16.Parse(courseText);
            }
            catch (FormatException)
            {
                result.Text = "Data Error: Invalid Course ID!";
                return;
            }

            if (string.IsNullOrEmpty(semester))
            {
                result.Text = "Data Error: Invalid Semester ID!";
                return;
            }

            String connStr = WebConfigurationManager.ConnectionStrings["Server"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            if (type == "First")
            {
                SqlCommand proc = new SqlCommand("Procedures_StudentRegisterFirstMakeup", conn);
                proc.CommandType = CommandType.StoredProcedure;

                proc.Parameters.AddWithValue("@StudentID", student);
                proc.Parameters.AddWithValue("@courseID", course);
                proc.Parameters.AddWithValue("@studentCurr_sem", semester);

                conn.Open();
                if (proc.ExecuteNonQuery() < 1)
                {
                    result.Text = "Registeration Fail: Invalid Data Or Duplicate Enrollment!";
                }
                else
                {
                    result.Text = "Resigeration Success: Enrollment Complete!";
                }
                conn.Close();
            }
            else
            {
                String query = $"SELECT dbo.FN_StudentCheckSMEligibility({student},{course})";
                SqlCommand function = new SqlCommand(query, conn);

                conn.Open();
                if (Convert.ToBoolean(function.ExecuteScalar()))
                {
                    SqlCommand proc = new SqlCommand("Procedures_StudentRegisterSecondMakeup", conn);
                    proc.CommandType = CommandType.StoredProcedure;

                    proc.Parameters.AddWithValue("@StudentID", student);
                    proc.Parameters.AddWithValue("@courseID", course);
                    proc.Parameters.AddWithValue("@studentCurr_sem", semester);

                    proc.ExecuteNonQuery();

                    result.Text = "Registeration Success: Enrollment Complete!";
                }
                else
                {
                    result.Text = "Registeration Fail: Did Not Meet Eligibility Criteria!";
                }
                conn.Close();
            }
        }
    }
}