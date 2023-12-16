<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="activeStudent.aspx.cs" Inherits="Milestone_3.admin2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 155px;
            height: 23px;
        }
        .auto-style2 {
            width: 133px;
            height: 23px;
        }
        .auto-style3 {
            width: 68px;
            height: 23px;
        }
        .auto-style4 {
            height: 23px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="Button1" runat="server" Text="Back to home" OnClick="Back" />
        <table id="table1" runat="server" style="width:100%">
            <tr>
                <th class="auto-style1">
            

                    studentID
                </th>
                <th class="auto-style2">f_name
                </th>
                <th class="auto-style3">l_name
                </th>
                <th class="auto-style4">password
                </th>
                <th class="auto-style4">gpa
                </th>
                <th class="auto-style4">faculty
                </th>
                <th class="auto-style4">email
                </th>
                <th class="auto-style4">major
                </th>
                <th class="auto-style4">financial_status
                    </th>
                    <th class="auto-style4">semster
                    </th>
                   <th class="auto-style4">acquired_hours
                    </th>
                      <th class="auto-style4">advisor_ID
                      </th>
            </tr>
        </table>
        <div>

        </div>
    </form>
</body>
</html>
