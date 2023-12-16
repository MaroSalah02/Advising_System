using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Web.Configuration;

namespace Portal
{
    public partial class Graduation : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["con"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            int student = 1;
            
            String queryGrad = "SELECT student_id as [Student ID], Student_name as [Student Name], advisor_id as [Advisor ID], plan_id as [Plan ID]," +
                "expected_grad_date as [Expected Graduation], semester_code as [Semester], semester_credit_hours as [Semester Credit Hours]," +
                $"course_id as [Course ID], name as [Course Name] FROM dbo.FN_StudentViewGP({student}) ORDER BY course_id";
            SqlCommand functionGrad = new SqlCommand(queryGrad, conn);

            String instCol = "SELECT TOP 1 I.startdate as [Installment Start Date], I.deadline as [Installment Deadline]," +
                "I.amount as [Due Amount], I.status as [Status]";
            String payCol = "SELECT TOP 1 P.payment_id as [Payment ID], P.startdate as [Payment Start Date]," +
                "P.deadline as [Payment Deadline], P.amount as [Total Amount], P.n_installments as [Installments]," +
                "P.status as [Status], P.fund_percentage as [Fund Percentage], P.student_id as [Student ID]," +
                "P.semester_code as [Semester Code]";
            String queryPay = $" FROM Installment I JOIN Payment P ON P.payment_id = I.payment_id AND P.student_id = {student} AND" +
                " I.status = 'notpaid' WHERE I.deadline > CURRENT_TIMESTAMP ORDER BY I.deadline";

            SqlCommand functionInst = new SqlCommand(instCol + queryPay, conn);
            SqlCommand functionPay = new SqlCommand(payCol + queryPay, conn);

            conn.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(functionGrad);
            DataTable gradData = new DataTable();
            adapter.Fill(gradData);
            gradTable.DataSource = gradData;
            gradTable.DataBind();

            adapter = new SqlDataAdapter(functionInst);
            DataTable instData = new DataTable();
            adapter.Fill(instData);
            instTable.DataSource = instData;
            instTable.DataBind();

            adapter = new SqlDataAdapter(functionPay);
            DataTable payData = new DataTable();
            adapter.Fill(payData);
            payTable.DataSource = payData;
            payTable.DataBind();
            conn.Close();
        }
    }
}