<%@ Page Title="" Language="C#" MasterPageFile="~/Student Page/Student.Master" AutoEventWireup="true" CodeBehind="StudentsGradeBook.aspx.cs" Inherits="School_Management.Student_Page.CourseDetails" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div id="form2" runat="server">
        <div class="container mt-5">
            <h2 class="text-center mb-4">📚 My Gradebook</h2>

            <!-- Message Label -->
            <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-info d-block text-center" Visible="false"></asp:Label>

            <!-- Gradebook Table -->
            <asp:GridView ID="gvGradebook" runat="server" CssClass="table table-bordered table-hover text-center"
                AutoGenerateColumns="false" EmptyDataText="No grades available yet.">
                <Columns>
                    <asp:BoundField DataField="CourseName" HeaderText="📘 Course" />
                    <asp:BoundField DataField="QuizTitle" HeaderText="📝 Quiz / Assignment" />
                    <asp:BoundField DataField="Score" HeaderText="✅ Score" />
                    <asp:BoundField DataField="TotalMarks" HeaderText="📊 Total Marks" />
                    <asp:BoundField DataField="Percentage" HeaderText="📈 Percentage (%)" />
                    
                </Columns>
            </asp:GridView>
        </div>
    </div>

</asp:Content>
