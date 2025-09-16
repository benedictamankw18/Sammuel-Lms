<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="Samual_LMS.Admin.Settings" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    Settings
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="headContent" runat="server">
        <style>

    <!-- Bootstrap CSS -->
 body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 0;
        }

        h2 {
            color: #2c3e50;
            margin-bottom: 20px;
        }

        .settings-panel {
            background: #ffffff;
            padding: 25px 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            max-width: 700px;
            margin: 30px auto;
        }

        fieldset {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
        }

        legend {
            font-weight: bold;
            padding: 0 10px;
            color: #34495e;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
            color: #34495e;
        }

        input[type="text"],
        input[type="password"],
        input[type="file"],
        .form-control {
            width: 100%;
            padding: 8px 12px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        .btn-save {
            background-color: #2980b9;
            color: #fff;
            padding: 10px 20px;
            font-size: 15px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .btn-save:hover {
            background-color: #1c5980;
        }

        .alert {
            padding: 10px 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            color: #155724;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
        }

        .validation-error {
            color: #c0392b;
            font-size: 13px;
            margin-top: -10px;
            margin-bottom: 10px;
            display: block;
        }
    </style>
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <div class="settings-panel">
        <h2>Admin Settings</h2>

        <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert">
            <asp:Label ID="lblMessage" runat="server" />
        </asp:Panel>

        <fieldset>
            <legend>Profile Information</legend>
            
            <label>Full Name:</label>
            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" />

            <label>Email:</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
            <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                ControlToValidate="txtEmail"
                ErrorMessage="Invalid Email"
                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                CssClass="validation-error" />

            <label>Phone:</label>
            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" />
            <asp:RegularExpressionValidator ID="revPhone" runat="server" 
                ControlToValidate="txtPhone"
                ErrorMessage="Invalid Phone Number"
                ValidationExpression="^\d{10,15}$"
                CssClass="validation-error" />

            <label>Profile Picture:</label>
            <asp:FileUpload ID="fuProfilePic" runat="server" />
        </fieldset>

        <fieldset>
            <legend>Login Settings</legend>
            
            <label>Username:</label>
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" />

            <label>New Password:</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" />

            <label>Confirm Password:</label>
            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" />
            <asp:CompareValidator ID="cvPassword" runat="server" 
                ControlToValidate="txtConfirmPassword"
                ControlToCompare="txtPassword"
                ErrorMessage="Passwords do not match"
                CssClass="validation-error" />
        </fieldset>

        <asp:Button ID="btnSave" runat="server" Text="Save Settings" CssClass="btn-save" OnClick="btnSave_Click" />
    </div>
</asp:Content>
