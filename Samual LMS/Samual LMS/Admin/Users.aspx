<%@ Page Title="Manage Students & Teachers" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="Samual_LMS.Admin.Users" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="headContent" runat="server">
    <style>
        /* Page title */
        .page-title {
            font-size: 1.8rem;
            margin-bottom: 20px;
            color: #2c3e50;
            font-weight: bold;
        }

        /* Section styling */
        .form-section, .table-section {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        /* Labels and inputs */
        .form-section label {
            font-weight: bold;
            margin-top: 10px;
            display: block;
        }

        .form-section input, 
        .form-section select, 
        .form-section textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        /* Buttons */
        .btn {
            margin-top: 15px;
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            color: white;
        }
        .btn-save { background: #27ae60; }
        .btn-save:hover { background: #1e8449; }
        .btn-cancel { background: #7f8c8d; }
        .btn-cancel:hover { background: #626e70; }

        /* Table */
        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table th, .table td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        .table th {
            background: #f4f4f4;
        }

        .table tr:hover {
            background: #f9f9f9;
        }

        /* Action buttons in table */
        .action-btn {
            padding: 4px 10px;
            margin: 0 3px;
            border-radius: 4px;
            text-decoration: none;
            color: white;
            font-size: 0.85rem;
        }
        .edit-btn { background: #2980b9; }
        .edit-btn:hover { background: #21618c; }
        .delete-btn { background: #c0392b; }
        .delete-btn:hover { background: #922b21; }
    </style>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>


</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

     <h2 class="page-title">Manage Students & Teachers</h2>

    <!-- Add/Edit User Form -->
    <asp:Panel ID="pnlForm" runat="server" CssClass="form-section" Visible="false">
        <h3><asp:Literal ID="litFormTitle" runat="server" Text="Add / Edit User"></asp:Literal></h3>
        <asp:HiddenField ID="hfUserID" runat="server" />

        <label>Full Name:</label>
        <asp:TextBox ID="txtFullName" runat="server" />

      <!-- Email -->
<label for="txtEmail">Instructor Email:</label>
<asp:TextBox ID="txtEmail" runat="server" />
<asp:RegularExpressionValidator 
    ID="revEmail" runat="server"
    ControlToValidate="txtEmail"
    ErrorMessage="Please enter a valid email address."
    ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
    ForeColor="Red" Display="Dynamic" />

<!-- Phone -->
<label for="txtPhone">Instructor Phone:</label>
<asp:TextBox ID="txtPhone" runat="server" />
<asp:RegularExpressionValidator 
    ID="revPhone" runat="server"
    ControlToValidate="txtPhone"
    ErrorMessage="Please enter a valid phone number."
    ValidationExpression="^\+?\d{10,15}$"
    ForeColor="Red" Display="Dynamic" />

        <asp:ValidationSummary ID="valSummary" runat="server" ForeColor="Red" ShowSummary="true" />

<!-- Required Field Validation -->
<asp:RequiredFieldValidator 
    ID="reqEmail" runat="server"
    ControlToValidate="txtEmail"
    ErrorMessage="Email is required."
    ForeColor="Red" Display="Dynamic" />

<asp:RequiredFieldValidator 
    ID="reqPhone" runat="server"
    ControlToValidate="txtPhone"
    ErrorMessage="Phone is required."
    ForeColor="Red" Display="Dynamic" />


        <label>User Type:</label>
        <asp:DropDownList ID="ddlUserType" runat="server">
            <asp:ListItem Value="Student">Student</asp:ListItem>
            <asp:ListItem Value="Teacher">Teacher</asp:ListItem>
        </asp:DropDownList>

        <asp:Label ID="lblError" runat="server" ForeColor="Red" />


        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-save" Text="Save" OnClick="btnSave_Click" />
        <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-cancel" Text="Cancel" OnClick="btnCancel_Click" />
    </asp:Panel>

    <!-- Users Table -->
    <div class="table-section">
        <asp:Button ID="btnAddNew" runat="server" CssClass="btn btn-save" Text="Add New User" OnClick="btnAddNew_Click" />

        <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="table" 
            OnRowCommand="gvUsers_RowCommand">
            <Columns>
                <asp:BoundField DataField="UserID" HeaderText="ID" ReadOnly="true" />
                <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="Phone" HeaderText="Phone" />
                <asp:BoundField DataField="UserType" HeaderText="User Type" />
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEdit" runat="server" CssClass="action-btn edit-btn" Text="Edit"
                            CommandName="EditUser" CommandArgument='<%# Eval("UserID") %>' CausesValidation="false" />
                        <asp:LinkButton ID="btnDelete" runat="server" CssClass="action-btn delete-btn" Text="Delete"
                            CommandName="DeleteUser" CommandArgument='<%# Eval("UserID") %>'
                            OnClientClick="return confirm('Are you sure you want to delete this user?');"
                            CausesValidation="false" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

</asp:Content>