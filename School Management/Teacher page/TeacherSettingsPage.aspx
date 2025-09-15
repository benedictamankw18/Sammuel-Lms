<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher page/Teacher.Master" AutoEventWireup="true" CodeBehind="TeacherSettingsPage.aspx.cs" Inherits="School_Management.Teacher_page.TeavherSettingsPage" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title> Settings </title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .settings-container {
            max-width: 800px;
            margin: 40px auto;
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        h2 {
            font-weight: 600;
            margin-bottom: 25px;
            color: #0d6efd;
        }
        .form-label {
            font-weight: 500;
        }
        .btn-save {
            background: #0d6efd;
            color: #fff;
            font-weight: 500;
            border-radius: 8px;
        }
        .btn-save:hover {
            background: #084298;
        }
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div id="form1" runat="server">
        <div class="settings-container">
    <h2> Settings </h2>

    <div class="mb-3">
        <label for="txtFullName" class="form-label">Full Name</label>
        <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" Placeholder="Enter your full name"></asp:TextBox>
    </div>

    <div class="mb-3">
        <label for="txtEmail" class="form-label">Email Address</label>
        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" Placeholder="Enter your email"></asp:TextBox>
    </div>

    <!-- Password with toggle -->
    <div class="mb-3 position-relative">
        <label for="txtPassword" class="form-label">New Password</label>
        <div class="input-group">
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Enter new password"></asp:TextBox>
            <button type="button" class="btn btn-outline-secondary" onclick="togglePassword()">
                <i class="bi bi-eye" id="toggleIcon">👁️</i>
            </button>
        </div>
    </div>

    <!-- Date of Birth with datetime picker -->
    <div class="mb-3">
        <label for="txtDOB" class="form-label">Date of Birth</label>
        <asp:TextBox ID="txtDOB" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
    </div>

    <div class="mb-3">
        <label for="txtPhone" class="form-label">Phone</label>
        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" Placeholder="Enter phone number"></asp:TextBox>
    </div>

    <div class="text-center mt-4">
        <asp:Button ID="btnSaveSettings" runat="server" Text="Save Changes" CssClass="btn btn-save px-4 py-2" OnClick="btnSaveSettings_Click" />
    </div>

    <!-- Message Label -->
    <asp:Label ID="lblMessage" runat="server"></asp:Label>
</div>

    </div>


    <script>
function togglePassword() {
    const passwordInput = document.getElementById("<%= txtPassword.ClientID %>");
    const toggleIcon = document.getElementById("toggleIcon");

    if (passwordInput.type === "password") {
        passwordInput.type = "text";
        toggleIcon.classList.remove("bi-eye");
        toggleIcon.classList.add("bi-eye-slash");
    } else {
        passwordInput.type = "password";
        toggleIcon.classList.remove("bi-eye-slash");
        toggleIcon.classList.add("bi-eye");
    }
}
</script>

</asp:Content>
