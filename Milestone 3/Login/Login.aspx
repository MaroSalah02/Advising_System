<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Milestone_3.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
      <div>
            <asp:TextBox ID="TextBox1" runat="server" placeholder="User ID"></asp:TextBox>
            <asp:TextBox ID="TextBox2" runat="server" placeholder="password"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="Login" OnClick="Button1_Click"/>
          <asp:RadioButtonList ID="RadioButtonList1" runat="server">
              <asp:ListItem Selected="True">Advisor</asp:ListItem>
              <asp:ListItem>Student</asp:ListItem>
          </asp:RadioButtonList>
        </div>
    </form>
</body>
</html>
