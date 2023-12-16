using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone_3.Student
{
    public partial class updateStudentInfo : System.Web.UI.Page
    {
        static String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
        static SqlConnection sqlConnection = new SqlConnection(connectstr);
        int studentId;

        protected void Page_Load(object sender, EventArgs e)
        {
            studentId = (int)Session["id"];
            getStudentPhone(studentId);
        }
        protected void btnSaveClick(object sender, EventArgs e)
        {
            if (sqlConnection.State == ConnectionState.Closed)
                sqlConnection.Open();

            SqlCommand sqlCommand = new SqlCommand("Procedures_StudentaddMobile",sqlConnection);
            sqlCommand.CommandType = CommandType.StoredProcedure;

            sqlCommand.Parameters.AddWithValue("@StudentID", studentId);

            sqlCommand.Parameters.AddWithValue("@mobile_number", telephone_input.Text);
            sqlCommand.ExecuteNonQuery();
            sqlConnection.Close();
            Page_Load(sender,e);
        }

        private void getStudentPhone(int id)
        {
            SqlDataReader reader;
            string numbers = "";
            String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
            SqlConnection c = new SqlConnection(connectstr);

            String query = "select phone_number from Student_Phone Where student_id = " + id;
            SqlCommand cmd = new SqlCommand(query, c);

            c.Open();
            DataTable dataTable = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dataTable);
            sqlConnection.Close();
            phones.DataSource = dataTable;
            phones.DataBind();
            c.Close();

        }
    }
}