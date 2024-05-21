<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Payment_Details.aspx.cs" Inherits="admin2.Payment_Details" %>

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
    <asp:BoundField DataField="payment_id" HeaderText="payment_id"/>
    <asp:BoundField DataField="amount" HeaderText="amount"/>
    <asp:BoundField DataField="startdate" HeaderText="startdate"/>
    <asp:BoundField DataField="deadline" HeaderText="deadline"/>
    <asp:BoundField DataField="n_installments" HeaderText="n_installments"/>
    <asp:BoundField DataField="fund_percentage" HeaderText="fund_percentage"/>
    <asp:BoundField DataField="status" HeaderText="status"/>
    <asp:BoundField DataField="student_id" HeaderText="student_id"/>
    <asp:BoundField DataField="semester_code" HeaderText="semester_code"/>
    </columns>
</asp:GridView>
        </div>
    </form>
</body>
</html>
