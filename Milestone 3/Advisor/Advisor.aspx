<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Advisor.aspx.cs" Inherits="Milestone_3.Advisor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Advisor Page</title>
    <link rel="stylesheet" href="Advisor.css"/>
</head>
<body>
    <form id="form1" runat="server">
        <header>
            <p id="advisor_name" runat="server">Advisor Name</p>  
            <asp:Button runat="server" Text="Reset" OnClick="Reset_Click" CssClass="reset_button"/>
        </header>

         <div class="Selection_div">            
            <asp:DropDownList ID="dropdown" runat="server" AutoPostBack="true" CssClass="drop_down_menu" OnSelectedIndexChanged="dropdown_SelectedIndexChanged">
                <asp:ListItem Text="Select an Option" Value="" Selected="True"/>  
                <asp:ListItem Text="View all requests"></asp:ListItem>
                <asp:ListItem Text="View all pending requests"></asp:ListItem>
                <asp:ListItem Text="View My advising students"></asp:ListItem>
                <asp:ListItem Text="View all students assigned to from a certain major along with their taken courses"></asp:ListItem>
                <asp:ListItem Text="Insert a graduation plan for a student"></asp:ListItem>
                <asp:ListItem Text="Insert courses for a specific graduation plan"></asp:ListItem>
                <asp:ListItem Text="Update expected graduation date for a certain graduation plan"></asp:ListItem>
                <asp:ListItem Text="Delete course from a certain graduation plan in a certain semester"></asp:ListItem>
                <asp:ListItem Text="Approve or reject extra credit hours request"></asp:ListItem>
                <asp:ListItem Text="Approve or reject extra courses request"></asp:ListItem>   
            </asp:DropDownList>
        </div>

        <div>   
            <asp:GridView ID="View_Students" runat="server" AutoGenerateColumns="True" AlternatingRowStyle-BackColor="lightgray" HeaderStyle-BackColor="wheat" EmptyDataText="No Data Found"></asp:GridView>
        </div>

        <div id="view_div" runat="server" class="inputs_div">
            <asp:TextBox ID="textb1" runat="server" CssClass = "Text_Box" Placeholder="Enter major"></asp:TextBox>
            <asp:Button ID="btn1" runat="server" Text="Proceed" OnClick="proceed_Click" CssClass="btns"/>
        </div>

        <div id="insert_div1" runat="server" class="inputs_div">
            <asp:TextBox ID="textb2" runat="server" CssClass = "Text_Box" Placeholder="Enter Semester Code"></asp:TextBox>
            <asp:TextBox ID="textb3" type="date" runat="server" CssClass = "Text_Box" Placeholder="Enter Expected Graduation date"></asp:TextBox>
            <asp:TextBox ID="textb4" type="number" runat="server" CssClass = "Text_Box" Placeholder="Enter Semester Credit Hours"></asp:TextBox>
            <asp:TextBox ID="textb5" type="number" runat="server" CssClass = "Text_Box" Placeholder="Enter Student ID"></asp:TextBox>
            <asp:Button ID="btn2" runat="server" Text="Proceed" OnClick="proceed_Click" CssClass="btns"/>
        </div>

        <div id="insert_div2" runat="server" class="inputs_div">
            <asp:TextBox ID="textb6" type="number" runat="server" CssClass = "Text_Box" Placeholder="Enter Student ID"></asp:TextBox>
            <asp:TextBox ID="textb7" runat="server" CssClass = "Text_Box" Placeholder="Enter Semester Code"></asp:TextBox>
            <asp:TextBox ID="textb8" runat="server" CssClass = "Text_Box" Placeholder="Enter Course Name"></asp:TextBox>
            <asp:Button ID="btn3" runat="server" Text="Proceed" OnClick="proceed_Click" CssClass="btns"/>
        </div>

        <div id="update_div" runat="server" class="inputs_div">
            <asp:TextBox ID="textb9" type="date" runat="server" CssClass = "Text_Box" Placeholder="Enter Expected Graduation date"></asp:TextBox>
            <asp:TextBox ID="textb10" type="number" runat="server" CssClass = "Text_Box" Placeholder="Enter Student ID"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="Proceed" OnClick="proceed_Click" CssClass="btns"/>
        </div>

        <div id="delete_div" runat="server" class="inputs_div"> 
            <asp:TextBox ID="textb11" type="number" runat="server" CssClass = "Text_Box" Placeholder="Enter Student ID"></asp:TextBox>
            <asp:TextBox ID="textb12" runat="server" CssClass = "Text_Box" Placeholder="Enter Semester Code"></asp:TextBox>
            <asp:TextBox ID="textb13" type="number" runat="server" CssClass = "Text_Box" Placeholder="Enter Course ID"></asp:TextBox>
            <asp:Button ID="Button2" runat="server" Text="Proceed" OnClick="proceed_Click" CssClass="btns"/>
        </div>

        <div id="acc_or_rej1" runat="server" class="inputs_div">
            <asp:TextBox ID="textb14" type="number" runat="server" CssClass = "Text_Box" Placeholder="Enter Request ID"></asp:TextBox>
            <asp:TextBox ID="textb15" runat="server" CssClass = "Text_Box" Placeholder="Enter Current Semester Code"></asp:TextBox>
            <asp:Button ID="Button3" runat="server" Text="Proceed" OnClick="proceed_Click" CssClass="btns"/>
        </div>

        <footer>                
            <p>Copyrights@<strong style="color: wheat;">OptimizePrime</strong></p>
        </footer>

    </form>
</body>
</html>
