<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Milestone_3.Admin.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        Button_Group{
            border: 1px solid black;
        }
    </style>
</head>
<body>
    <h1>Welcome Admin</h1>
    <h2>Please Choose an Operation</h2>
    <form runat="server">
        <div >
            <h3>View Information</h3>
            <div class="Button_Group" style="text-align:center">
                <asp:Button ID="Button_1B" runat="server" Text="View all Advisors" onclick="viewAllAdvisors"/>
                <asp:Button ID="Button_1C" runat="server" Text="View all Students With Advisors" onclick="viewStudentsWithAdvisors"/>
                <asp:Button ID="Button_1D" runat="server" Text="View all Pending Requests" onclick="viewPendingRequests"/>
                <asp:Button ID="Button_1J" runat="server" Text="View Instructirs With Their Assigned Courses" onclick="viewInstructirsWithAssignedCourses"/>
                <asp:Button ID="Button2" runat="server" Text="View details for all payments with students" onClick="viewPayments" />
            </div>

            <h3>Add Information</h3>
            <div>
                <label>Create a New Semester</label>
                <div>
                    <input runat="server" type="date" placeholder="Start Date" id="e_input1" />
                    <input runat="server" type="date" placeholder="End Date" id="e_input2" />
                    <asp:TextBox runat="server" ID="e_input3" placeholder="Semester Code"></asp:TextBox>
                    <asp:TextBox runat="server" ID="e_message_box" ReadOnly="true"></asp:TextBox>
                    <asp:Button runat="server" di="Button_1E" OnClick="addSemester" Text="Add Semester" />
                </div>
                <label>Create a New Course</label>
                <div>
                    <asp:TextBox runat="server" ID="f_input1" placeholder="Major"></asp:TextBox>
                    <input runat="server" type="number" min="0" id="f_input2" placeholder="Semester No." />
                    <input runat="server" type="number" min="0" id="f_input3" placeholder="Credit Hours" />
                    <asp:TextBox runat="server" ID="f_input4" placeholder="Course Name"></asp:TextBox>
                    <label>The Course is Offered</label>
                    <input type="checkbox" runat="server" id="f_input5" />
                    <asp:TextBox runat="server" ID="f_message_box" ReadOnly="true"></asp:TextBox>
                    <asp:Button runat="server" Text="Add Course" OnClick="addCourse" ID="Button_1F" />
                </div>
            </div>

            <h3>Link Entities</h3>
            <div>
                <label>Link an Instructir to a Course in a specific slot</label>
                <div>
                    <input type="number" min="0" placeholder="Course ID" runat="server" id="g_input1" />
                    <input type="number" min="0" placeholder="Instructor ID" runat="server" id="g_input2" />
                    <input type="number" min="0" placeholder="Slot ID" runat="server" id="g_input3" />
                    <asp:TextBox runat="server" ID="g_message_box" ReadOnly="true"></asp:TextBox>
                    <asp:Button runat="server" ID="Button_1G" Text="Assign Instructor & Course to Slot" OnClick="linkInstructorWithCourseOnSlot" />
                </div>                
                <label>Link a Student to an Advisor</label>
                <div>
                    <input type="number" min="0" placeholder="Student ID" id="h_input1" runat="server" />
                    <input type="number" min="0" placeholder="Adisor ID" id="h_input2" runat="server" />
                    <asp:TextBox runat="server" ID="h_message_box" ReadOnly="true"></asp:TextBox>
                    <asp:Button runat="server" ID="Button_1H" Text="Assign Advisor to Student" OnClick="linkStudentWithAdvisor" />
                </div>               
                <label>Link a Student to a Course with a specific Instructor</label>
                <div>
                    <input type="number" min="0" placeholder="Course ID" id="i_input1" runat="server" />
                    <input type="number" min="0" placeholder="Instructor ID" id="i_input2" runat="server" />
                    <input type="number" min="0" placeholder="Student ID" id="i_input3" runat="server" />
                    <asp:TextBox runat="server" ID="i_input4" placeholder="Semester Code"></asp:TextBox>
                    <asp:TextBox runat="server" ID="i_message_box" ReadOnly="true"></asp:TextBox>
                    <asp:Button runat="server" ID="Button_1I" Text="Assign Student to Course with Instructor" OnClick="linkStudentWithCourseWithInstructor" />

                </div>
            </div>
        </div>

        <p>
            <asp:Label ID="Label1" runat="server" Text="Please insert Course ID you want to delete"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="c_id" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="delete" runat="server" Text="Delete" OnClick="deleteCourse" />
        </p>
        <h3>
            <asp:Label ID="Label2" runat="server" Text="Delete slot of a certain course"></asp:Label>
        </h3>
        <asp:TextBox ID="semster_id" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="del" runat="server" Text="Delete" OnClick="deleteSlot" />
        <br />
        <br />
        <h3>
            <asp:Label ID="Label3" runat="server" Text="Please enter the details for the course you want to add a makeup exam for"></asp:Label></h3>
        <p>
            <asp:TextBox ID="type" runat="server" placeHolder="Type"></asp:TextBox>
        </p>
        <p>


            <asp:TextBox ID="date" runat="server" type="datetime-local"></asp:TextBox>




        </p>


        <asp:TextBox ID="courseID" runat="server" placeHolder="Course ID"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" Text="Add" />


        <br />
        <br />
        <h3>
            <asp:Label ID="Label4" runat="server" Text="Please enter Payment ID you want to issue installments to"></asp:Label></h3>
        <asp:TextBox ID="payment_id" runat="server"></asp:TextBox>



        <br />
        <asp:Button ID="payment" runat="server" Text="Issue" OnClick="issuePayment" />



        <br />
        <br />
        <asp:Label ID="Label5" runat="server" Text="Insert Student ID you want to update his financial status"></asp:Label>



        <br />



        <br />
        <asp:Button ID="Button3" runat="server" Text="Update" OnClick="updateStatus" />


        <br />
        <br />


        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <br />
    </form>
</body>
</html>
