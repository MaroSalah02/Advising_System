<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewPendingRequests.aspx.cs" Inherits="Milestone_3.Admin.ViewPendingRequest" %>

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
            List of All Pending Requests
        </h2>
        <hr />
        <table runat="server" id="table1">
            <thead>
                <tr>
                    <th>
                        Request ID
                    </th>
                    <th>
                        Request Type
                    </th>
                    <th>
                        Comment
                    </th>
                    <th>
                        Status
                    </th>
                    <th>
                        Credit Hours
                    </th>
                    <th>
                        Course ID
                    </th>
                    <th>
                        Student ID
                    </th>
                    <th>
                        Advisor ID
                    </th>
                </tr>
            </thead>
        </table>
        <asp:Button Text="Back to Home" OnClick="Back" runat="server" />
    </form>
</body>
</html>
