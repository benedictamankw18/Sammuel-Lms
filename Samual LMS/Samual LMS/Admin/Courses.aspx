<%@ Page Title="Courses" Language="C#" MasterPageFile="~/Admin/Admin.Master" 
    AutoEventWireup="true" CodeBehind="Courses.aspx.cs"
    Inherits="Samual_LMS.Admin.Courses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    Courses
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="headContent" runat="server">
    <style>
        .page-title {
            margin-bottom: 20px;
            color: #2c3e50;
            font-size: 24px;
            font-weight: bold;
        }

        .btn-add {
            background: #27ae60;
            color: white;
            padding: 8px 15px;
            border-radius: 4px;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 20px;
            transition: 0.2s;
        }

        .btn-add:hover {
            background: #1e8449;
        }

        .form-section, .table-section {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        .form-section label {
            font-weight: bold;
            display: block;
            margin-top: 10px;
        }

        .form-section input, .form-section textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .form-section button, .form-section .aspNetButton {
            margin-top: 15px;
            background: #34495e;
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .form-section button:hover, .form-section .aspNetButton:hover {
            background: #2c3e50;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border-bottom: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f4f4f4;
        }

        tr:hover {
            background-color: #f9f9f9;
        }

        .edit-btn {
            background: #2980b9;
            color: white;
            padding: 4px 10px;
            border-radius: 4px;
            text-decoration: none;
        }

        .delete-btn {
            background: #c0392b;
            color: white;
            padding: 4px 10px;
            border-radius: 4px;
            text-decoration: none;
        }

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2 class="page-title">Courses</h2>

    <!-- Add Course Button -->
    <asp:Button ID="btnShowForm" runat="server" CssClass="btn-add" Text="+ Add Course" OnClick="btnShowForm_Click" />

    <!-- Course Form -->
    <asp:Panel ID="Panel1" runat="server" CssClass="form-section" Visible="false">
        <h3><asp:Literal ID="litFormTitle" runat="server" Text="Add / Edit Course"></asp:Literal></h3>
        <asp:HiddenField ID="HiddenField1" runat="server" />

        <label for="TextBox1">Course Title:</label>
        <asp:TextBox ID="TextBox1" runat="server" />

        <label for="TextBox2">Description:</label>
        <asp:TextBox ID="TextBox2" runat="server" TextMode="MultiLine" Rows="3" />

        <label for="TextBox3">Instructor:</label>
        <asp:TextBox ID="TextBox3" runat="server" />

        <asp:Button ID="btnSaveCourse" runat="server" Text="Save" CssClass="aspNetButton" OnClick="btnSaveCourse_ServerClick" />
    </asp:Panel>

    <!-- Courses Table -->
    <div class="table-section">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
            OnRowCommand="gvCourses_RowCommand" CssClass="table">
            <Columns>
                <asp:BoundField DataField="CourseID" HeaderText="ID" ReadOnly="true" />
                <asp:BoundField DataField="Title" HeaderText="Title" />
                <asp:BoundField DataField="Description" HeaderText="Description" />
                <asp:BoundField DataField="Instructor" HeaderText="Instructor" />
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEdit" runat="server" Text="Edit" CssClass="edit-btn"
                            CommandName="EditCourse" CommandArgument='<%# Eval("CourseID") %>'
                            CausesValidation="false" />
                        &nbsp;
                        <asp:LinkButton ID="btnDelete" runat="server" Text="Delete" CssClass="delete-btn"
                            CommandName="DeleteCourse" CommandArgument='<%# Eval("CourseID") %>'
                            CausesValidation="false"
                            OnClientClick="return confirm('Are you sure you want to delete this course?');" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
