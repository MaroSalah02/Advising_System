<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Payments.aspx.cs" Inherits="Milestone_3.Payments" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 148px;
        }
        .auto-style2 {
            width: 138px;
        }
        .auto-style3 {
            width: 117px;
        }
        .auto-style4 {
            width: 90px;
        }
        .auto-style5 {
            width: 96px;
        }
        .auto-style6 {
            width: 83px;
        }
        .auto-style7 {
            width: 131px;
        }
        .auto-style8 {
            width: 129px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="Button1" runat="server" Text="Back to home" onClick="Back" />
            <asp:GridView ID="View_Students" runat="server" AutoGenerateColumns="True" AlternatingRowStyle-BackColor="lightgray" HeaderStyle-BackColor="wheat" EmptyDataText="No Data Found" Style="text-align: center; width: 100%;"></asp:GridView>

        </div>

    </form>
</body>
</html>
