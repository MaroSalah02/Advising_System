<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="updateStudentInfo.aspx.cs" Inherits="Milestone_3.Student.updateStudentInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            
            <label>Current Telephone Number :</label>
                <asp:GridView ID="phones" runat = "server" AutoGenerateColumns="false" >
                    <Columns>
                       <asp:BoundField DataField = "phone_number" HeaderText="Phone Numbers" />
                     </Columns>
                </asp:GridView>

            <label>Update Telephone Number :</label>
            <asp:TextBox runat="server" ID ="telephone_input" placeholder ="Enter New number"></asp:TextBox>
            <asp:Button runat ="server" ID = "save_telephone" Text="Save" OnClick="btnSaveClick" />

        </div>
    </form>
</body>
</html>
