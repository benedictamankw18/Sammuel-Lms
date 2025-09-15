<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher page/Teacher.Master" AutoEventWireup="true" CodeBehind="ManageQuizQuestions.aspx.cs" Inherits="School_Management.Teacher_page.ManageQuizQuestions" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title>Manage Quiz Questions</title>
    <!-- Add this just before your closing </body> or </form> tag -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        .quiz-container {
            max-width: 900px;
            margin: 30px auto;
            background: #f9f9f9;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0px 4px 12px rgba(0,0,0,0.1);
        }
        .page-title {
            text-align: center;
            margin-bottom: 25px;
            color: #2c3e50;
        }
        .card {
            background: #fff;
            padding: 20px;
            margin-bottom: 25px;
            border-radius: 10px;
            box-shadow: 0px 2px 6px rgba(0,0,0,0.05);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .action-buttons {
            display: flex;
            justify-content: space-between;
        }
        .table {
            width: 100%;
        }
        .table-header {
            background-color: #3498db;
            color: white;
            text-align: center;
        }
        .table-row {
            text-align: center;
        }
    </style>



</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

  <%--  <div class="form-group">
    <label for="txtQuizTitle">Quiz Title</label>
    <asp:TextBox ID="txtQuizTitle" runat="server" CssClass="form-control"></asp:TextBox>
</div>

    <div class="form-group">
    <label for="txtDescription">Description</label>
    <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>
</div>
--%>


   <h2 class="page-title">📘 Manage Quiz Questions</h2>

        <!-- Add Question Form -->
        <div class="card add-question">
            <h4>Add New Question</h4>

            <div class="form-group">
                <label for="txtQuestion">Question</label>
                <asp:TextBox ID="txtQuestion" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3">
                </asp:TextBox>
            </div>


            <div class="form-group">
    <label for="ddlQuizzes">📚 Select Quiz:</label>
    <asp:DropDownList ID="ddlQuizzes" runat="server" CssClass="form-control" AutoPostBack="true" 
        OnSelectedIndexChanged="ddlQuizzes_SelectedIndexChanged">
    </asp:DropDownList>

    <%--            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
    <Columns>
        <asp:BoundField DataField="QuestionID" HeaderText="ID" />
        <asp:BoundField DataField="QuestionText" HeaderText="Question" />
        <asp:BoundField DataField="OptionA" HeaderText="Option A" />
        <asp:BoundField DataField="OptionB" HeaderText="Option B" />
        <asp:BoundField DataField="OptionC" HeaderText="Option C" />
        <asp:BoundField DataField="OptionD" HeaderText="Option D" />
        <asp:BoundField DataField="CorrectAnswer" HeaderText="Answer" />
    </Columns>
</asp:GridView>--%>

</div>

            <div class="form-group">
                <label for="txtOptionA">Option A</label>
                <asp:TextBox ID="txtOptionA" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtOptionB">Option B</label>
                <asp:TextBox ID="txtOptionB" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtOptionC">Option C</label>
                <asp:TextBox ID="txtOptionC" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtOptionD">Option D</label>
                <asp:TextBox ID="txtOptionD" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="ddlCorrectAnswer">Correct Answer</label>
                <asp:DropDownList ID="ddlCorrectAnswer" runat="server" CssClass="form-control">
                    <asp:ListItem>A</asp:ListItem>
                    <asp:ListItem>B</asp:ListItem>
                    <asp:ListItem>C</asp:ListItem>
                    <asp:ListItem>D</asp:ListItem>
                </asp:DropDownList>
            </div>

            <asp:Button ID="btnAddQuestion" runat="server" Text="➕ Add Question" CssClass="btn btn-primary btn-block" OnClick="btnAddQuestion_Click" />
        </div>

        <!-- Questions Grid -->
        <div class="card questions-list">
            <h4>📋 Questions List</h4>

            <asp:GridView ID="gvQuestions" runat="server" AutoGenerateColumns="false"
    OnRowCommand="gvQuestions_RowCommand"
    DataKeyNames="QuestionID" CssClass="table table-bordered">

    <Columns>
        <asp:TemplateField HeaderText="Question">
            <ItemTemplate>
                <asp:Label ID="lblQuestionText" runat="server" Text='<%# Eval("QuestionText") %>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Option A">
            <ItemTemplate>
                <asp:Label ID="lblOptionA" runat="server" Text='<%# Eval("OptionA") %>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Option B">
            <ItemTemplate>
                <asp:Label ID="lblOptionB" runat="server" Text='<%# Eval("OptionB") %>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Option C">
            <ItemTemplate>
                <asp:Label ID="lblOptionC" runat="server" Text='<%# Eval("OptionC") %>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Option D">
            <ItemTemplate>
                <asp:Label ID="lblOptionD" runat="server" Text='<%# Eval("OptionD") %>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Answer">
            <ItemTemplate>
                <asp:Label ID="lblCorrectAnswer" runat="server" Text='<%# Eval("CorrectOption") %>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
                <asp:LinkButton ID="btnEdit" runat="server"
    Text="Edit"
    CommandName="EditRow"
    CommandArgument='<%# Eval("QuestionID") %>'
    CssClass="btn btn-sm btn-primary" />
                <asp:LinkButton ID="btnDelete" runat="server"
                    Text="Delete"
                    OnClientClick='<%# "openDeleteModal(" + Eval("QuestionID") + "); return false;" %>'
                    CssClass="btn btn-sm btn-danger" />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>


    </div>

    

        <!-- Action Buttons -->
        <div class="action-buttons">
            <%--<asp:Button ID="btnSaveQuiz" runat="server" Text="💾 Save Quiz" CssClass="btn btn-success" OnClick="btnSaveQuiz_Click" />--%>
            <asp:Button ID="btnPublishQuiz" runat="server" Text="🚀 Publish Quiz" CssClass="btn btn-warning" OnClick="btnPublishQuiz_Click" />
        </div>

    <div class="form-group">
    <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-info" Visible="false"></asp:Label>
</div>

<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content shadow-lg rounded-3">
      <div class="modal-header bg-danger text-white">
        <h5 class="modal-title" id="deleteModalLabel">
          <i class="bi bi-exclamation-triangle"></i> Confirm Delete
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <asp:HiddenField ID="hfDeleteQuestionID" runat="server" />
        <p>Are you sure you want to delete this question?</p>
      </div>
      <div class="modal-footer">
        <asp:Button ID="btnConfirmDelete" runat="server" CssClass="btn btn-danger" Text="Delete" OnClick="btnConfirmDelete_Click" />
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
      </div>
    </div>
  </div>
</div>

   <!-- Edit Question Modal -->
<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content shadow-lg rounded-3">
            
            <!-- Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="editModalLabel">
                    <i class="bi bi-pencil-square"></i> Edit Question
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Body -->
            <div class="modal-body">
                <asp:HiddenField ID="hfQuestionID" runat="server" />

                <div class="mb-3">
                    <label class="form-label fw-bold">Question</label>
                    <asp:TextBox ID="txtUpdateQuestion" runat="server" CssClass="form-control" />
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Option A</label>
                        <asp:TextBox ID="txtUpdateOptionA" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Option B</label>
                        <asp:TextBox ID="txtUpdateOptionB" runat="server" CssClass="form-control" />
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Option C</label>
                        <asp:TextBox ID="txtUpdateOptionC" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Option D</label>
                        <asp:TextBox ID="txtUpdateOptionD" runat="server" CssClass="form-control" />
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Correct Answer</label>
                <asp:DropDownList ID="ddlUpdateCorrectAnswer" runat="server" CssClass="form-control">
                    <asp:ListItem>A</asp:ListItem>
                    <asp:ListItem>B</asp:ListItem>
                    <asp:ListItem>C</asp:ListItem>
                    <asp:ListItem>D</asp:ListItem>
                </asp:DropDownList>

                </div>
            </div>

            <!-- Footer -->
            <div class="modal-footer">
                <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="btn btn-success" OnClick="btnUpdate_Click" />
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>
<asp:ScriptManager runat="server" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function openDeleteModal(questionId) {
        document.getElementById('<%= hfDeleteQuestionID.ClientID %>').value = questionId;
        var myModal = new bootstrap.Modal(document.getElementById('deleteModal'));
        myModal.show();
    }

    function openUpdateModal(questionId) {
    document.getElementById('<%= hfQuestionID.ClientID %>').value = questionId;
    var myModal = new bootstrap.Modal(document.getElementById('editModal'));
    myModal.show();
}
</script>
</asp:Content>
