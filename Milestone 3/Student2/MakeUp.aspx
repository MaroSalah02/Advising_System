<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MakeUp.aspx.cs" Inherits="Portal.MakeUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Make-Up</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <asp:sqldatasource id="makeupData"
                selectcommand="SELECT exam_id as [Exam ID], date as [Date], type as [Type],
                course_id as [Course ID], name as [Course Name], semester as [Semester]
                FROM Courses_MakeupExams ORDER BY exam_id"
                connectionstring="<%$ connectionStrings:Server %>" runat="server"/>

            <asp:gridview id="makeupTable" datasourceid="makeupData" autogeneratecolumns="True"
                emptydatatext="No Data" allowpaging="True" pagesize="10" runat="server"
                AlternatingRowStyle-BackColor="lightgrey" HeaderStyle-BackColor="wheat">
            </asp:gridview>

        </div>
        <br/>
        <hr/>
        <div>

            <h1>Exam Registeration</h1>
            
            <asp:Label ID="CourseLabel" runat="server" Text="Course ID"></asp:Label>
            <asp:TextBox ID="courseID" runat="server"></asp:TextBox>
            
            <asp:Label ID="ExamLabel" runat="server" Text="Exam Type"></asp:Label>
            <asp:DropDownList ID="examType" runat="server" AutoPostBack="false">
                <asp:ListItem Text="First Make-Up" Value="First"/>
                <asp:ListItem Text="Second Make-Up" Value="Second"/>
            </asp:DropDownList>

            <asp:Label ID="SemesterLabel" runat="server" Text="Semester ID"></asp:Label>
            <asp:TextBox ID="semesterID" runat="server"></asp:TextBox>
            
            <asp:Button ID="RegisterButton" runat="server" Text="Register" OnClick="Register"/>
            <br/>
            <asp:Label ID="result" runat="server" Text=""></asp:Label>

        </div>
    </form>
</body>
</html>
