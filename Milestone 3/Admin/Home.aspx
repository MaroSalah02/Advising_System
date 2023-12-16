<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Milestone_3.Admin.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="~/Admin/Admin_Stylesheet.css"/>
</head>
<body>
    <h1>Welcome Admin</h1>
    <h2>Please Choose an Operation</h2>
    <form runat="server">
        <div>
            <label>View Information</label>
            <div class="Button_Group">
                <asp:Button ID="Button_1B" runat="server" Text="View all Advisors" onclick="viewAllAdvisors"/>
                <asp:Button ID="Button_1C" runat="server" Text="View all Students With Advisors" onclick="viewStudentsWithAdvisors"/>
                <asp:Button ID="Button_1D" runat="server" Text="View all Pending Requests" onclick="viewPendingRequests"/>
                <asp:Button ID="Button_1J" runat="server" Text="View all Students With Advisors" onclick="viewStudentsWithAdvisors"/>


                <asp:Button ID="Button2" runat="server" Text="View details for all payments with students" onClick="viewPayments" />


            </div>
            <label>Add Information</label>
            <div>

            </div>
            <label>Link Entities</label>
            <div>

            </div>
        </div>
        <p>
            <asp:Label ID="Label1" runat="server" Text="Please insert Course ID you want to delete"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="c_id" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="delete" runat="server" Text="Delete" OnClick="deleteCourse" />
        </p>
        <h3>
            <asp:Label ID="Label2" runat="server" Text="Delete slot of a certain course"></asp:Label>
        </h3>
        <asp:TextBox ID="semster_id" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="del" runat="server" Text="Delete" OnClick="deleteSlot" />
        <br />
        <br />
        <h3><asp:Label ID="Label3" runat="server" Text="Please enter the details for the course you want to add a makeup exam for"></asp:Label></h3>
        <p>
            <asp:TextBox ID="type" runat="server" placeHolder="Type"></asp:TextBox>
        </p>
        <p>


        <asp:TextBox ID="date" runat="server" type ="datetime-local"></asp:TextBox>




        </p>

        
        <asp:TextBox ID="courseID" runat="server" placeHolder="Course ID"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" Text="Add" />


        <br />
        <br />
        <h3><asp:Label ID="Label4" runat="server" Text="Please enter Payment ID you want to issue installments to"></asp:Label></h3>
        <asp:TextBox ID="payment_id" runat="server"></asp:TextBox>



        <br />
        <asp:Button ID="payment" runat="server" Text="Issue" OnClick="issuePayment" />



        <br />
        <br />
        <asp:Label ID="Label5" runat="server" Text="Insert Student ID you want to update his financial status"></asp:Label>



        <br />



        <br />
        <asp:Button ID="Button3" runat="server" Text="Update" OnClick="updateStatus"     />


               <br />
        <br />


               <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <br />
    </form>
</body>
</html>
