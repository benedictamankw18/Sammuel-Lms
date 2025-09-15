<%@ Page Title="" Language="C#" MasterPageFile="~/Admin page/Admin.Master" AutoEventWireup="true" CodeBehind="AdminReport.aspx.cs" Inherits="School_Management.Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .report-container {
            padding: 28px 0 0 0;
            background: #f4f6f9;
        }
        .report-container h2 {
            color: #3a86ff;
            font-weight: 700;
            letter-spacing: 1px;
            margin-bottom: 28px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .report-container h2 i {
            color: #4361ee;
        }
        .stat-card {
            background: linear-gradient(135deg, #3a86ff 0%, #4361ee 100%);
            border-radius: 16px;
            box-shadow: 0 2px 12px rgba(60,60,120,0.10);
            padding: 28px 18px 22px 18px;
            text-align: center;
            color: #fff;
            margin-bottom: 24px;
            position: relative;
            overflow: hidden;
            transition: transform 0.18s, box-shadow 0.18s;
        }
        .stat-card:hover {
            transform: translateY(-4px) scale(1.04);
            box-shadow: 0 6px 24px rgba(60,60,120,0.13);
        }
        .stat-title {
            font-size: 1.1rem;
            color: #e0e7ff;
            margin-bottom: 8px;
        }
        .stat-value {
            font-size: 2.1rem;
            font-weight: 700;
            color: #fff;
        }
        .stat-icon {
            font-size: 2.2rem;
            margin-bottom: 10px;
            color: #fff;
            opacity: 0.85;
        }
        .grid-section {
            background: #fff;
            padding: 24px 18px 18px 18px;
            border-radius: 14px;
            box-shadow: 0 2px 8px rgba(60,60,120,0.07);
            margin-top: 32px;
        }
        .grid-section h4 {
            color: #3a86ff;
            font-size: 1.2rem;
            font-weight: 700;
            margin-bottom: 18px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .recent-logins {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        .login-card {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: #fff;
            padding: 16px 18px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(60,60,120,0.07);
            transition: 0.18s;
        }
        .login-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 16px rgba(60,60,120,0.13);
        }
        .login-avatar {
            font-size: 2.2rem;
            color: #3a86ff;
            margin-right: 14px;
        }
        .login-details {
            flex: 1;
        }
        .login-name {
            font-weight: 700;
            font-size: 1.1rem;
            color: #222;
        }
        .login-email {
            font-size: 0.98rem;
            color: #666;
        }
        .login-time {
            font-size: 0.95rem;
            color: #999;
            white-space: nowrap;
        }
        .badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 13px;
            font-weight: 600;
            letter-spacing: 0.5px;
            color: #fff;
            margin: 3px 0;
        }
        .badge-admin {
            background-color: #dc3545;
        }
        .badge-student {
            background-color: #28a745;
        }
        .badge-lecturer {
            background-color: #007bff;
        }
        .badge-default {
            background-color: #6c757d;
        }
        @media (max-width: 900px) {
            .report-container {
                padding: 0 4px;
            }
            .grid-section {
                padding: 12px 6px 8px 6px;
            }
        }
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
     <div class="report-container">
        <h2><i class="fa-solid fa-chart-line"></i> Admin Reports</h2>
        <hr />

        <!-- Stats Cards -->
        <div class="row">
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fa-solid fa-book"></i></div>
                    <div class="stat-title">Total Courses</div>
                    <div class="stat-value">
                        <asp:Label ID="lblTotalCourses" runat="server" Text="0"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fa-solid fa-users"></i></div>
                    <div class="stat-title">Total Users</div>
                    <div class="stat-value">
                        <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fa-solid fa-user-check"></i></div>
                    <div class="stat-title">Active Users</div>
                    <div class="stat-value">
                        <asp:Label ID="lblActiveUsers" runat="server" Text="0"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fa-solid fa-clock-rotate-left"></i></div>
                    <div class="stat-title">Recent Logins</div>
                    <div class="stat-value">
                        <asp:Label ID="lblRecentLogins" runat="server" Text="0"></asp:Label>
                    </div>
                </div>
            </div>
        </div>

       <!-- Recent Activity -->
        <div class="grid-section">
            <h4><i class="fa-solid fa-clock"></i> Recent User Logins</h4>
            <div class="recent-logins">
                <asp:Repeater ID="rptRecentLogins" runat="server">
                    <ItemTemplate>
                        <div class="login-card">
                            <div class="login-avatar">
                                <i class="fa-solid fa-user-circle"></i>
                            </div>
                            <div class="login-details">
                                <div class="login-name"><%# Eval("FullName") %></div>
                                <div class="login-role badge <%# GetRoleCssClass(Eval("Role").ToString()) %>">
                                    <%# Eval("Role") %>
                                </div>
                                <div class="login-email"><%# Eval("Email") %></div>
                            </div>
                            <div class="login-time">
                                <%# String.Format("{0:dd MMM yyyy, hh:mm tt}", Eval("LastLogin")) %>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

</asp:Content>
