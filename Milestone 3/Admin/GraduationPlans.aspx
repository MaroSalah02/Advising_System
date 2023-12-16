<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GraduationPlans.aspx.cs" Inherits="Milestone_3.GraduationPlans" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="Button1" runat="server" Text="Back to home" OnClick="Back" />

        <br />
        <asp:TextBox ID="studentID" runat="server" placeholder="Student ID" type="number"></asp:TextBox>
        <asp:Button ID="Button2" runat="server" Text="View" OnClick="get" />
        <div>
            <asp:GridView ID="View_Students" runat="server" AutoGenerateColumns="True" AlternatingRowStyle-BackColor="lightgray" HeaderStyle-BackColor="wheat" EmptyDataText="No Data Found" style="text-align:center;width:100%;"></asp:GridView>
        </div>

    </form>
</body>
</html>
