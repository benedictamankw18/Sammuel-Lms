<%@ Page Title="" Language="C#" MasterPageFile="~/Student page/Student.Master" AutoEventWireup="true" CodeBehind="Announcement.aspx.cs" Inherits="School_Management.Student_Page.Announcement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
	<div class="container py-4">
		<div class="row mb-4">
			<div class="col-12 text-center">
				<h2 class="fw-bold text-primary">📢 Announcements</h2>
				<p class="lead">Stay up to date with the latest news and updates from your school.</p>
			</div>
		</div>
		<asp:Repeater ID="rptAnnouncements" runat="server">
			<HeaderTemplate>
				<div class="row g-4">
			</HeaderTemplate>
			<ItemTemplate>
				<div class="col-md-6 col-lg-4">
					<div class="card shadow h-100 border-primary">
						<div class="card-body">
							<h5 class="card-title text-primary"><%# Eval("Title") %></h5>
							<p class="card-text text-muted small mb-2"><i class="bi bi-calendar-event"></i> <%# Eval("AnnouncementDate", "{0:MMMM dd, yyyy}") %></p>
							<p class="card-text"><%# Eval("Message") %></p>
						</div>
					</div>
				</div>
			</ItemTemplate>
			<FooterTemplate>
				</div>
			</FooterTemplate>
		</asp:Repeater>
		<div class="row mt-5">
			<div class="col-12 text-center">
				<p class="text-muted">For more information, contact your class teacher or <a href="Support.aspx">school support</a>.</p>
			</div>
		</div>
	</div>
</asp:Content>
