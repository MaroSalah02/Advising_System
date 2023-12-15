<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SemesterWithCourses.aspx.cs" Inherits="Milestone_3.Admin.SemesterWithCourses" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        
    <asp:Button Text="Back to Home" OnClick="Back" runat="server" />
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
    </form>
</body>
</html>
