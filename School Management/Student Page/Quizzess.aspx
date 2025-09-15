<%@ Page Title="" Language="C#" MasterPageFile="~/Student Page/Student.Master" AutoEventWireup="true" CodeBehind="Quizzess.aspx.cs" Inherits="School_Management.Student_Page.StudentsQuizzessAndAssignment" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        body { background-color: #f8f9fa; }
        .dashboard-container { max-width: 1100px; margin: 30px auto; }
        h2 { margin-bottom: 20px; }
        .card { border-radius: 12px; }
        .btn-attempt { background: #28a745; color: white; }
        .btn-solve { background: #007bff; color: white; }
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <div id="form1" runat="server">
        <div class="container mt-5">
            <h2 class="text-center mb-4">📚 Available Quizzes & Assignments</h2>

            <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-info d-block text-center" Visible="false"></asp:Label>

            <!-- Quizzes Section -->
            <h4>📝 Quizzes</h4>
            <asp:GridView ID="gvQuizzes" runat="server" CssClass="table table-bordered table-hover text-center"
                AutoGenerateColumns="false" EmptyDataText="No quizzes available.">
                <Columns>
                    <asp:BoundField DataField="Title" HeaderText="Quiz Title" />
                    <asp:BoundField DataField="Description" HeaderText="Description" />
                     <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:HyperLink ID="lnkAttempt" runat="server" 
                                Text='<%# Convert.ToBoolean(Eval("HasAttempted")) ? "✅ Attempted" : "Attempt" %>' 
                                CssClass='<%# Convert.ToBoolean(Eval("HasAttempted")) ? "btn btn-primary btn-sm disabled" : "btn btn-danger btn-sm" %>'
                                Enabled='<%# !(Convert.ToBoolean(Eval("HasAttempted"))) %>'
                                NavigateUrl='<%# "~/Student Page/AttemptQuiz.aspx?QuizID=" + Eval("QuizID") %>'></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <hr />


           <%--  <Columns>
        <asp:BoundField DataField="QuizTitle" HeaderText="Quiz Title" />
        <asp:BoundField DataField="StartDate" HeaderText="Start Date" />
        <asp:BoundField DataField="EndDate" HeaderText="End Date" />
        <asp:TemplateField>
            <ItemTemplate>
                <asp:HyperLink ID="lnkAttempt" runat="server" 
                    NavigateUrl='<%# "~/Student Page/AttemptQuiz.aspx?QuizID=" + Eval("QuizID") %>' 
                    Text="Attempt"></asp:HyperLink>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>--%>

            <!-- Assignments Section -->
            <h4>📂 Assignments</h4>
            <asp:GridView ID="gvAssignments" runat="server" CssClass="table table-bordered table-hover text-center"
                AutoGenerateColumns="false" EmptyDataText="No assignments available.">
                <Columns>
                    <asp:BoundField DataField="Title" HeaderText="Assignment Title" />
                    <asp:BoundField DataField="Description" HeaderText="Description" />
                    <asp:BoundField DataField="DueDate" HeaderText="Due Date" DataFormatString="{0:dd-MM-yyyy}" />
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:HyperLink ID="lnkSubmit" runat="server" Text="Submit"
                                CssClass="btn btn-success btn-sm"
                                NavigateUrl='<%# "~/Student Page/SubmitAssignment.aspx?AssignmentID=" + Eval("AssignmentID") %>'></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>

</asp:Content>
