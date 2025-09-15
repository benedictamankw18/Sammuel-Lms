<%@ Page Title="" Language="C#" MasterPageFile="~/Student Page/Student.Master" AutoEventWireup="true" CodeBehind="ProfileAndSettings.aspx.cs" Inherits="School_Management.Student_Page.ProfileAndSettings" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .profile-container {
            max-width: 500px;
            margin: 40px auto;
            text-align: left;
            font-family: Arial;
        }
        .profile-card {
            background: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        .input-box {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }
        .btn-save {
            margin-top: 15px;
            background: #007bff;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }
        .btn-save:hover {
            background: #0056b3;
        }
        .status-message {
            font-weight: bold;
            margin-bottom: 10px;
            color: green;
        }
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="profile-container">
        <h2>👤 Student Profile & Settings</h2>

        <!-- Profile Card -->
        <div class="profile-card">
            <asp:Label ID="lblMessage" runat="server" CssClass="status-message"></asp:Label>

            <asp:Label ID="lblStudentID" runat="server" Visible="false"></asp:Label>

            <label>Full Name:</label>
            <asp:TextBox ID="txtFullName" runat="server" CssClass="input-box"></asp:TextBox>

            <label>Email:</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="input-box" ReadOnly="true"></asp:TextBox>

            <label>New Password:</label>
            <asp:TextBox ID="txtPassword" runat="server" CssClass="input-box" TextMode="Password"></asp:TextBox>

            <label>Confirm Password:</label>
            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="input-box" TextMode="Password"></asp:TextBox>

            <asp:Button ID="btnUpdate" runat="server" Text="💾 Update Profile" CssClass="btn-save" OnClick="btnUpdate_Click" />
        </div>
    </div>

</asp:Content>
