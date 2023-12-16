using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone_3.Student
{
    public partial class studentMainMenu : System.Web.UI.Page
    {
        int studentId;
        protected void Page_Load(object sender, EventArgs e)
        {

            studentId = (int)Session["id"];
            student_Name.InnerText = getStudentName(studentId);

        }
        private string getStudentName(int id)
        {

            String connectstr = WebConfigurationManager.ConnectionStrings["con"].ToString();
            SqlConnection c = new SqlConnection(connectstr);

            String query = "select f_name from Student Where student_id = " + id;
            SqlCommand func = new SqlCommand(query, c);

            c.Open();
            return Convert.ToString(func.ExecuteScalar());
            c.Close();

        }
    }
}