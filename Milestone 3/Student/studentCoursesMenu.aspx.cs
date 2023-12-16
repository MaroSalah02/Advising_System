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
        int currentSemesterCode;
        protected void Page_Load(object sender, EventArgs e)
        {
            studentId = (int)Session["id"];
            getStudentOptionalCourses(studentId);
            getStudentAvailableCourses(studentId);

        }
        private void getStudentOptionalCourses(int id)
        {
            SqlDataReader reader;
            string numbers = "";
            String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
            SqlConnection c = new SqlConnection(connectstr);

            if (sqlConnection.State == ConnectionState.Closed)
                sqlConnection.Open();

            SqlCommand sqlCommand = new SqlCommand("Procedures_ViewOptionalCourse", sqlConnection);
            sqlCommand.CommandType = CommandType.StoredProcedure;

            sqlCommand.Parameters.AddWithValue("@StudentID", id);

            sqlCommand.Parameters.AddWithValue("@current_semester_code", getStudentCurrentSemester(id));
            sqlCommand.ExecuteNonQuery();

            DataTable dataTable = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter(sqlCommand);
            adapter.Fill(dataTable);
            sqlConnection.Close();
            optionalCourses.DataSource = dataTable;
            optionalCourses.DataBind();
            c.Close();

        }

        private void getStudentAvailableCourses(int id)
        {
            string numbers = "";
            String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
            SqlConnection c = new SqlConnection(connectstr);

            if (sqlConnection.State == ConnectionState.Closed)
                sqlConnection.Open();

            String query = "select dbo.FN_SemsterAvailableCourses(" + getStudentCurrentSemester(id)+")";
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

            String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
            SqlConnection c = new SqlConnection(connectstr);

            String query = "select semester from Student Where student_id = " + id;
            SqlCommand func = new SqlCommand(query, c);

            c.Open();
            currentSemesterCode = Convert.ToInt32(func.ExecuteScalar());
            c.Close();
            return currentSemesterCode;

        }

        private int getSCurrentSemesterCode(int id)
        {

            String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
            SqlConnection c = new SqlConnection(connectstr);
            DateTime currentDate = DateTime.Now.Date;

            String query = "select semester from Semester Where student_id = " + id;
            SqlCommand func = new SqlCommand(query, c);

            c.Open();
            currentSemesterCode = Convert.ToInt32(func.ExecuteScalar());
            c.Close();
            return currentSemesterCode;

        }
    }
}