<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Active_Students.aspx.cs" Inherits="admin2.Active_Students" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
                <asp:GridView ID="GridView1" runat="server" >
    <columns>
    <asp:BoundField DataField="student_id" HeaderText="student_id"/>
    <asp:BoundField DataField="f_name" HeaderText="f_name"/>
    <asp:BoundField DataField="l_name" HeaderText="l_name"/>
    <asp:BoundField DataField="password" HeaderText="password"/>
    <asp:BoundField DataField="gpa" HeaderText="gpa"/>
    <asp:BoundField DataField="faculty" HeaderText="faculty"/>
    <asp:BoundField DataField="email" HeaderText="email"/>
    <asp:BoundField DataField="major" HeaderText="major"/>
    <asp:BoundField DataField="financial_status" HeaderText="financial_status"/>
    <asp:BoundField DataField="semester" HeaderText="semester"/>
    <asp:BoundField DataField="acquired_hours" HeaderText="acquired_hours"/>
    <asp:BoundField DataField="assigned_hours" HeaderText="assigned_hours"/>
    <asp:BoundField DataField="advisor_id" HeaderText="advisor_id"/>
    </columns>
</asp:GridView>
        </div>
    </form>
</body>
</html>
