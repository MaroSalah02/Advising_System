<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="studentMainMenu.aspx.cs" Inherits="Milestone_3.Student.studentMainMenu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <p>Hello </p>
            <p id="student_Name" runat="server">Student Name</p> 
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="./updateStudentInfo.aspx" Text="Update Student Info" /> <br />
            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="./studentCoursesMenu.aspx" Text="Courses Section" />
            <h3>Requests</h3>
            <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="./sendingCourseRequest.aspx" Text="Request Course" /> <br />
            <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="./sendingCreditRequest.aspx" Text="Request Credit hours" /> <br />
            <asp:HyperLink ID="HyperLink7" runat="server" NavigateUrl="../Student2/MakeUp.aspx" Text="Register for 1st or 2nd MakeUp/ Courses and Exam details " /> <br />
            <h3>Courses</h3>
            <asp:HyperLink ID="HyperLink5" runat="server" NavigateUrl="../Student2/Courses.aspx" Text="Courses Details" /> <br />
            <h3>Graduation / Installments </h3>
            <asp:HyperLink ID="HyperLink6" runat="server" NavigateUrl="../Student2/Graduation.aspx" Text="Graduation and Installments Details" /> <br />
            <h3>Slots</h3>
            <asp:HyperLink ID="HyperLink8" runat="server" NavigateUrl="../Student2/Slots.aspx" Text="Choose instructors/view slots taught by instructors" /> <br />


        </div>
    </form>
</body>
</html>
