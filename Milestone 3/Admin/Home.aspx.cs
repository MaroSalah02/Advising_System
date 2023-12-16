using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone_3.Admin
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void viewAllAdvisors(object sender, EventArgs e)
        { 
            Response.Redirect("ViewAdvisors.aspx");
        }

        protected void viewStudentsWithAdvisors(object sender, EventArgs e)
        {
            Response.Redirect("ViewStudentsWithAdvisors.aspx");
        }

        protected void viewPendingRequests(object sender, EventArgs e)
        {
            Response.Redirect("ViewPendingRequests.aspx");
        }
        protected void deleteCourse(object sender, EventArgs e)//(needs more testing)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["MainConnection"].ToString();
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand delete = new SqlCommand("Procedures_AdminDeleteCourse", connection);
            int id = Int16.Parse(c_id.Text);
            delete.CommandType = CommandType.StoredProcedure;
            delete.Parameters.Add(new SqlParameter("@courseID", id));
            connection.Open();
            delete.ExecuteNonQuery();
            connection.Close();
            Response.Write("done");
        }
        protected void deleteSlot(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["MainConnection"].ToString();
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand delete = new SqlCommand("Procedures_AdminDeleteSlots", connection);
            int id = Int16.Parse(semster_id.Text);
            delete.CommandType = CommandType.StoredProcedure;
            delete.Parameters.Add(new SqlParameter("@current_semester", id));
            connection.Open();
            delete.ExecuteNonQuery();
            connection.Close();
            Response.Write("done");
        }
        protected void addExam(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["MainConnection"].ToString();
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand add = new SqlCommand("Procedures_AdminAddExam", connection);
            String Type = type.Text;
            String date_time = date.Text;
            int id = Int16.Parse(courseID.Text);
            add.CommandType = CommandType.StoredProcedure;
            add.Parameters.Add(new SqlParameter("@Type", Type));
            add.Parameters.Add(new SqlParameter("@date", date_time));
            add.Parameters.Add(new SqlParameter("@courseID", id));
            connection.Open();
            add.ExecuteNonQuery();
            connection.Close();
            Response.Write("done");
        }

        protected void viewPayments(object sender, EventArgs e)
        {
            Response.Redirect("Payments.aspx");
        }
        protected void issuePayment(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["MainConnection"].ToString();
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand issue = new SqlCommand("Procedures_AdminIssueInstallment", connection);
            int id = Int16.Parse(payment_id.Text);
            issue.CommandType = CommandType.StoredProcedure;
            issue.Parameters.Add(new SqlParameter("@payment_id", id));
            connection.Open();
            issue.ExecuteNonQuery();
            connection.Close();
            Response.Write("done");
        }

        protected void updateStatus(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["MainConnection"].ToString();
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand update = new SqlCommand("FN_AdminCheckStudentStatus", connection);
            int id = Int16.Parse(payment_id.Text);
            update.CommandType = CommandType.StoredProcedure;
            update.Parameters.Add(new SqlParameter("@Student_id", id));
            connection.Open();
            update.ExecuteNonQuery();
            connection.Close();
            Response.Write("done");
        }

        //protected void viewAllAdvisors(object sender, EventArgs e)
        //{
        //    Response.Redirect("~/Login/Login.aspx");
        //}

        //protected void viewAllAdvisors(object sender, EventArgs e)
        //{
        //    Response.Redirect("~/Login/Login.aspx");
        //}
    }
}