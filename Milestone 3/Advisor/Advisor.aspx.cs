using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics.Eventing.Reader;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Net.Mime.MediaTypeNames;


namespace Milestone_3
{
    public partial class Advisor : System.Web.UI.Page
    {
        String selectedOption = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            view_div.Visible = false;
            insert_div1.Visible = false;
            insert_div2.Visible = false;
            update_div.Visible = false;
            delete_div.Visible = false;
            acc_or_rej1.Visible = false;
            int advisor_id = (int)Session["id"];
            advisor_name.InnerText = "" + get_name(advisor_id);
        }
        protected void dropdown_SelectedIndexChanged(object sender, EventArgs e)
        {
            selectedOption = dropdown.SelectedValue;
            if (selectedOption.Equals("View all requests") || selectedOption.Equals("View all pending requests") || selectedOption.Equals("View My advising students"))
            {
                Display();
            }
            else if (selectedOption.Equals("View all students assigned to from a certain major along with their taken courses"))
            {
                view_div.Visible = true;
            }
            else if (selectedOption.Equals("Insert a graduation plan for a student"))
            {
                insert_div1.Visible = true;
            }
            else if (selectedOption.Equals("Insert courses for a specific graduation plan"))
            {
                insert_div2.Visible = true;
            }
            else if (selectedOption.Equals("Update expected graduation date for a certain graduation plan"))
            {
                update_div.Visible = true;
            }
            else if (selectedOption.Equals("Delete course from a certain graduation plan in a certain semester"))
            {
                delete_div.Visible = true;
            }
            else if (selectedOption.Equals("Approve or reject extra credit hours request") || selectedOption.Equals("Approve or reject extra courses request"))
            {
                acc_or_rej1.Visible = true;
            }

        }
        private void Display()
        {
            selectedOption = dropdown.SelectedValue;
            if (selectedOption.Equals("View My advising students"))
            {
                String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
                SqlConnection c = new SqlConnection(connectstr);
                int advisor_id = (int)Session["id"];
                String query = "select * from student s where s.advisor_id = " + advisor_id;
                SqlCommand proc = new SqlCommand(query, c);
                c.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(proc);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);
                    View_Students.DataSource = dataTable;
                    View_Students.DataBind();
                c.Close();
            }
            else if (selectedOption.Equals("View all students assigned to from a certain major along with their taken courses"))
            {
                String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
                SqlConnection c = new SqlConnection(connectstr);
                SqlCommand proc = new SqlCommand("Procedures_AdvisorViewAssignedStudents", c);
                proc.CommandType = CommandType.StoredProcedure;

                int AdvisorID = (int)Session["id"];
                proc.Parameters.AddWithValue("@AdvisorID", AdvisorID);

                String major = textb1.Text;
                if(major.Equals(""))
                {
                    alert();
                }
                else{
                    proc.Parameters.Add(new SqlParameter("@major", major));

                    c.Open();
                        SqlDataAdapter adapter = new SqlDataAdapter(proc);
                        DataTable dataTable = new DataTable();
                        adapter.Fill(dataTable);
                        View_Students.DataSource = dataTable;
                        View_Students.DataBind();
                    c.Close();
                }

            }
            else if (selectedOption.Equals("View all requests"))
            {
                String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
                SqlConnection c = new SqlConnection(connectstr);

                int AdvisorID = (int)Session["id"];
                String query = "SELECT * FROM DBO.FN_Advisors_Requests("+AdvisorID+")";
                SqlCommand function = new SqlCommand(query, c);

                c.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(function);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);
                    View_Students.DataSource = dataTable;
                    View_Students.DataBind();
                c.Close();
            }
            else
            {
                String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
                SqlConnection c = new SqlConnection(connectstr);
                SqlCommand proc = new SqlCommand("Procedures_AdvisorViewPendingRequests", c);
                proc.CommandType = CommandType.StoredProcedure;

                int AdvisorID = (int)Session["id"];
                proc.Parameters.Add(new SqlParameter("@Advisor_ID", AdvisorID));

                c.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(proc);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);
                    View_Students.DataSource = dataTable;
                    View_Students.DataBind();
                c.Close();
            }
        }
        private void Insert()
        {
            selectedOption = dropdown.SelectedValue;
            if (selectedOption.Equals("Insert a graduation plan for a student"))
            {
                String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
                SqlConnection c = new SqlConnection(connectstr);
                SqlCommand proc = new SqlCommand("Procedures_AdvisorCreateGP", c);
                proc.CommandType = CommandType.StoredProcedure;

                if(textb2.Text.Equals("") || textb3.Text.Equals("") || textb4.Text.Equals("") || textb5.Text.Equals(""))
                {
                    alert();
                }
                else
                {
                    String Semester_code = textb2.Text;
                    proc.Parameters.Add(new SqlParameter("@Semester_code", Semester_code));

                    String expected_graduation_date = textb3.Text;
                    DateTime selectedDate;
                    DateTime.TryParse(expected_graduation_date, out selectedDate);
                    proc.Parameters.Add(new SqlParameter("@expected_graduation_date", selectedDate));

                    int sem_credit_hours = Int16.Parse(textb4.Text);
                    proc.Parameters.Add(new SqlParameter("@sem_credit_hours", sem_credit_hours));

                    int AdvisorID = (int)Session["id"];
                    proc.Parameters.AddWithValue("@advisor_id", AdvisorID);

                    int student_id = Int16.Parse(textb5.Text);
                    proc.Parameters.Add(new SqlParameter("@student_id", student_id));

                    try
                    {
                        c.Open();
                        int rows_affected = proc.ExecuteNonQuery();
                        if (rows_affected > 0)
                        {
                            correct_or_not.InnerText = "Status is: Done";
                        }
                        else
                        {
                            correct_or_not.InnerText = "Status is: Failed";
                        }
                        c.Close();
                    }
                    catch (Exception ex)
                    {
                        correct_or_not.InnerText = "Status is: logic error";
                    }
                }

            }
            else if (selectedOption.Equals("Insert courses for a specific graduation plan"))
            {
                String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
                SqlConnection c = new SqlConnection(connectstr);
                SqlCommand proc = new SqlCommand("Procedures_AdvisorAddCourseGP", c);
                proc.CommandType = CommandType.StoredProcedure;

                if (textb6.Text.Equals("") || textb7.Text.Equals("") || textb8.Text.Equals(""))
                {
                    alert();
                }
                else
                {
                    int student_id = Int16.Parse(textb6.Text);
                    proc.Parameters.Add(new SqlParameter("@student_id", student_id));

                    String Semester_code = textb7.Text;
                    proc.Parameters.Add(new SqlParameter("@Semester_code", Semester_code));

                    String Course_Name = textb8.Text;
                    proc.Parameters.Add(new SqlParameter("@course_name", Course_Name));
                    try
                    {
                        c.Open();
                        int rows_affected = proc.ExecuteNonQuery();
                        if (rows_affected > 0)
                        {
                            correct_or_not.InnerText = "Status is: Done";
                        }
                        else
                        {
                            correct_or_not.InnerText = "Status is: Failed";
                        }
                        c.Close();
                    }
                    catch (Exception ex)
                    {
                        correct_or_not.InnerText = "Status is: logic error";
                    }

                }

            }
        }
        protected void accept_or_reject()
        {
            if (selectedOption.Equals("Approve or reject extra credit hours request"))
            {
                selectedOption = dropdown.SelectedValue;
                String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
                SqlConnection c = new SqlConnection(connectstr);
                SqlCommand proc = new SqlCommand("Procedures_AdvisorApproveRejectCHRequest", c);
                proc.CommandType = CommandType.StoredProcedure;

                if (textb14.Text.Equals("") || textb15.Text.Equals(""))
                {
                    alert();
                }
                else
                {
                    int request_id = Int16.Parse(textb14.Text);
                    proc.Parameters.Add(new SqlParameter("@requestID", request_id));

                    String Semester_code = textb15.Text;
                    proc.Parameters.Add(new SqlParameter("@current_sem_code", Semester_code));

                    try
                    {
                        c.Open();
                        int rows_affected = proc.ExecuteNonQuery();
                        if (rows_affected > 0)
                        {
                            correct_or_not.InnerText = "Status is: Done";
                        }
                        else
                        {
                            correct_or_not.InnerText = "Status is: Failed";
                        }
                        c.Close();
                    }
                    catch (Exception ex)
                    {
                        correct_or_not.InnerText = "Status is: logic error";
                    }
                }
            }
            else
            {
                String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
                SqlConnection c = new SqlConnection(connectstr);
                SqlCommand proc = new SqlCommand("Procedures_AdvisorApproveRejectCourseRequest", c);
                proc.CommandType = CommandType.StoredProcedure;

                if (textb14.Text.Equals("") || textb15.Text.Equals(""))
                {
                    alert();
                }
                else
                {
                    int request_id = Int16.Parse(textb14.Text);
                    proc.Parameters.Add(new SqlParameter("@requestID", request_id));

                    String Semester_code = textb15.Text;
                    proc.Parameters.Add(new SqlParameter("@current_semester_code", Semester_code));

                    try
                    {
                        c.Open();
                        int rows_affected = proc.ExecuteNonQuery();
                        if (rows_affected > 0)
                        {
                            correct_or_not.InnerText = "Status is: Done";
                        }
                        else
                        {
                            correct_or_not.InnerText = "Status is: Failed";
                        }
                        c.Close();
                    }
                    catch (Exception ex)
                    {
                        correct_or_not.InnerText = "Status is: logic error";
                    }
                }

            }
        }
        protected void proceed_Click(object sender, EventArgs e)
        {
            selectedOption = dropdown.SelectedValue;
            if (selectedOption.Equals("View all students assigned to from a certain major along with their taken courses"))
            {
                Display();
            }
            else if (selectedOption.Equals("Insert a graduation plan for a student") || selectedOption.Equals("Insert courses for a specific graduation plan"))
            {
                Insert();
            }
            else if (selectedOption.Equals("Update expected graduation date for a certain graduation plan"))
            {
                String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
                SqlConnection c = new SqlConnection(connectstr);
                SqlCommand proc = new SqlCommand("Procedures_AdvisorUpdateGP", c);
                proc.CommandType = CommandType.StoredProcedure;

                if (textb9.Text.Equals("") || textb10.Text.Equals(""))
                {
                    alert();
                }
                else
                {
                    String expected_graduation_date = textb9.Text;
                    DateTime selectedDate;
                    DateTime.TryParse(expected_graduation_date, out selectedDate);
                    proc.Parameters.Add(new SqlParameter("@expected_grad_date", selectedDate));

                    int student_id = Int16.Parse(textb10.Text);
                    proc.Parameters.Add(new SqlParameter("@studentID", student_id));

                    try
                    {
                        c.Open();
                        int rows_affected = proc.ExecuteNonQuery();
                        if (rows_affected > 0)
                        {
                            correct_or_not.InnerText = "Status is: Done";
                        }
                        else
                        {
                            correct_or_not.InnerText = "Status is: Failed";
                        }
                        c.Close();
                    }
                    catch (Exception ex)
                    {
                        correct_or_not.InnerText = "Status is: logic error";
                    }
                }

            }
            else if (selectedOption.Equals("Delete course from a certain graduation plan in a certain semester"))
            {
                String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
                SqlConnection c = new SqlConnection(connectstr);
                SqlCommand proc = new SqlCommand("Procedures_AdvisorDeleteFromGP", c);
                proc.CommandType = CommandType.StoredProcedure;

                if (textb11.Text.Equals("") || textb12.Text.Equals("") || textb13.Text.Equals(""))
                {
                    alert();
                }
                else
                {
                    int student_id = Int16.Parse(textb11.Text);
                    proc.Parameters.Add(new SqlParameter("@studentID", student_id));

                    String Semester_code = textb12.Text;
                    proc.Parameters.Add(new SqlParameter("@sem_code", Semester_code));

                    int course_id = Int16.Parse(textb13.Text);
                    proc.Parameters.Add(new SqlParameter("@courseID", course_id));

                    try
                    {
                        c.Open();
                        int rows_affected = proc.ExecuteNonQuery();
                        if (rows_affected > 0)
                        {
                            correct_or_not.InnerText = "Status is: Done";
                        }
                        else
                        {
                            correct_or_not.InnerText = "Status is: Failed";
                        }
                        c.Close();
                    }
                    catch (Exception ex)
                    {
                        correct_or_not.InnerText = "Status is: logic error";
                    }
                }

            }
            else if (selectedOption.Equals("Approve or reject extra credit hours request") || selectedOption.Equals("Approve or reject extra courses request"))
            {
                accept_or_reject();
            }
        }
        protected void Reset_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.RawUrl, false);
            Context.ApplicationInstance.CompleteRequest();
        }
        private String get_name(int id)
        {
            String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
            SqlConnection c = new SqlConnection(connectstr);

            String query = "select advisor_name from advisor where advisor_id = " + id;
            SqlCommand func = new SqlCommand(query, c);

            c.Open();
                Object r = func.ExecuteScalar();
                String advisorName = r.ToString();
                return advisorName;
            c.Close();
        }
        private void alert()
        {
            string script = "alert('There is an empty field!');";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
        }
        //protected void back_to_main(object sender, EventArgs e)
        //{
        //    Response.Redirect("~/Login/login.aspx");
        //}
    }
}