 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AllSemesters.aspx.cs" Inherits="admin2.AllSemesters" %>

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
    <asp:BoundField DataField="course_id" HeaderText="Id"/>
    <asp:BoundField DataField="name" HeaderText="name"/>
    <asp:BoundField DataField="semester_code" HeaderText="semester_code"/>
    </columns>
</asp:GridView>
        </div>
    </form>
</body>

</html>
