<%@ Page Title="" Language="C#" MasterPageFile="~/Admin page/Admin.Master" AutoEventWireup="true" CodeBehind="AdminLogout.aspx.cs" Inherits="School_Management.AdminLogout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

     <title>Logging Out...</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #0d6efd, #6c63ff);
            color: white;
            text-align: center;
            padding-top: 150px;
        }
        .logout-container {
            background: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 15px;
            display: inline-block;
        }
        h2 {
            margin-bottom: 10px;
        }
        .spinner {
            margin: 20px auto;
            width: 50px;
            height: 50px;
            border: 5px solid rgba(255, 255, 255, 0.3);
            border-top: 5px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>
    <meta http-equiv="refresh" content="2;url=AdminLogin.aspx" />

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
   

    <div id="form7" runat="server">
        <div class="logout-container">
            <h2>Logging you out...</h2>
            <div class="spinner"></div>
            <p>Redirecting to login page</p>
        </div>
    </div>



</asp:Content>
