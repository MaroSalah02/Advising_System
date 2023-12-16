<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SemesterWithCourses.aspx.cs" Inherits="Milestone_3.Admin.SemesterWithCourses" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
    table{
        text-align: center;
    }
    th, td {
        border: 1px solid black;
    }
</style>
</head>
<body>
    <form id="form1" runat="server">
        <h2>
            List of Semesters with their offered courses
        </h2>
        <hr />
        <table runat="server" id="table1">
            <thead>
                <tr>
                    <th>
                        Semester
                    </th>
                    <th>
                        Course ID
                    </th>
                    <th>
                        Course Name
                    </th>
                </tr>
            </thead>
        </table>
        
    <asp:Button Text="Back to Home" OnClick="Back" runat="server" />
    </form>
</body>
</html>
