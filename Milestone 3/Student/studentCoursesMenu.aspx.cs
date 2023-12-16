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
    public partial class studentCoursesMenu : System.Web.UI.Page
    {
        static String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
        static SqlConnection sqlConnection = new SqlConnection(connectstr);
        int studentId;
        int currentSemester;
        string currentSemesterCode;

        protected void Page_Load(object sender, EventArgs e)
        {  
            studentId = (int)Session["id"];
            currentSemesterCode = getCurrentSemesterCode();
            getStudentOptionalCourses(studentId);
            getStudentAvailableCourses(studentId);
            getStudentRequiredCourses(studentId);
            getStudentMissingCourses(studentId);

            //getStudentAvailableCourses(studentId);

        }
        private void getStudentOptionalCourses(int id)
        {
            SqlDataReader reader;
            string numbers = "";
            
            if (sqlConnection.State == ConnectionState.Closed)
                sqlConnection.Open();

            SqlCommand sqlCommand = new SqlCommand("Procedures_ViewOptionalCourse", sqlConnection);
            sqlCommand.CommandType = CommandType.StoredProcedure;

            sqlCommand.Parameters.AddWithValue("@StudentID", id);

            sqlCommand.Parameters.AddWithValue("@current_semester_code", currentSemesterCode);
            sqlCommand.ExecuteNonQuery();

            DataTable dataTable = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter(sqlCommand);
            adapter.Fill(dataTable);
            sqlConnection.Close();
            optionalCourses.DataSource = dataTable;
            optionalCourses.DataBind();

        }

        private void getStudentAvailableCourses(int id)
        {
            string numbers = "";
            String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
            SqlConnection c = new SqlConnection(connectstr);

            if (sqlConnection.State == ConnectionState.Closed)
                sqlConnection.Open();

            String query = "select * from dbo.FN_SemsterAvailableCourses('" + currentSemesterCode + "')";
            SqlCommand func = new SqlCommand(query, c);

            DataTable dataTable = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter(func);
            adapter.Fill(dataTable);
            sqlConnection.Close();
            availableCourses.DataSource = dataTable;
            availableCourses.DataBind();
            c.Close();

        }
        private int getStudentCurrentSemester(int id)
        {
            if (sqlConnection.State == ConnectionState.Closed)
                sqlConnection.Open();


            String query = "select semester from Student Where student_id = " + id;
            SqlCommand func = new SqlCommand(query, sqlConnection);

            currentSemester = Convert.ToInt32(func.ExecuteScalar());
            sqlConnection.Close();
            return currentSemester;

        }

        private string getCurrentSemesterCode()
        {
            if (sqlConnection.State == ConnectionState.Closed)
                sqlConnection.Open();

            DateTime currentDate = DateTime.Now.Date;

            String query = "select semester_code from Semester Where start_date<= '" + currentDate +"' AND end_date >= '"+ currentDate+"'";
            SqlCommand func = new SqlCommand(query, sqlConnection);

            currentSemesterCode = Convert.ToString(func.ExecuteScalar());
            sqlConnection.Close();
            return currentSemesterCode;

        }
        private void getStudentRequiredCourses(int id)
        {
            SqlDataReader reader;
            string numbers = "";

            if (sqlConnection.State == ConnectionState.Closed)
                sqlConnection.Open();

            SqlCommand sqlCommand = new SqlCommand("Procedures_ViewRequiredCourses", sqlConnection);
            sqlCommand.CommandType = CommandType.StoredProcedure;

            sqlCommand.Parameters.AddWithValue("@StudentID", id);

            sqlCommand.Parameters.AddWithValue("@current_semester_code", currentSemesterCode);
            sqlCommand.ExecuteNonQuery();

            DataTable dataTable = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter(sqlCommand);
            adapter.Fill(dataTable);
            sqlConnection.Close();
            requiredCourses.DataSource = dataTable;
            requiredCourses.DataBind();

        }

        private void getStudentMissingCourses(int id)
        {
            SqlDataReader reader;
            string numbers = "";

            if (sqlConnection.State == ConnectionState.Closed)
                sqlConnection.Open();

            SqlCommand sqlCommand = new SqlCommand("Procedures_ViewMS", sqlConnection);
            sqlCommand.CommandType = CommandType.StoredProcedure;

            sqlCommand.Parameters.AddWithValue("@StudentID", id);

            sqlCommand.ExecuteNonQuery();

            DataTable dataTable = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter(sqlCommand);
            adapter.Fill(dataTable);
            sqlConnection.Close();
            missingCourses.DataSource = dataTable;
            missingCourses.DataBind();

        }
        
    }
}