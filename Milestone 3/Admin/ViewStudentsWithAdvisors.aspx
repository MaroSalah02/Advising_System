<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewStudentsWithAdvisors.aspx.cs" Inherits="Milestone_3.Admin.ViewStudentsWithAdvisors" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button Text="Back to Home" OnClick="Back" runat="server" />
        <table runat="server" id="table1">
            <tr>
                <th>
                    Student ID
                </th>
                <th>
                    Student First Name
                </th>
                <th>
                    Student Last Name
                </th>
                <th>
                    Advisor ID
                </th>
                <th>
                    Advisor Name
                </th>
            </tr>
        </table>
    </form>
</body>
</html>
