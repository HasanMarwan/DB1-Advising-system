<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Graduation_Plan.aspx.cs" Inherits="admin2.Graduation_Plan" %>

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
    <asp:BoundField DataField="plan_id" HeaderText="plan_id"/>
    <asp:BoundField DataField="semester_code" HeaderText="semester_code"/>
    <asp:BoundField DataField="semester_credit_hours" HeaderText="semester_credit_hours"/>
    <asp:BoundField DataField="expected_grad_date" HeaderText="expected_grad_date"/>
    <asp:BoundField DataField="advisor_id" HeaderText="advisor_id"/>
    <asp:BoundField DataField="student_id" HeaderText="student_id"/>
    <asp:BoundField DataField="advisor_id" HeaderText="advisor_id"/>
    <asp:BoundField DataField="advisor_name" HeaderText="advisor_name"/>
    </columns>
</asp:GridView>
        </div>
    </form>
</body>
</html>
