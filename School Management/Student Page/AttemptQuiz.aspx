<%@ Page Title="" Language="C#" MasterPageFile="~/Student page/Student.Master" AutoEventWireup="true" CodeBehind="AttemptQuiz.aspx.cs" Inherits="School_Management.Student_Page.AttemptQuiz" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <div class="container mt-4">
        <h2 class="text-center text-primary">📝 Attempt Quiz</h2>
        <asp:Label ID="lblQuizTitle" runat="server" CssClass="h4 text-dark"></asp:Label>
        <hr />

        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

        <asp:Repeater ID="rptQuestions" runat="server" OnItemDataBound="rptQuestions_ItemDataBound">
    <ItemTemplate>
        <div class="question">
            <h4>Q<%# Container.ItemIndex + 1 %>: <%# Eval("QuestionText") %></h4>
            <asp:RadioButtonList ID="rblOptions" runat="server" RepeatDirection="Vertical"></asp:RadioButtonList>
            <asp:HiddenField ID="hfQuestionId" runat="server" Value='<%# Eval("QuestionID") %>' />
        </div>
    </ItemTemplate>
</asp:Repeater>


        <asp:Button ID="btnSubmitQuiz" runat="server" Text="✅ Submit Quiz" CssClass="btn btn-success"
            OnClick="btnSubmitQuiz_Click" />
    </div>
</asp:Content>
