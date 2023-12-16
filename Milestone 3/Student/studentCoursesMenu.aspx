<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="studentCoursesMenu.aspx.cs" Inherits="Milestone_3.Student.studentCoursesMenu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <label>Optional courses in the current semester :</label>
            <asp:GridView ID="optionalCourses" runat = "server" AutoGenerateColumns="true" >
                <Columns>
                    <asp:BoundField DataField = "course_id" HeaderText="Course ID" />
                    <asp:BoundField DataField = "name" HeaderText="Course Name" />
                </Columns>
            </asp:GridView>
            <label>Available courses in the current semester :</label>
            <asp:GridView ID="availableCourses" runat = "server" AutoGenerateColumns="true" >
                <Columns>
                    <asp:BoundField DataField = "course_id" HeaderText="Course ID" />
                    <asp:BoundField DataField = "name" HeaderText="Course Name" />
                </Columns>
            </asp:GridView>
            <label>Required courses in the current semester :</label>
            <asp:GridView ID="requiredCourses" runat = "server" AutoGenerateColumns="true" >
                <Columns>
                    <asp:BoundField DataField = "course_id" HeaderText="Course ID" />
                    <asp:BoundField DataField = "name" HeaderText="Course Name" />
                </Columns>
            </asp:GridView>
            <label>Missing courses :</label>
            <asp:GridView ID="missingCourses" runat = "server" AutoGenerateColumns="true" >
                <Columns>
                    <asp:BoundField DataField = "course_id" HeaderText="Course ID" />
                    <asp:BoundField DataField = "name" HeaderText="Course Name" />
                </Columns>
            </asp:GridView>
            
        </div>
    </form>
</body>
</html>
