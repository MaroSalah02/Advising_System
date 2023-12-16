<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewRegister.aspx.cs" Inherits="Milestone_3.Admin.NewRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

            <asp:Label ID="Label1" runat="server" Text="Do you want to register as a student?"></asp:Label>
            <div style="display:flex; flex-direction:row; row-gap:10px;">
                <asp:Label ID="Label2" runat="server" Text="Student Registration"></asp:Label>
                <asp:TextBox ID="Textb1" runat="server" placeholder="enter student first_name"></asp:TextBox>

                <asp:TextBox ID="Textb2" runat="server" placeholder="enter student last_name" ></asp:TextBox>

                <asp:TextBox ID="Textb3" runat="server" placeholder="enter student password" ></asp:TextBox>

                <asp:TextBox ID="Textb4" runat="server" placeholder="enter student faculty" ></asp:TextBox>

                <asp:TextBox ID="Textb5" runat="server" placeholder="enter student email" ></asp:TextBox>

                <asp:TextBox ID="Textb6" runat="server" placeholder="enter student major" ></asp:TextBox>

                <asp:TextBox ID="Textb7" runat="server" placeholder="enter student Semester" type="number"></asp:TextBox>

            </div>
            <asp:Button ID="Button1" runat="server" Text="Register student" OnClick="Register_for_student_click"/>

        <div>
            <asp:TextBox ID="Textb9" runat="server" placeholder="enter advisor name"></asp:TextBox>

            <asp:TextBox ID="Textb10" runat="server" placeholder="enter advisro password" ></asp:TextBox>

            <asp:TextBox ID="Textb11" runat="server" placeholder="enter advisor email" ></asp:TextBox>

            <asp:TextBox ID="Textb12" runat="server" placeholder="enter advisor office" ></asp:TextBox>
        </div>
        <asp:Button ID="Button2" runat="server" Text="Register advisor" OnClick="Register_for_advisor_click"/>
    </form>
</body>
</html>
