<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher page/Teacher.Master" AutoEventWireup="true" CodeBehind="PreviewQuiz.aspx.cs" Inherits="School_Management.Teacher_page.PreviewQuiz" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    < id="form1" runat="server" class="container mt-5">
        <h2 class="text-center mb-4">📖 Preview Quiz</h2>

        <!-- Quiz Title -->
        <asp:Label ID="lblQuizTitle" runat="server" CssClass="h4 text-primary d-block mb-3"></asp:Label>

        <!-- Quiz Description -->
        <asp:Label ID="lblDescription" runat="server" CssClass="text-muted d-block mb-4"></asp:Label>

        <!-- Quiz Questions -->
        <asp:Repeater ID="rptQuestions" runat="server">
            <ItemTemplate>
                <div class="card mb-3 shadow-sm">
                    <div class="card-body">
                        <p class="fw-bold">Q<%# Container.ItemIndex + 1 %>: <%# Eval("QuestionText") %></p>
                        <ul>
                            <li>A) <%# Eval("OptionA") %></li>
                            <li>B) <%# Eval("OptionB") %></li>
                            <li>C) <%# Eval("OptionC") %></li>
                            <li>D) <%# Eval("OptionD") %></li>
                        </ul>
                        <p class="text-success"><strong>Correct Answer:</strong> <%# Eval("CorrectAnswer") %></p>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <!-- Action Buttons -->
        <div class="mt-4">
            <asp:Button ID="btnBack" runat="server" Text="⬅ Back to Manage Quiz" CssClass="btn btn-secondary" PostBackUrl="~/Teacher Page/ManageQuizQuestions.aspx" />
            <asp:Button ID="btnPublish" runat="server" Text="🚀 Publish Quiz" CssClass="btn btn-success" OnClick="btnPublish_Click" />
        </div>

        <!-- Message Label -->
        <asp:Label ID="lblMessage" runat="server" CssClass="d-block mt-3 fw-bold"></asp:Label>
    </>

    

</asp:Content>
