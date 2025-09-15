<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher page/Teacher.Master" AutoEventWireup="true" CodeBehind="TeacherDashBoard.aspx.cs" Inherits="School_Management.TeacherDashBoard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title>Instructor Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f8f9fa;
        }
        .dashboard-container {
            margin-top: 40px;
        }
        .card {
            border-radius: 1rem;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
            transition: transform 0.2s;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card-icon {
            font-size: 2.5rem;
            color: #0d6efd;
        }
        .card-title {
            font-size: 1.2rem;
            font-weight: 600;
        }
        .stat-number {
            font-size: 1.8rem;
            font-weight: bold;
        }
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

      <div id="form1" runat="server">
        <div class="container dashboard-container">
            <h2 class="text-center mb-4">📊 Instructor Dashboard</h2>

            <div class="row g-4">
                <!-- Courses Card -->
                <div class="col-md-3">
                    <div class="card text-center p-3">
                        <i class="fa-solid fa-book card-icon"></i>
                        <div class="card-body">
                            <h5 class="card-title">My Courses</h5>
                            <asp:Label ID="lblCoursesCount" runat="server" CssClass="stat-number"></asp:Label>
                        </div>
                    </div>
                </div>

                <!-- Students Card -->
                <div class="col-md-3">
                    <div class="card text-center p-3">
                        <i class="fa-solid fa-user-graduate card-icon"></i>
                        <div class="card-body">
                            <h5 class="card-title">Enrolled Students</h5>
                            <asp:Label ID="lblStudentsCount" runat="server" CssClass="stat-number"></asp:Label>
                        </div>
                    </div>
                </div>

                <!-- Quizzes Card -->
                <div class="col-md-3">
                    <div class="card text-center p-3">
                        <i class="fa-solid fa-clipboard-question card-icon"></i>
                        <div class="card-body">
                            <h5 class="card-title">Total Quizzes</h5>
                            <asp:Label ID="lblQuizzesCount" runat="server" CssClass="stat-number"></asp:Label>
                        </div>
                    </div>
                </div>

                <!-- Attempts Card -->
                <div class="col-md-3">
                    <div class="card text-center p-3">
                        <i class="fa-solid fa-chart-line card-icon"></i>
                        <div class="card-body">
                            <h5 class="card-title">Quiz Attempts</h5>
                            <asp:Label ID="lblAttemptsCount" runat="server" CssClass="stat-number"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Activity Section -->
            <div class="row mt-5">
                <div class="col-md-12">
                    <div class="card p-3">
                        <h5 class="mb-3"><i class="fa-solid fa-clock-rotate-left me-2"></i> Recent Activity</h5>
                        <asp:GridView ID="gvRecentActivity" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover">
                            <Columns>
                                <asp:BoundField DataField="Activity" HeaderText="Activity" />
                                <asp:BoundField DataField="Date" HeaderText="Date" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
