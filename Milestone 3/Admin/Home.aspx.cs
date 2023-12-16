using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.SqlServer.Server;
using System.Configuration;

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

        protected void viewInstructirsWithAssignedCourses(object sender, EventArgs e)
        {
            Response.Redirect("InstructorsWithCourses.aspx");
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

        protected void addSemester(object sender, EventArgs e)
        {
            String connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand createSemester = new SqlCommand("AdminAddingSemester", connection);
            createSemester.CommandType = CommandType.StoredProcedure;

            createSemester.Parameters.Add(new SqlParameter("@start_date", e_input1.Value));
            createSemester.Parameters.Add(new SqlParameter("@end_date", e_input2.Value));
            createSemester.Parameters.Add(new SqlParameter("@semester_code", e_input3.Text));


            connection.Open();
            e_message_box.Text = "";
            if (e_input1.Value.Equals("") || e_input2.Value.Equals("") || e_input3.Text.Equals(""))
                e_message_box.Text = "Failure, one of the provided boxes was left empty, please fill it and try again";
            else if (DateTime.Parse(e_input2.Value) < DateTime.Parse(e_input1.Value))
                e_message_box.Text = "Failure, the end date is before the start date, please try again";
            else
            {
                try
                {
                    createSemester.ExecuteNonQuery();
                    e_message_box.Text = "Success, the semester was added";
                }
                catch (SqlException)
                {
                    e_message_box.Text = "Failure, the semester code already exists, please try again";
                }
            }
            connection.Close();
        }

        protected void addCourse(object sender, EventArgs e)
        {
            String connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand createCourse = new SqlCommand("Procedures_AdminAddingCourse", connection);
            createCourse.CommandType = CommandType.StoredProcedure;

            createCourse.Parameters.Add(new SqlParameter("@major", f_input1.Text));
            createCourse.Parameters.Add(new SqlParameter("@semester", f_input2.Value));
            createCourse.Parameters.Add(new SqlParameter("@credit_hours", f_input3.Value));
            createCourse.Parameters.Add(new SqlParameter("@name", f_input4.Text));
            createCourse.Parameters.Add(new SqlParameter("@is_offered", f_input5.Checked));
            //createCourse.Parameters.Add(new SqlParameter("@is_offered", is_offered.Text));


            connection.Open();
            f_message_box.Text = "";
            if (f_input1.Text == "" || f_input4.Text == "" || f_input2.Value == "" || f_input3.Value == "")
                f_message_box.Text = "Failure, one of the provided boxes was left empty, please fill it and try again";
            else
            {
                createCourse.ExecuteNonQuery();
                f_message_box.Text = "Success, the Course was added";
            }
            connection.Close();
        }

        protected void linkInstructorWithCourseOnSlot(object sender, EventArgs e)
        {
            String ConnectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
            SqlConnection connection = new SqlConnection(ConnectionString);

            SqlCommand linkInstructorWithCourseOnSlot = new SqlCommand("Procedures_AdminLinkInstructor", connection);
            linkInstructorWithCourseOnSlot.CommandType = CommandType.StoredProcedure;

            linkInstructorWithCourseOnSlot.Parameters.Add(new SqlParameter("@instructor_id", g_input2.Value));
            linkInstructorWithCourseOnSlot.Parameters.Add(new SqlParameter("@cours_id", g_input1.Value));
            linkInstructorWithCourseOnSlot.Parameters.Add(new SqlParameter("@slot_id", g_input3.Value));
            connection.Open();
            g_message_box.Text = "";
            if (g_input1.Value == "" || g_input2.Value == "" || g_input3.Value == "")
                g_message_box.Text = "Failure, one of the provided boxes was left empty, please fill it and try again";
            else
            {
                try
                {
                    if (linkInstructorWithCourseOnSlot.ExecuteNonQuery() == 0)
                        g_message_box.Text = "Failure, this slot does not exist";
                    else
                        g_message_box.Text = "Success, the Instructor was linked with the Course on the Slot";
                }
                catch (SqlException ex)
                {
                    if (ex.Message.Contains("FOREIGN KEY constraint \"FK__Slot__course_id"))
                        g_message_box.Text = "Failure, the entered course does not exist, please try again";
                    else
                        g_message_box.Text = "Failure, the entered instructor does not exist, please try again";

                    //form1.Controls.Add(new Label { Text =  ex.Message});
                }
            }
            connection.Close();
        }

        protected void linkStudentWithAdvisor(object sender, EventArgs e)
        {
            String ConnectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
            SqlConnection connection = new SqlConnection(ConnectionString);

            SqlCommand linkStudentWithAdvisor = new SqlCommand("Procedures_AdminLinkStudentToAdvisor", connection);
            linkStudentWithAdvisor.CommandType = CommandType.StoredProcedure;

            linkStudentWithAdvisor.Parameters.Add(new SqlParameter("@studentID", h_input1.Value));
            linkStudentWithAdvisor.Parameters.Add(new SqlParameter("@advisorID", h_input2.Value));
            connection.Open();
            h_message_box.Text = "";
            if (h_input1.Value == "" || h_input2.Value == "")
                h_message_box.Text = "Failure, one of the provided boxes was left empty, please fill it and try again";
            else
            {
                try
                {
                    if (linkStudentWithAdvisor.ExecuteNonQuery() == 0)
                        h_message_box.Text = "Failure, the entered student does not exist, please try again";
                    else
                        h_message_box.Text = "Success, the Student was linked with the Advisor";
                }
                catch (SqlException)
                {
                    h_message_box.Text = "Failure, the entered advisor does not exist, please try again";
                }
            }

        }

        protected void linkStudentWithCourseWithInstructor(object sender, EventArgs e)
        {
            String ConnectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
            SqlConnection connection = new SqlConnection(ConnectionString);

            SqlCommand linkStudentWithCourseWithInstructor = new SqlCommand("Procedures_AdminLinkStudent", connection);
            linkStudentWithCourseWithInstructor.CommandType = CommandType.StoredProcedure;

            linkStudentWithCourseWithInstructor.Parameters.Add(new SqlParameter("@cours_id", i_input1.Value));
            linkStudentWithCourseWithInstructor.Parameters.Add(new SqlParameter("@instructor_id", i_input2.Value));
            linkStudentWithCourseWithInstructor.Parameters.Add(new SqlParameter("@studentID", i_input3.Value));
            linkStudentWithCourseWithInstructor.Parameters.Add(new SqlParameter("@semester_code", i_input4.Text));

            connection.Open();
            i_message_box.Text = "";
            if (i_input1.Value == "" || i_input2.Value == "" || i_input3.Value == "" || i_input4.Text == "")
                i_message_box.Text = "Failure, one of the provided boxes was left empty, please fill it and try again";
            else
            {
                try
                {
                    linkStudentWithCourseWithInstructor.ExecuteNonQuery();
                    i_message_box.Text = "Success, the Student was assigned the Course with the Instructor";
                }
                catch (SqlException ex)
                {
                    if (ex.Message.Contains("FOREIGN KEY constraint \"FK__Student_I__stude"))
                        i_message_box.Text = "Failure, the entered student does not exist, please try again";
                    if (ex.Message.Contains("FOREIGN KEY constraint \"FK__Student_I__cours__3D5E1FD2\""))
                        i_message_box.Text = "Failure, the entered course does not exist, please try again";
                    if (ex.Message.Contains("FOREIGN KEY constraint \"FK__Student_I__instr"))
                        i_message_box.Text = "Failure, the entered instructor does not exist, please try again";
                    if (ex.Message.Contains("duplicate key"))
                        i_message_box.Text = "Failure, the entered student is already assigned this course, please try again";
                }
            }
        }
    }
}