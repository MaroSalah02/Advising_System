<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Milestone_3.Admin.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="~/Admin/Admin_Stylesheet.css"/>
</head>
<body>
    <h1>Welcome Admin</h1>
    <h2>Please Choose an Operation</h2>
    <form runat="server">
        <div>
            <label>View Information</label>
            <div class="Button_Group">
                <asp:Button ID="Button_1B" runat="server" Text="View all Advisors" onclick="viewAllAdvisors"/>
                <asp:Button ID="Button_1C" runat="server" Text="View all Students With Advisors" onclick="viewStudentsWithAdvisors"/>
                <asp:Button ID="Button_1D" runat="server" Text="View all Pending Requests" onclick="viewPendingRequests"/>
                <asp:Button ID="Button_1J" runat="server" Text="View all Students With Advisors" onclick="viewStudentsWithAdvisors"/>


            </div>
            <label>Add Information</label>
            <div>

            </div>
            <label>Link Entities</label>
            <div>

            </div>
        </div>
    </form>
</body>
</html>
