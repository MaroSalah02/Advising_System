<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Transcript.aspx.cs" Inherits="Milestone_3.Transcript" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="Button1" runat="server" Text="Back to home" OnClick="Back" />

        <br />
        <div>
            <asp:GridView ID="View_Students" runat="server" AutoGenerateColumns="True" AlternatingRowStyle-BackColor="lightgray" HeaderStyle-BackColor="wheat" EmptyDataText="No Data Found" Style="text-align: center; width: 100%;"></asp:GridView>
        <div>
        </div>
    </form>
</body>
</html>
