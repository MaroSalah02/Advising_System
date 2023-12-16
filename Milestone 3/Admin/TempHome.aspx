<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TempHome.aspx.cs" Inherits="Milestone_3.Admin.TempHome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <input runat="server" type="date" placeholder="Start Date" id="e_input1" />
            <input runat="server" type="date" placeholder="End Date" id="e_input2" />
            <asp:TextBox runat="server" id="e_input3" placeholder="Semester Code"></asp:TextBox>
            <asp:TextBox runat="server" id="e_message_box" ReadOnly="true"></asp:TextBox>
            <asp:Button runat="server" di="Button_1E" OnClick="addSemester" Text="Add Semester"/>
        </div>
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <div>
            <asp:TextBox runat="server" id="f_input1" placeholder="Major"></asp:TextBox>
            <input runat="server" type="number" min="0" id="f_input2" placeholder="Semester No." />
            <input runat="server" type="number" min="0" id="f_input3" placeholder="Credit Hours" />
            <asp:TextBox runat="server" id="f_input4" placeholder="Course Name"></asp:TextBox>
            <label>The Course is Offered</label> <input type="checkbox" runat="server" id="f_input5" />
            <asp:TextBox runat="server" id="f_message_box" ReadOnly="true"></asp:TextBox>
            <asp:Button runat="server" Text="Add Course" OnClick="addCourse" id="Button_1F" />
        </div>
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <div>
            <input type="number" min="0" placeholder="Course ID" runat="server" id="g_input1" />
            <input type="number" min="0" placeholder="Instructor ID" runat="server" id="g_input2" />
            <input type="number" min="0" placeholder="Slot ID" runat="server" id="g_input3" />
            <asp:TextBox runat="server" id="g_message_box" ReadOnly="true"></asp:TextBox>
            <asp:button runat="server" id="Button_1G" Text="Assign Instructor & Course to Slot" OnClick="linkInstructorWithCourseOnSlot" />    
        </div>
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <div>
            <input type="number" min="0" placeholder="Student ID" id="h_input1" runat="server" />
            <input type="number" min="0" placeholder="Adisor ID" id="h_input2" runat="server" />
            <asp:TextBox runat="server" id="h_message_box" ReadOnly="true"></asp:TextBox>
            <asp:button runat="server" id="Button_1H" Text="Assign Advisor to Student" OnClick="linkStudentWithAdvisor" />
        </div>
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <div>
            <input type="number" min="0" placeholder="Course ID" id="i_input1" runat="server" />
            <input type="number" min="0" placeholder="Instructor ID" id="i_input2" runat="server" />
            <input type="number" min="0" placeholder="Student ID" id="i_input3" runat="server" />
            <asp:TextBox runat="server" id="i_input4" placeholder="Semester Code"></asp:TextBox>
            <asp:TextBox runat="server" id="i_message_box" ReadOnly="true"></asp:TextBox>
            <asp:button runat="server" id="Button_1I" Text="Assign Student to Course with Instructor" OnClick="linkStudentWithCourseWithInstructor" />

        </div>
    </form>
</body>
</html>
