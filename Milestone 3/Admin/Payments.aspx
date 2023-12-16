<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Payments.aspx.cs" Inherits="Milestone_3.Payments" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 148px;
        }
        .auto-style2 {
            width: 138px;
        }
        .auto-style3 {
            width: 117px;
        }
        .auto-style4 {
            width: 90px;
        }
        .auto-style5 {
            width: 96px;
        }
        .auto-style6 {
            width: 83px;
        }
        .auto-style7 {
            width: 131px;
        }
        .auto-style8 {
            width: 129px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="Button1" runat="server" Text="Back to home" onClick="Back" />
            <table id="table1" runat="server">
                <tr>
                    <th>studentID
                    </th>
                    <th>f_name
                    </th>
                    <th>l_name
                    </th>
                    <th class="auto-style8">semester_code
                    </th>
                    <th class="auto-style7">payment_id
                    </th><th class="auto-style6">amount
                    </th><th class="auto-style5">startdate
                    </th><th class="auto-style4">deadline
                    </th><th class="auto-style3">n_installments
                    </th><th class="auto-style2">fund_percentage
                    </th><th class="auto-style1">status
                    </th>
                </tr>
            </table>
        </div>

    </form>
</body>
</html>
