<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mainpage.aspx.cs" Inherits="admin2.mainpage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <br />
        <asp:Button ID="Button9" runat="server" OnClick="Transcript_Details" Text="students transcript details" Width="234px" />
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" OnClick="All_Semesters" Height="55px" Text="All Semesters" Width="235px" />
        <br />
        <br />
        <div>
            
            <br />
            <asp:Button ID="Button2" runat="server" OnClick="Payment_Details" Text="Payment Details" Width="233px" />
            <br />
            <br />
            <br />
            <asp:Button ID="Button3" runat="server" OnClick="Graduation_Plan" Height="52px" Text="Graduation Plans" Width="239px" />
            <br />
            <br />
            <br />
            <asp:Button ID="Button4" runat="server" OnClick="Active_Students" Height="53px" Text="Active Students" Width="232px" />
            <br />
            <br />
            course id<br />
            <asp:TextBox ID="TextBox1" runat="server" Height="40px" Width="269px"></asp:TextBox>
            <br />
            <asp:Button ID="Button5" runat="server" OnClick="Delete_Course" Height="85px" Text="Delete course with slots" Width="301px" />
            <br />
            <br />
            semester code<br />
            <asp:TextBox ID="TextBox2" runat="server" Height="45px" Width="275px"></asp:TextBox>
            <br />
            <asp:Button ID="Button6" runat="server" OnClick="Delete_Slots" Height="73px" Text="Delete slots" Width="296px" />
            <br />
            <br />
            payment id<br />
            <asp:TextBox ID="TextBox3" runat="server" Height="44px" Width="269px"></asp:TextBox>
            <br />
            <asp:Button ID="Button7" runat="server" OnClick="Issue_Installment" Height="75px" Text="Issue installments for payment" Width="299px" />
            <br />
            <br />
            student id<br />
            <asp:TextBox ID="TextBox4" runat="server" Width="272px"></asp:TextBox>
            <br />
            <asp:Button ID="Button8" runat="server" OnClick="UpdateStudentStatus" Height="59px" Text="Update Student Status" Width="294px" />
            <br />
            <br />
            <br />
            exam type<br />
            <asp:TextBox ID="Type" runat="server" Height="41px" Width="268px"></asp:TextBox>
            <br />
            <br />
            date<br />
            <asp:TextBox ID="Date" runat="server" Width="271px"></asp:TextBox>
            <br />
            <br />
            course id<br />
            <asp:TextBox ID="Cid" runat="server" Height="43px" Width="272px"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Button10" runat="server" OnClick="add_exam" Height="62px" Text="Add exam" Width="273px" />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            
        </div>
    </form>
 </body>
</html>
