<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewPendingRequests.aspx.cs" Inherits="Milestone_3.Admin.ViewPendingRequest" %>

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
    </form>
</body>
</html>
