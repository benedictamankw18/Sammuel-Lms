<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Samual_LMS.Login" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>LMS Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-box {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            width: 350px;
            text-align: center;
        }
        .login-box img {
            width: 80px;
            margin-bottom: 15px;
        }
        .login-box h2 {
            margin-bottom: 20px;
            color: #333;
        }
        .login-box input[type="text"], 
        .login-box input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 8px 0 10px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }
        input#txtUsername{
            width: 93%
        }
        .login-box .password-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }
        .login-box .show-password {
            position: absolute;
            right: 10px;
            font-size: 12px;
            cursor: pointer;
            color: #007BFF;
        }
        .login-box input[type="submit"], 
        .login-box .aspNetButton {
            width: 100%;
            padding: 10px;
            background: #4facfe;
            border: none;
            border-radius: 6px;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        .login-box input[type="submit"]:hover,
        .login-box .aspNetButton:hover {
            background: #2196f3;
        }
        .error {
            color: red;
            margin-bottom: 10px;
            display: block;
            font-size: 13px;
        }
    </style>
    <script>
        function togglePassword() {
            var pwd = document.getElementById('<%= txtPassword.ClientID %>');
            var btnShow = document.getElementById('showpassword');
            if (pwd.type === "password") {
                pwd.type = "text";
                btnShow.innerText = "Hide"
            } else {
                pwd.type = "password";
                btnShow.innerText = "Show"
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-box">
            <!-- LMS Logo -->
            <img src="~/assets/img/lms-logo.png" alt="LMS Logo" />

            <h2>Welcome to LMS</h2>

            <!-- Username -->
            <asp:TextBox ID="txtUsername" runat="server" Placeholder="Username"></asp:TextBox>

            <!-- Password with Show Password -->
            <div class="password-wrapper">
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Password"></asp:TextBox>
                <span class="show-password" id="showpassword" onclick="togglePassword()">Show</span>
            </div>

            <!-- Error Message -->
            <asp:Label ID="lblMessage" runat="server" CssClass="error"></asp:Label>

            <!-- Login Button -->
            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="aspNetButton" OnClick="btnLogin_Click" />
        </div>
    </form>
</body>
</html>