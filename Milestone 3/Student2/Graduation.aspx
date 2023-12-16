<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Graduation.aspx.cs" Inherits="Portal.Graduation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Graduation</title>
</head>
<body>
    <asp:HyperLink  runat="server" NavigateUrl="~/Student/studentMainMenu.aspx" style="color:firebrick; text-decoration:none;">Return to Main menu page</asp:HyperLink><br />
    <form id="form1" runat="server">
        <div>

            <h1>Graduation Plan</h1>

            <asp:gridview id="gradTable" autogeneratecolumns="True"
                emptydatatext="No Data" allowpaging="True" runat="server" pagesize="10"
                AlternatingRowStyle-BackColor="lightgrey" HeaderStyle-BackColor="wheat">
            </asp:gridview>

        </div>
        <br/>
        <hr/>
        <div>

             <h1>Upcoming Installment</h1>

            <asp:gridview id="instTable" autogeneratecolumns="True"
                emptydatatext="No Data" allowpaging="True" runat="server" pagesize="10"
                AlternatingRowStyle-BackColor="lightgrey" HeaderStyle-BackColor="wheat">
            </asp:gridview>

            <asp:gridview id="payTable" autogeneratecolumns="True"
                emptydatatext="No Data" allowpaging="True" runat="server" pagesize="10"
                AlternatingRowStyle-BackColor="lightgrey" HeaderStyle-BackColor="wheat">
            </asp:gridview>

        </div>
    </form>
</body>
</html>
