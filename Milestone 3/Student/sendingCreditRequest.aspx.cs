using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone_3.Student
{
    public partial class sendingCreditRequest : System.Web.UI.Page
    {
        static String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
        static SqlConnection sqlConnection = new SqlConnection(connectstr);
        int studentId;

        protected void Page_Load(object sender, EventArgs e)
        {
            studentId = (int)Session["id"];

            //getStudentAvailableCourses(studentId);

        }
        protected void requestbtn(object sender, EventArgs e)
        {

            if (sqlConnection.State == ConnectionState.Closed)
                sqlConnection.Open();

            if (creditNumeric.Text.Equals(""))
            {
                alert();
            }
            else
            {
                SqlCommand sqlCommand = new SqlCommand("Procedures_StudentSendingCourseRequest", sqlConnection);
                sqlCommand.CommandType = CommandType.StoredProcedure;

                sqlCommand.Parameters.AddWithValue("@StudentID", studentId);
                sqlCommand.Parameters.AddWithValue("@courseID", creditNumeric.Text);
                sqlCommand.Parameters.AddWithValue("@type", "credit_hours");

                sqlCommand.Parameters.AddWithValue("@comment", comment.Text);
                int rowsAffected = sqlCommand.ExecuteNonQuery();
                if (rowsAffected > 0)
                {
                    statuslabel.InnerText = "success";
                }
                else
                {
                    statuslabel.InnerText = "failed";

                }

                sqlConnection.Close();
            }

        }
        private void alert()
        {
            string script = "alert('There is one or more empty fields!');";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
        }
    }
}