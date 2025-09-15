<%@ Page Title="" Language="C#" MasterPageFile="~/Admin page/Admin.Master" AutoEventWireup="true" CodeBehind="AdminUser.aspx.cs" Inherits="School_Management.User" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Manage Users - LMS Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        .container {
            max-width: 1100px;
        }
        h2.mb-4 {
            color: #3a86ff;
            font-weight: 700;
            letter-spacing: 1px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        h2.mb-4 i {
            color: #4361ee;
        }
        .card {
            border-radius: 16px;
            box-shadow: 0 2px 12px rgba(60,60,120,0.10);
            margin-bottom: 24px;
            border: none;
        }
        .card-header {
            font-weight: 700;
            font-size: 1.15rem;
            background: linear-gradient(90deg, #3a86ff 0%, #4361ee 100%);
            color: #fff;
            border-radius: 16px 16px 0 0;
            padding: 16px 20px;
            letter-spacing: 0.5px;
        }
        .card-body {
            background: #fff;
            border-radius: 0 0 16px 16px;
            padding: 24px 20px 16px 20px;
        }
        .form-control {
            border-radius: 8px;
            font-size: 1rem;
        }
        .btn {
            border-radius: 8px;
            font-weight: 600;
            font-size: 1rem;
            box-shadow: 0 2px 8px rgba(60,60,120,0.07);
        }
        .btn-primary {
            background: #3a86ff;
            border: none;
        }
        .btn-primary:hover {
            background: #4361ee;
        }
        .table {
            border-radius: 12px;
            overflow: hidden;
            background: #fff;
        }
        .table th {
            background: #f4f6f8;
            color: #3a86ff;
            font-weight: 700;
        }
        .table td {
            vertical-align: middle;
        }
        .table-striped > tbody > tr:nth-of-type(odd) {
            background-color: #f8f9fa;
        }
        .table-striped > tbody > tr:nth-of-type(even) {
            background-color: #fff;
        }
        @media (max-width: 900px) {
            .container {
                padding: 0 4px;
            }
            .card-body {
                padding: 12px 6px 8px 6px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div id="form1" runat="server" class="container mt-5">
        <h2 class="mb-4"> Users Management</h2>

        <!-- Add User Section -->
        <div class="card mb-4">
            <div class="card-header"><i class="fa-solid fa-user-plus me-2"></i> Add New User</div>
            <div class="card-body row g-3">
                <div class="col-md-4">
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" TextMode="SingleLine" placeholder="Full Name" ValidateRequestMode="Enabled" required></asp:TextBox>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Email" ValidateRequestMode="Enabled" required></asp:TextBox>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" TextMode="Number" placeholder="Phone"></asp:TextBox>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Password" ValidateRequestMode="Enabled" required></asp:TextBox>
                </div>
                <div class="col-md-4">
                    <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Instructor" Value="Instructor"></asp:ListItem>
                        <asp:ListItem Text="Student" Value="Student"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-12">
                    <asp:Button ID="btnAddUser" runat="server" Text="Add User" CssClass="btn btn-primary" OnClick="btnAddUser_Click" />
                    <asp:Label ID="message" runat="server" Text=""></asp:Label>
                </div>
            </div>
        </div>

         <!-- Users Table -->
        <div class="card">
            <div class="card-header"><i class="fa-solid fa-list me-2"></i> Users List</div>
            <div class="card-body">
          <asp:GridView ID="gvUsers" runat="server" CssClass="table table-striped"
    AutoGenerateColumns="False" DataKeyNames="UserID"
    OnRowEditing="gvUsers_RowEditing" OnRowUpdating="gvUsers_RowUpdating"
    OnRowCancelingEdit="gvUsers_RowCancelingEdit" OnRowDeleting="gvUsers_RowDeleting">

    <Columns>
        <asp:BoundField DataField="UserID" HeaderText="ID" ReadOnly="True" />

        <asp:TemplateField HeaderText="Name">
            <ItemTemplate>
                <%# Eval("FullName") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtEditName" runat="server" CssClass="form-control"
                    Text='<%# Bind("FullName") %>' />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Email">
            <ItemTemplate>
                <%# Eval("Email") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtEditEmail" runat="server" CssClass="form-control"
                    Text='<%# Bind("Email") %>' />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Role">
            <ItemTemplate>
                <%# Eval("Role") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:DropDownList ID="ddlEditRole" runat="server" CssClass="form-control"
                    SelectedValue='<%# Bind("Role") %>'>
                    <asp:ListItem Text="Instructor" Value="Instructor" />
                    <asp:ListItem Text="Student" Value="Student" />
                </asp:DropDownList>
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Phone">
            <ItemTemplate>
                <%# Eval("Phone") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtEditPhone" runat="server" CssClass="form-control"
                    Text='<%# Bind("Phone") %>' />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:BoundField DataField="IsActive" HeaderText="Active" ReadOnly="True" />

        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" HeaderText="Action"
            EditText="<i class='fa-solid fa-pen-to-square'></i>"
            DeleteText="<i class='fa-solid fa-trash'></i>"
            UpdateText="<i class='fa-solid fa-pen-clip'></i>"
            CancelText="<i class='fa-solid fa-ban'></i>" />
    </Columns>
</asp:GridView>


            </div>
        </div>
    </div>
</asp:Content>
