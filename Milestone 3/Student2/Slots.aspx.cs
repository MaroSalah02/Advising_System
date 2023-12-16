using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.InteropServices;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal
{
    public partial class Instructor : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["con"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void View(object sender, EventArgs e)
        {
            String courseText = courseIDup.Text;
            String instructorText = instructorIDup.Text;

            int course, instructor;
            try
            {
                course = Int16.Parse(courseText);
                instructor = Int16.Parse(instructorText);
            }
            catch (FormatException)
            {
                slotResult.Text = "Format Error: Invalid Course ID Or Instructor ID!";
                return;
            }

            String query = "SELECT CourseID as [Course ID], Course as [Course Name], slot_id as [Slot ID]," +
                "day as [Day], time as [Time], location as [Location], instructor_id as [Instructor ID]," +
                $"Instructor as [Instructor Name] FROM dbo.FN_StudentViewSlot({course}, {instructor}) ORDER BY CourseID";
            SqlCommand function = new SqlCommand(query, conn);

            conn.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(function);
            DataTable slotData = new DataTable();
            adapter.Fill(slotData);
            slotTable.DataSource = slotData;
            slotTable.DataBind();
            conn.Close();

            slotResult.Text = "Operation Success: Data Fetched!";
        }

        protected void Choose(object sender, EventArgs e)
        {
            int student = (int)Session["id"];
            String courseText = courseIDdown.Text;
            String instructorText = instructorIDdown.Text;
            String semester = semesterID.Text;

            int course, instructor;
            try
            {
                course = Int16.Parse(courseText);
                instructor = Int16.Parse(instructorText);
            }
            catch (FormatException)
            {
                chooseResult.Text = "Format Error: Invalid Course ID Or Instructor ID!";
                return;
            }

            if (string.IsNullOrEmpty(semester))
            {
                chooseResult.Text = "Format Error: Invalid Semester ID!";
                return;
            }

            SqlCommand proc = new SqlCommand("Procedures_ChooseInstructor", conn);
            proc.CommandType = CommandType.StoredProcedure;

            proc.Parameters.AddWithValue("@StudentID", student);
            proc.Parameters.AddWithValue("@courseID", course);
            proc.Parameters.AddWithValue("@instrucorID", instructor);
            proc.Parameters.AddWithValue("@current_semester_code", semester);

            conn.Open();

            if (proc.ExecuteNonQuery() < 1)
            {
                chooseResult.Text = "Operation Fail: Invalid Data Provided!";
            }
            else
            {
                chooseResult.Text = "Operation Success: Instructor Picked!";
            }
            conn.Close();
        }
    }
}
