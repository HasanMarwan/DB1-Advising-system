<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Transcript_Details.aspx.cs" Inherits="admin2.Transcript_Details" %>

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
    <asp:BoundField DataField="student_id" HeaderText="studentId"/>
    <asp:BoundField DataField="f_name" HeaderText="first_name"/>
    <asp:BoundField DataField="l_name" HeaderText="last_name"/>
    <asp:BoundField DataField="t.course_id" HeaderText="course_id"/>
    <asp:BoundField DataField="Course.name" HeaderText="Course name"/>
    <asp:BoundField DataField=" t.exam_type" HeaderText="exam_type"/>
    <asp:BoundField DataField="t.grade" HeaderText="grade"/>
    <asp:BoundField DataField="t.semester_code" HeaderText="semester_code"/>
    </columns>
</asp:GridView>
        </div>
    </form>
</body>
</html>
