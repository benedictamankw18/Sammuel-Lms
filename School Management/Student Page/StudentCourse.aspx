<%@ Page Title="" Language="C#" MasterPageFile="~/Student Page/Student.Master" AutoEventWireup="true" CodeBehind="StudentCourse.aspx.cs" Inherits="School_Management.StudentCourse" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        body {
            background-color: #f4f6f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .page-container {
            margin: 40px auto;
            max-width: 1200px;
        }
        h2 {
            font-weight: 600;
            color: #333;
            margin-bottom: 20px;
        }
        .card {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            padding: 25px;
            transition: all 0.3s ease;
            width: 100%;
        }
        .grid-container {
            overflow-x: auto; /* allows scrolling on small screens */
        }
        .gridview {
            width: 100%; /* makes GridView fill card width */
            border-collapse: collapse;
            table-layout: auto;
        }
        .gridview th, .gridview td {
            border: 1px solid #ddd;
            padding: 12px;
            font-size: 14px;
            color: #333;
            text-align: left;
        }
        .gridview th {
            background-color: #007bff;
            color: white;
            font-size: 15px;
        }
        .gridview tr:nth-child(even) {
            background-color: #f9fbfd;
        }
        .gridview tr:hover {
            background-color: #eef5ff;
        }
        .btn-enroll {
            border-radius: 20px;
            padding: 6px 16px;
            font-weight: 500;
            background-color: #28a745;
            color: #fff;
            border: none;
            cursor: pointer;
            transition: 0.3s;
        }
        .btn-enroll:hover {
            background-color: #218838;
        }
        .form-control {
            border-radius: 6px;
            border: 1px solid #ccc;
            padding: 6px 10px;
            width: 100%;
        }
        .message {
            margin-top: 20px;
            font-size: 15px;
            font-weight: 500;
            color: #cc0000;
        }
    </style>
   

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

   <div id="form1" runat="server" class="container mt-5">
        <h2>📘 Available Courses</h2>
        <asp:GridView ID="gvCourses" runat="server" AutoGenerateColumns="False" 
    CssClass="table table-bordered table-hover text-center align-middle"
    HeaderStyle-CssClass="table-dark"
    OnRowCommand="gvCourses_RowCommand">
    <Columns>
             <asp:BoundField DataField="CourseID" HeaderText="Course ID" />
                <asp:BoundField DataField="CourseName" HeaderText="Course Name" />
                
        <asp:TemplateField HeaderText="Enrollment Key">
            <ItemTemplate>
                <asp:TextBox ID="txtEnrollmentKey" runat="server" Enabled='<%# !(Convert.ToBoolean(Eval("IsEnrolled"))) %>'></asp:TextBox>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField>
            <ItemTemplate>
                <asp:Button ID="btnEnroll" runat="server" 
                    Text='<%# Convert.ToBoolean(Eval("IsEnrolled")) ? "✅ Enrolled" : "Enroll" %>' 
                    CommandName="Enroll" 
                    CommandArgument='<%# Eval("CourseID") %>' 
                    CssClass='<%# Convert.ToBoolean(Eval("IsEnrolled")) ? "btn btn-success btn-sm disabled" : "btn btn-primary btn-sm" %>' 
                    Enabled='<%# !(Convert.ToBoolean(Eval("IsEnrolled"))) %>' />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger fw-bold"></asp:Label>
    </div>


</asp:Content>
