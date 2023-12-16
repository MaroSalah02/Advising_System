<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sendingCreditRequest.aspx.cs" Inherits="Milestone_3.Student.sendingCreditRequest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <label runat="server" id ="statuslabel"></label><br />
            <asp:Label>credit hours:</asp:Label>
            <asp:TextBox ID="creditNumeric" type="number" runat="server" min ="0"></asp:TextBox>
            </asp:RegularExpressionValidator><br />
            <asp:Label>Comments:</asp:Label>
            <asp:TextBox ID="comment" runat="server"></asp:TextBox><br />
            <asp:Button OnClick ="requestbtn" Text ="Request" runat ="server" />
    
        </div>
    </form>
</body>
</html>
