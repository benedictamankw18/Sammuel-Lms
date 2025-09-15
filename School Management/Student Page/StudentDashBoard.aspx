<%@ Page Title="" Language="C#" MasterPageFile="~/Student Page/Student.Master" AutoEventWireup="true" CodeBehind="StudentDashBoard.aspx.cs" Inherits="School_Management.StudentDashBoard" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <div class="container py-4">
        <div class="row mb-4">
            <div class="col-12 text-center">
                <h2 class="fw-bold text-primary">Welcome to Your Student Dashboard</h2>
                <p class="lead">Access your courses, quizzes and profile & settings.</p>
            </div>
        </div>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card shadow h-100">
                    <div class="card-body text-center">
                        <i class="bi bi-journal-bookmark-fill display-4 text-success mb-3"></i>
                        <h5 class="card-title">My Courses</h5>
                        <p class="card-text">View and manage your enrolled courses.</p>
                        <a href="StudentCourse.aspx" class="btn btn-outline-success">Go to Courses</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card shadow h-100">
                    <div class="card-body text-center">
                        <i class="bi bi-clipboard-check display-4 text-info mb-3"></i>
                        <h5 class="card-title">Quizzes</h5>
                        <p class="card-text">Attempt quizzes and view your results.</p>
                        <a href="Quizzess.aspx" class="btn btn-outline-info">Go to Quizzes</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card shadow h-100">
                    <div class="card-body text-center">
                        <i class="bi bi-person-circle display-4 text-warning mb-3"></i>
                        <h5 class="card-title">Profile & Settings</h5>
                        <p class="card-text">Update your profile and account settings.</p>
                        <a href="ProfileAndSettings.aspx" class="btn btn-outline-warning">Edit Profile</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-5">
            <div class="col-12 text-center">
                <p class="text-muted">Have questions or need help? <a href="Support.aspx">Contact Support</a></p>
            </div>
        </div>
    </div>

</asp:Content>
