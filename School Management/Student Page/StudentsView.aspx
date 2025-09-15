<%@ Page Title="" Language="C#" MasterPageFile="~/Student Page/Student.Master" AutoEventWireup="true" CodeBehind="StudentsView.aspx.cs" Inherits="School_Management.Student_Page.StudentsView" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

 <Columns>
        <!-- Course Title -->
        <asp:BoundField DataField="CourseTitle" HeaderText="📘 Course" />

        <!-- Nested Quizzes -->
        <asp:TemplateField HeaderText="📝 Quizzes">
            <ItemTemplate>
                <asp:GridView ID="gvQuizzes" runat="server" AutoGenerateColumns="False"
                    CssClass="table table-sm table-striped mt-2">
                    <Columns>
                        <asp:BoundField DataField="QuizTitle" HeaderText="Quiz Title" />
                        <asp:BoundField DataField="TotalMarks" HeaderText="Marks" />
                        <asp:BoundField DataField="StartDate" HeaderText="Start" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="EndDate" HeaderText="End" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnAttempt" runat="server" 
                                    Text="Attempt Quiz" 
                                    CssClass="btn btn-warning btn-sm" 
                                    CommandName="AttemptQuiz"
                                    CommandArgument='<%# Eval("QuizID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>

</asp:Content>
