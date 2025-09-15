<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher page/Teacher.Master" AutoEventWireup="true" CodeBehind="TeacherAttendance.aspx.cs" Inherits="School_Management.TeacherAttendance" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style> 

        /* Container */
.attendance-container {
    max-width: 900px;
    margin: 30px auto;
    background: #ffffff;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 6px 18px rgba(0, 0, 0, 0.1);
    font-family: "Segoe UI", Arial, sans-serif;
}

/* Title */
.attendance-title {
    text-align: center;
    font-size: 28px;
    font-weight: bold;
    color: #2c3e50;
    margin-bottom: 25px;
}

/* Form group */
.form-group {
    margin-bottom: 20px;
}
.form-group label {
    font-weight: 600;
    color: #34495e;
}
.form-control {
    width: 100%;
    padding: 10px;
    border-radius: 6px;
    border: 1px solid #ccc;
    transition: 0.3s;
}
.form-control:focus {
    border-color: #3498db;
    outline: none;
    box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
}

/* Summary box */
.summary-box {
    background: #f4f9ff;
    padding: 12px;
    border-left: 5px solid #3498db;
    border-radius: 6px;
    margin-bottom: 20px;
}
.summary-box h4 {
    margin: 0;
    font-size: 18px;
}
.highlight {
    font-weight: bold;
    font-size: 20px;
    color: #2980b9;
}

/* Styled Table */
.styled-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}
.styled-table th {
    background: #3498db;
    color: #fff;
    text-align: left;
    padding: 12px;
}
.styled-table td {
    border-bottom: 1px solid #ddd;
    padding: 10px;
}
.styled-table tr:nth-child(even) {
    background: #f9f9f9;
}
.styled-table tr:hover {
    background: #f1f9ff;
}

/* Button */
.btn-save {
    display: inline-block;
    margin-top: 20px;
    padding: 12px 25px;
    font-size: 16px;
    font-weight: bold;
    color: white;
    background: #27ae60;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: 0.3s;
}
.btn-save:hover {
    background: #219150;
}

/* Message Label */
.message-label {
    display: block;
    margin-top: 15px;
    font-weight: bold;
    color: #27ae60;
}


    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="attendance-container">
    <h2 class="attendance-title">📅 Attendance Management</h2>

    <!-- Select Course -->
    <div class="form-group">
    <label for="ddlCourses">Select Course:</label>
    <asp:DropDownList 
        ID="ddlCourses" 
        runat="server" 
        CssClass="form-control" 
        AutoPostBack="true" 
        OnSelectedIndexChanged="ddlCourses_SelectedIndexChanged">
    </asp:DropDownList>
</div>


    <!-- Attendance Date -->
    <div class="form-group">
        <label for="txtDate">Select Date:</label>
        <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
    </div>

    <!-- Total Students -->
    <div class="summary-box">
        <h4>Total Students: 
            <asp:Label ID="lblTotalStudents" runat="server" Text="0" CssClass="highlight"></asp:Label>
        </h4>
    </div>

    <!-- Students Attendance Table -->
    <asp:GridView ID="gvAttendance" runat="server" AutoGenerateColumns="False" CssClass="styled-table"
        DataKeyNames="EnrollmentID">
        <Columns>
            <asp:BoundField DataField="EnrollmentID" HeaderText="Enrollment ID" Visible="false" />
            <asp:BoundField DataField="FullName" HeaderText="Student Name" />
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                        <asp:ListItem>Present</asp:ListItem>
                        <asp:ListItem>Absent</asp:ListItem>
                        <asp:ListItem>Late</asp:ListItem>
                    </asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Remarks">
                <ItemTemplate>
                    <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <!-- Save Button -->
    <asp:Button ID="btnSave" runat="server" Text="💾 Save Attendance" CssClass="btn-save" OnClick="btnSave_Click" />
    <br />
    <asp:Label ID="lblMessage" runat="server" CssClass="message-label"></asp:Label>
</div>

</asp:Content>
