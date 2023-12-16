<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Courses.aspx.cs" Inherits="Portal.Courses" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Courses</title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HyperLink  runat="server" NavigateUrl="~/Student/studentMainMenu.aspx" style="color:firebrick; text-decoration:none;">Return to Main menu page</asp:HyperLink><br />
        <div>

            <asp:Button ID="prereqButton" runat="server" Text="Prerequisites" OnClick="View"/>
            <asp:Button ID="slotButton" runat="server" Text="Slots" OnClick="View"/>

        </div>
        <div>
            <asp:MultiView ID="MultiView" runat="server">
                <asp:View ID="prerequisites" runat="server">
                    <div>

                        <asp:sqldatasource id="prereqData"
                            selectcommand="SELECT course_id as [Course ID], name as [Name], major as [Major], is_offered as [Offered],
                            credit_hours as [Credit Hours], semester as [Semester], preRequsite_course_id as [Prerequisite ID],
                            preRequsite_course_name as [Prerequisite Name] FROM view_Course_prerequisites ORDER BY course_id"
                            connectionstring="<%$ connectionStrings:con %>" runat="server"/>

                        <asp:gridview id="prereqTable" datasourceid="prereqData" autogeneratecolumns="True"
                            emptydatatext="No Data" allowpaging="True" runat="server" pagesize="10"
                            AlternatingRowStyle-BackColor="lightgrey" HeaderStyle-BackColor="wheat">
                        </asp:gridview>
    
                    </div>
                </asp:View>

                <asp:View ID="slots" runat="server">
                    <div>

                        <asp:sqldatasource id="slotData"
                            selectcommand="SELECT CourseID as [Course ID], Course as [Course Name], slot_id as [Slot ID], day as [Day],
                            time as [Time], location as [Location], instructor_id as [Instructor ID],
                            Instructor as [Instructor Name] FROM Courses_Slots_Instructor ORDER BY CourseID"
                            connectionstring="<%$ connectionStrings:con %>" runat="server"/>

                        <asp:gridview id="slotTable" datasourceid="slotData" autogeneratecolumns="True"
                            emptydatatext="No Data" allowpaging="True" runat="server" pagesize="10"
                            AlternatingRowStyle-BackColor="lightgrey" HeaderStyle-BackColor="wheat">
                        </asp:gridview>
    
                    </div>
                </asp:View>
            </asp:MultiView>
        </div>
    </form>
</body>
</html>
