<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="studentMainMenu.aspx.cs" Inherits="Milestone_3.Student.studentMainMenu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h4>Hello </h4>
            <p id="student_Name" runat="server">Student Name</p> 
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="./updateStudentInfo.aspx" Text="Update Student Info" /> <br />
            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="./studentCoursesMenu.aspx" Text="Courses Section" />
            <h3>Requests</h3>
            <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="./sendingCourseRequest.aspx" Text="Request Course" /> <br />
            <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="./sendingCreditRequest.aspx" Text="Request Credit hours" /> <br />



        </div>
    </form>
</body>
</html>
