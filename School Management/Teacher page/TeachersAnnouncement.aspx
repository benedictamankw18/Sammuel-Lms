<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher page/Teacher.Master" AutoEventWireup="true" CodeBehind="TeachersAnnouncement.aspx.cs" Inherits="School_Management.TeachersAnnouncement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <!DOCTYPE html>
    <title>Instructor Announcement</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .page-title {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .announcement-box {
            max-height: 400px;
            overflow-y: auto;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<html>
    <body>
    <div id="form1" runat="server" class="container mt-5">
        <div class="card p-4">
            <h2 class="page-title text-center">📢 Announcement</h2>
            
            <!-- New Announcement Form -->
            <div class="mb-4">
                <div class="mb-3">
                    <label for="ddlCourse" class="form-label">Select Course</label>
                    <asp:DropDownList ID="ddlCourse" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged"></asp:DropDownList>
                </div>
                <div class="mb-3">
                    <label for="txtTitle" class="form-label">Announcement Title</label>
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="e.g. Next Class Schedule"></asp:TextBox>
                </div>
                <div class="mb-3">
                    <label for="txtMessage" class="form-label">Message</label>
                    <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5"
                        placeholder="Enter announcement details here..."></asp:TextBox>
                </div>
                <%--<div class="mb-3">
                    <label for="txtDate" class="form-label">Date</label>
                    <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                </div>--%>
                <asp:Button ID="btnPost" runat="server" CssClass="btn btn-primary" Text="Post Announcement" OnClick="btnPost_Click" />
            </div>

            <!-- Announcement List -->
            <h4 class="mt-4">📜 Posted Announcements</h4>
            <div class="announcement-box mt-3">
                <asp:Repeater ID="rptAnnouncement" runat="server">
                    <ItemTemplate>
                        <div class="alert alert-info mb-3">
                            <h5><%# Eval("Title") %></h5>
                            <p><%# Eval("Message") %></p>
                            <small class="text-muted">Course: <%# Eval("CourseName") %> | Date: <%# Eval("AnnouncementDate") %></small>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</body>
</html>

</asp:Content>
