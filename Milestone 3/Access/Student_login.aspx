<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student_login.aspx.cs" Inherits="Milestone_3.Access.Student_login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Student</title>
    <link rel="icon" href="../Home/Icons/Student.png" type="image/x-icon"/>
    <link rel="stylesheet" href="Styles/Style.css"/>
</head>
<body>
    <form id="form1" runat="server">
        <div class="holder">
            <h1>Student</h1>
            <asp:TextBox ID="TextBox1" runat="server" placeholder="User ID" type="number" CssClass="input"></asp:TextBox>
            <asp:TextBox ID="TextBox2" runat="server" placeholder="password" CssClass="input"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="Login" OnClick="Button1_Click" CssClass="btn"/>
            <h2 runat="server" id="status" style="text-align: center;color: whitesmoke; font-size: large;"></h2>
        </div>
    </form>
</body>
</html>
