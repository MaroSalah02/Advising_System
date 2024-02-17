<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Milestone_3.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Advising System</title>
    <link rel="icon" href="Icons/Portal.png" type="image/x-icon"/>
    <link rel="stylesheet" href="Home.css"/>

</head>

<body>
    <form id="form1" runat="server">

        <div class="holder">

            <div class="card2" onclick="redirectToAdvisor()">
                <img src="Icons/Advisor.png"/>
                <h1>Advisor</h1>
            </div>

            <div class="card" onclick="redirectToAdmin()">
                <img src="Icons/Admin.png"/>
                <h1>Admin</h1>
            </div>

            <div class="card2" onclick="redirectToStudent()">
                <img src="Icons/Student.png"/>
                <h1>Student</h1>
            </div>

        </div>

        <footer>
            <p>Copyrights@<span>Optimize Prime</span></p>
        </footer>

    </form>
    <script src="Redirect.js"></script>
</body>
</html>
