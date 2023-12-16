<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Slots.aspx.cs" Inherits="Portal.Instructor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Slots</title>
</head>
<body>
    <asp:HyperLink  runat="server" NavigateUrl="~/Student/studentMainMenu.aspx" style="color:firebrick; text-decoration:none;">Return to Main menu page</asp:HyperLink><br />
    <form id="form1" runat="server">
        <div>

            <h1>View Slots</h1>

            <asp:Label ID="CourseSlot" runat="server" Text="Course ID"></asp:Label>
            <asp:TextBox ID="courseIDup" runat="server"></asp:TextBox>

            <asp:Label ID="InstructorSlot" runat="server" Text="Instructor ID"></asp:Label>
            <asp:TextBox ID="instructorIDup" runat="server"></asp:TextBox>

            <asp:Button ID="viewButton" runat="server" Text="View" OnClick="View"/>
            <br/>
            <asp:Label ID="slotResult" runat="server" Text=""></asp:Label>

            <asp:gridview id="slotTable" autogeneratecolumns="True"
                emptydatatext="No Data" allowpaging="True" pagesize="10" runat="server"
                AlternatingRowStyle-BackColor="lightgrey" HeaderStyle-BackColor="wheat">
            </asp:gridview>

        </div>
        <br/>
        <hr/>
        <div>

            <h1>Choose Instructor</h1>

            <asp:Label ID="CourseChoose" runat="server" Text="Course ID"></asp:Label>
            <asp:TextBox ID="courseIDdown" runat="server"></asp:TextBox>

            <asp:Label ID="InstructorChoose" runat="server" Text="Instructor ID"></asp:Label>
            <asp:TextBox ID="instructorIDdown" runat="server"></asp:TextBox>

            <asp:Label ID="SemesterSlot" runat="server" Text="Semester ID"></asp:Label>
            <asp:TextBox ID="semesterID" runat="server"></asp:TextBox>

            <asp:Button ID="chooseButton" runat="server" Text="Submit" OnClick="Choose"/>
            <br/>
            <asp:Label ID="chooseResult" runat="server" Text=""></asp:Label>

        </div>
    </form>
</body>
</html>
