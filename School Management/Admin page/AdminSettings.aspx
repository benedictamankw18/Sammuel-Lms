<%@ Page Title="" Language="C#" MasterPageFile="~/Admin page/Admin.Master" AutoEventWireup="true" CodeBehind="AdminSettings.aspx.cs" Inherits="School_Management.AdminSettings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

   
    <style>
        .settings-container {
            max-width: 800px;
            margin: 36px auto;
            background: #fff;
            padding: 32px 28px 28px 28px;
            border-radius: 18px;
            box-shadow: 0 4px 18px rgba(60,60,120,0.10);
        }
        .settings-container h2 {
            text-align: center;
            margin-bottom: 28px;
            color: #3a86ff;
            font-weight: 700;
            letter-spacing: 1px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .settings-container h2 i {
            color: #4361ee;
        }
        .settings-container h3 {
            color: #4361ee;
            font-size: 1.2rem;
            font-weight: 700;
            margin-top: 24px;
            margin-bottom: 18px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            color: #34495e;
        }
        input[type="text"], input[type="password"], input[type="email"], select {
            width: 100%;
            padding: 12px;
            border: 1px solid #bdc3c7;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        input:focus, select:focus {
            border-color: #3a86ff;
            outline: none;
            box-shadow: 0 0 0 2px #3a86ff22;
        }
        .btn-Update, .btn {
            padding: 10px 24px;
            background: #3a86ff;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            box-shadow: 0 2px 8px rgba(60,60,120,0.07);
            transition: background 0.18s;
        }
        .btn-Update:hover, .btn:hover {
            background: #4361ee;
        }
        .success-message {
            color: #28a745;
            font-weight: bold;
            text-align: center;
            margin-bottom: 15px;
        }
        .error-message {
            color: #dc3545;
            font-weight: bold;
            text-align: center;
            margin-bottom: 15px;
        }
        hr {
            margin: 32px 0 24px 0;
            border-top: 2px solid #f4f6f8;
        }
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">


   <div class="settings-container">
    <h2><i class="fa-solid fa-gear"></i> Admin Settings</h2>

    <!-- Profile Section -->
    <h3><i class="fa-solid fa-user"></i> Profile Information</h3>
    <asp:Label ID="lblProfileMessage" runat="server" CssClass="success-message"></asp:Label>
    <div class="form-group">
        <label><i class="fa-solid fa-user"></i> Full Name</label>
        <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" />
    </div>
    <div class="form-group">
        <label><i class="fa-solid fa-envelope"></i> Email Address</label>
        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" />
    </div>
    <asp:Button ID="btnUpdateProfile" runat="server" Text="Update Profile" CssClass="btn-Update" OnClick="btnUpdateProfile_Click" />

    <hr />

    <!-- Password Section -->
    <h3><i class="fa-solid fa-key"></i> Change Password</h3>
    <asp:Label ID="lblPasswordMessage" runat="server" CssClass="error-message"></asp:Label>
    <div class="form-group">
        <label><i class="fa-solid fa-lock"></i> Current Password</label>
        <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password" CssClass="form-control" />
    </div>
    <div class="form-group">
        <label><i class="fa-solid fa-lock"></i> New Password</label>
        <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="form-control" />
    </div>
    <div class="form-group">
        <label><i class="fa-solid fa-lock"></i> Confirm Password</label>
        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" />
    </div>
    <asp:Button ID="btnChangePassword" runat="server" Text="Change Password" CssClass="btn" OnClick="btnChangePassword_Click" />

    <hr />

   
</div>

</asp:Content>
