<%@ Page Title="" Language="C#" MasterPageFile="~/Admin page/Admin.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="School_Management.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">



    <title>Admin - Dashboard</title>
    <style>
        .dashboard-container {
            padding: 24px 0 0 0;
        }
        .dashboard-title {
            font-size: 2rem;
            font-weight: 700;
            color: #3a86ff;
            margin-bottom: 28px;
            letter-spacing: 1px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .dashboard-title i {
            color: #4361ee;
        }
        .row {
            display: flex;
            gap: 18px;
            width: 100%;
            margin-bottom: 18px;
        }
        .col-md-3 {
            flex: 1;
            min-width: 220px;
        }
        .stat-card {
            background: linear-gradient(135deg, #3a86ff 0%, #4361ee 100%);
            border-radius: 16px;
            box-shadow: 0 2px 12px rgba(60,60,120,0.10);
            padding: 28px 18px 22px 18px;
            text-align: center;
            color: #fff;
            position: relative;
            overflow: hidden;
            transition: transform 0.18s, box-shadow 0.18s;
        }
        .stat-card:hover {
            transform: translateY(-4px) scale(1.04);
            box-shadow: 0 6px 24px rgba(60,60,120,0.13);
        }
        .stat-icon {
            font-size: 2.2rem;
            margin-bottom: 10px;
            color: #fff;
            opacity: 0.85;
        }
        .stat-number {
            font-size: 2.1rem;
            font-weight: 700;
            color: #fff;
        }
        .stat-label {
            font-size: 1.1rem;
            color: #e0e7ff;
            margin-bottom: 8px;
        }
        .shortcut-btn {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 8px 16px;
            border-radius: 8px;
            background: #fb5607;
            color: #fff;
            text-decoration: none;
            margin-top: 10px;
            font-weight: 600;
            font-size: 1rem;
            box-shadow: 0 2px 8px rgba(60,60,120,0.07);
            transition: background 0.18s;
        }
        .shortcut-btn:hover {
            background: #ff006e;
            color: #fff;
        }
        .recent-activity {
            margin-top: 36px;
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 2px 8px rgba(60,60,120,0.07);
            padding: 24px 18px 18px 18px;
        }
        .recent-activity h3 {
            color: #3a86ff;
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 18px;
        }
        .recent-activity table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
        }
        .recent-activity th, .recent-activity td {
            padding: 12px 10px;
            border-bottom: 1px solid #e0e7ff;
            font-size: 1rem;
        }
        .recent-activity th {
            background: #f4f6f8;
            color: #3a86ff;
            font-weight: 700;
        }
        .role-badge {
            padding: 4px 10px;
            border-radius: 4px;
            color: white;
            font-size: 13px;
            font-weight: 600;
            letter-spacing: 0.5px;
        }
        .role-admin {
            background: #dc3545;
        }
        .role-teacher {
            background: #28a745;
        }
        .role-student {
            background: #17a2b8;
        }
        @media (max-width: 900px) {
            .row {
                flex-direction: column;
                gap: 12px;
            }
            .col-md-3 {
                min-width: 0;
            }
            .dashboard-title {
                font-size: 1.2rem;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <div class="dashboard-container">
        <div class="dashboard-title"><i class="fa-solid fa-gauge-high"></i> Admin Dashboard</div>

        <!-- Stats Section -->
        <div class="row">
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fa-solid fa-users"></i></div>
                    <div class="stat-number"><asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label></div>
                    <div class="stat-label">Total Users</div>
                    <a href="AdminUser.aspx" class="shortcut-btn"><i class="fa-solid fa-user-gear"></i> Manage Users</a>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fa-solid fa-book"></i></div>
                    <div class="stat-number"><asp:Label ID="lblTotalCourses" runat="server" Text="0"></asp:Label></div>
                    <div class="stat-label">Total Courses</div>
                    <a href="AdminManageCourses.aspx" class="shortcut-btn"><i class="fa-solid fa-book-open-reader"></i> Manage Courses</a>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fa-solid fa-user-check"></i></div>
                    <div class="stat-number"><asp:Label ID="lblActiveUsers" runat="server" Text="0"></asp:Label></div>
                    <div class="stat-label">Active Users</div>
                    <a href="AdminReport.aspx" class="shortcut-btn"><i class="fa-solid fa-chart-line"></i> View Reports</a>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fa-solid fa-clock-rotate-left"></i></div>
                    <div class="stat-number"><asp:Label ID="lblPendingTasks" runat="server" Text="0"></asp:Label></div>
                    <div class="stat-label">Recent Login</div>
                    <a href="AdminSettings.aspx" class="shortcut-btn"><i class="fa-solid fa-gear"></i> Settings</a>
                </div>
            </div>
        </div>

        <!-- Recent Activity Section -->
        <div class="recent-activity">
            <h3><i class="fa-solid fa-clock"></i> Recent Login Sessions</h3>
            <asp:GridView ID="gvRecentLogins" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered">
                <Columns>
                    <asp:BoundField DataField="FullName" HeaderText="<i class='fa-solid fa-user'></i> Full Name" />
                    <asp:BoundField DataField="Email" HeaderText="<i class='fa-solid fa-envelope'></i> Email" />
                    <asp:TemplateField HeaderText="<i class='fa-solid fa-user-tag'></i> Role">
                        <ItemTemplate>
                            <span class='role-badge <%# Eval("Role").ToString() == "Admin" ? "role-admin" : (Eval("Role").ToString() == "Teacher" ? "role-teacher" : "role-student") %>'>
                                <%# Eval("Role") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="LastLogin" HeaderText="<i class='fa-solid fa-right-to-bracket'></i> Last Login" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                    <asp:BoundField DataField="LastLogout" HeaderText="<i class='fa-solid fa-right-from-bracket'></i> Last Logout" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

</asp:Content>
