<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Samual_LMS.Admin.Default" %>

<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
    HOME
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">

        <style>
        /* Dashboard grid */
        .dashboard {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.2s ease;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card h3 {
            margin: 10px 0;
            color: #2c3e50;
        }

        .card p {
            color: #555;
            font-size: 14px;
        }

        .card a {
            display: inline-block;
            margin-top: 10px;
            background: #34495e;
            color: white;
            padding: 8px 15px;
            border-radius: 4px;
            text-decoration: none;
            transition: background 0.3s ease;
        }

        .card a:hover {
            background: #2c3e50;
        }

        /* Announcements section */
        .announcements {
            margin-top: 40px;
        }

        .announcements h2 {
            color: #2c3e50;
            border-bottom: 2px solid #ddd;
            padding-bottom: 5px;
        }

        .announcement-item {
            background: white;
            padding: 15px;
            margin-top: 10px;
            border-radius: 5px;
            box-shadow: 0 1px 4px rgba(0,0,0,0.05);
        }

        .announcement-item h4 {
            margin: 0 0 5px 0;
            color: #34495e;
        }

        .announcement-item p {
            margin: 0;
            color: #555;
            font-size: 14px;
        }
    </style>


</asp:Content>


<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Welcome, <asp:Label ID="lblUserName" runat="server" Text="User"></asp:Label>!</h2>
    <p>This is your LMS dashboard. Use the quick links below to navigate.</p>

    <!-- Dashboard Cards -->
    <div class="dashboard">
        <div class="card">
            <h3>Courses</h3>
            <p>View and manage your courses.</p>
            <a href="Courses.aspx">Go to Courses</a>
        </div>
        <div class="card">
            <h3>Users</h3>
            <p>Access user records and profiles.</p>
            <a href="Users.aspx">View Users</a>
        </div>
        <div class="card">
            <h3>Settings</h3>
            <p>Update your account and preferences.</p>
            <a href="Settings.aspx">Edit Settings</a>
        </div>
    </div>

   
</asp:Content>
