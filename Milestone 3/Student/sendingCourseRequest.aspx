<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sendingCourseRequest.aspx.cs" Inherits="Milestone_3.Student.sendingCourseRequest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <asp:HyperLink  runat="server" NavigateUrl="~/Student/studentMainMenu.aspx" style="color:firebrick; text-decoration:none;">Return to Main menu page</asp:HyperLink><br />
    <form id="form1" runat="server">
        <div>
            <label runat="server" id ="statuslabel"></label><br />
            <asp:Label>Course:</asp:Label>
            <asp:TextBox ID="courseNumeric" type="number" runat="server" min ="0"></asp:TextBox>
            </asp:RegularExpressionValidator><br />
            <asp:Label>Comments:</asp:Label>
            <asp:TextBox ID="comment" runat="server"></asp:TextBox><br />
            <asp:Button OnClick ="requestbtn" Text ="Request" runat ="server" />
            
        </div>
    </form>
</body>
</html>
