        <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="web1.aspx.cs" Inherits="School_Management.web1" %>
<!DOCTYPE html>
<html lang="en">
</head>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Form</title>
    <link rel="stylesheet" type="text/css" href="presentation-theme.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        body {
            background-image: url('images/uigm-nc.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .toggle-btn {
            position: absolute;
            right: 15px;
            top: 38px;
            background: none;
            border: none;
            cursor: pointer;
            color: #4a90e2;
            font-size: 1.2rem;
            padding: 0;
        }
        .login-container {
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 350px;
        }
        .txtpassword{
            padding-right: 30px; /* Space for the toggle button */
        }
    </style>
</head>
</head>
<body>
    <form id="loginForm" runat="server" >
        <div class="login-container" >
            <h2>LMS Login</h2>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
            <div class="form-group">
            <label>Email</label>
            <asp:TextBox ID="txtEmail" runat="server" Width="90%" TextMode="Email" ValidateRequestMode="Enabled"></asp:TextBox>
            <div class="error" ID="emailError"></div>
                    </div>
        <div class="form-group password-toggle" style="position:relative;">
            <label>Password</label>
            <asp:TextBox ID="txtPassword" CssClass="txtpassword"  runat="server" Width="85%" TextMode="Password"></asp:TextBox>
            <button type="button" class="toggle-btn" onclick="togglePassword()" tabindex="-1">
                <i id="toggleIcon" class="fa-solid fa-eye"></i>
            </button>
            <div class="error" ID="passwordError"></div>
        </div>
            <asp:Button ID="btnLogin" CssClass="button" runat="server" Text="Login" Width="100%" OnClick="btnLogin_Click" />
        </div>
    </form>


<script>
    const email = document.getElementById("txtEmail");
    const password = document.getElementById("txtPassword");
    const emailError = document.getElementById("emailError");
    const passwordError = document.getElementById("passwordError");

    document.getElementById("loginForm").addEventListener("submit", function(e) {
    let valid = true;

    emailError.textContent = "";
    passwordError.textContent = "";

    if (email.value.trim() === "") {
        emailError.textContent = "Email is required.";
        valid = false;
    }
    if (password.value.trim() === "") {
        passwordError.textContent = "Password is required.";
        valid = false;
    }

    if (!valid) {
        e.preventDefault(); // ✅ Only stop postback if form is invalid
    }
});

    function togglePassword() {
        const toggleIcon = document.getElementById("toggleIcon");
        if (password.type === "password") {
            password.type = "text";
            toggleIcon.classList.remove("fa-eye");
            toggleIcon.classList.add("fa-eye-slash");
        } else {
            password.type = "password";
            toggleIcon.classList.remove("fa-eye-slash");
            toggleIcon.classList.add("fa-eye");
        }
    }
   <%-- const email = document.getElementById("<%= txtEmail.ClientID %>");
const password = document.getElementById("<%= txtPassword.ClientID %>");
--%>

</script>

</body>
</html>

