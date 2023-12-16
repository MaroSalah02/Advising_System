<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewAdvisors.aspx.cs" Inherits="Milestone_3.Admin.ViewAdvisors" %>

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
            List of Advisors
        </h2>
        <hr />
        <table id="table1" runat="server">
            <tr>
                <th>
                    Advisor ID
                </th>
                <th>
                    Advisor Name
                </th>
                <th>
                    Email
                </th>
                <th>
                    Office Location
                </th>
                <th>
                    Password
                </th>
            </tr>
        </table>
        <asp:Button runat="server" onclick="Back" Text="Back To Home"/>
    </form>
</body>
</html>
