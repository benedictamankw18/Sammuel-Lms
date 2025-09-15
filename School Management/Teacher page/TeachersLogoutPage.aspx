<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher page/Teacher.Master" AutoEventWireup="true" CodeBehind="TeachersLogoutPage.aspx.cs" Inherits="School_Management.Teacher_page.TeachersLogoutPage" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div id="form1" runat="server">
        <div class="container d-flex justify-content-center align-items-center vh-100">
            <div class="card shadow-lg p-4 text-center" style="max-width: 400px; width: 100%;">
                <h3 class="text-danger mb-3">Logged Out</h3>
                <p class="mb-4">You have successfully logged out of your instructor dashboard.</p>
                <a href="Login.aspx" class="btn btn-primary w-100">Back to Login</a>
            </div>
        </div>
    </div>

</asp:Content>
