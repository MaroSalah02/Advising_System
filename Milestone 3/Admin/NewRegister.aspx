<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewRegister.aspx.cs" Inherits="Milestone_3.Admin.NewRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <h2>Registration</h2>
    <hr />
    <form id="form1" runat="server">
        
            <h3>Student Registration</h3>
            <div style="display:flex; flex-direction:row; row-gap:10px;">
                <asp:TextBox ID="Textb1" runat="server" placeholder="enter student first_name"></asp:TextBox>

                <asp:TextBox ID="Textb2" runat="server" placeholder="enter student last_name" ></asp:TextBox>

                <asp:TextBox ID="Textb3" runat="server" placeholder="enter student password" ></asp:TextBox>

                <asp:TextBox ID="Textb4" runat="server" placeholder="enter student faculty" ></asp:TextBox>

                <asp:TextBox ID="Textb5" runat="server" placeholder="enter student email" ></asp:TextBox>

                <asp:TextBox ID="Textb6" runat="server" placeholder="enter student major" ></asp:TextBox>

                <asp:TextBox ID="Textb7" runat="server" placeholder="enter student Semester" type="number" min="0"></asp:TextBox>

            </div>
            <asp:Button ID="Button1" runat="server" Text="Register student" OnClick="Register_for_student_click"/>
        <br />
        <br />
        <h3>Advisor Registration</h3>
        <div>
            <asp:TextBox ID="Textb9" runat="server" placeholder="enter advisor name"></asp:TextBox>

            <asp:TextBox ID="Textb10" runat="server" placeholder="enter advisro password" ></asp:TextBox>

            <asp:TextBox ID="Textb11" runat="server" placeholder="enter advisor email" ></asp:TextBox>

            <asp:TextBox ID="Textb12" runat="server" placeholder="enter advisor office" ></asp:TextBox>
        </div>
        <asp:Button ID="Button2" runat="server" Text="Register advisor" OnClick="Register_for_advisor_click"/>
        <br />
        <br />
        <hr />
        <asp:Button runat="server" OnClick="Back" Text="Back To Home" />
    </form>
</body>
</html>
