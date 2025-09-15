<%@ Page Title="" EnableEventValidation="false" Language="C#" MasterPageFile="~/Admin page/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageCourses.aspx.cs" Inherits="School_Management.ManageCourses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>

        .manage-container {
    padding: 20px;
    font-family: 'Segoe UI', sans-serif;
    background: #f4f7fb;
}

.page-header h2 {
    color: #1d3557;
    font-weight: 600;
    margin-bottom: 15px;
}

.card {
    background: #fff;
    border-radius: 8px;
    box-shadow: 0px 3px 8px rgba(0,0,0,0.05);
    margin-bottom: 20px;
}

.card-header {
    padding: 12px 15px;
    font-size: 18px;
    font-weight: 500;
    background: #457b9d;
    color: white;
    border-top-left-radius: 8px;
    border-top-right-radius: 8px;
}

.card-body {
    padding: 15px;
}

.form-row {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
}

.form-group {
    flex: 1;
    display: flex;
    flex-direction: column;
}

.form-control {
    padding: 8px 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    outline: none;
    transition: 0.2s;
}

.form-control:focus {
    border-color: #457b9d;
    box-shadow: 0px 0px 5px rgba(69,123,157,0.4);
}

.btn-primary {
    margin-top: 20px;
    padding: 8px 15px;
    background: #1d3557;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: 0.2s;
}
input[type="datetime-local"] {
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 14px;
    width: 100%;
    box-sizing: border-box;
}

.btn-primary:hover {
    background: #457b9d;
}

.success-message {
    color: green;
    font-weight: bold;
    margin-top: 10px;
    display: block;
}

/* GridView custom style */
.custom-grid {
    width: 100%;
    border-collapse: collapse;
}

.custom-grid th, .custom-grid td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}

.custom-grid th {
    background: #1d3557;
    color: white;
}

.custom-grid tr:nth-child(even) {
    background: #f8f9fa;
}

.custom-grid tr:hover {
    background: #e8f0fe;
    transition: 0.2s;
}

.manage-container {
    padding: 24px 0 0 0;
    font-family: 'Segoe UI', sans-serif;
    background: #f4f7fb;
}
.page-header h2 {
    color: #3a86ff;
    font-weight: 700;
    margin-bottom: 22px;
    letter-spacing: 1px;
    display: flex;
    align-items: center;
    gap: 12px;
}
.page-header h2 i {
    color: #4361ee;
}
.card {
    background: #fff;
    border-radius: 16px;
    box-shadow: 0 2px 12px rgba(60,60,120,0.10);
    margin-bottom: 28px;
    border: none;
}
.card-header {
    font-weight: 700;
    font-size: 1.15rem;
    background: linear-gradient(90deg, #3a86ff 0%, #4361ee 100%);
    color: #fff;
    border-radius: 16px 16px 0 0;
    padding: 16px 20px;
    letter-spacing: 0.5px;
    display: flex;
    align-items: center;
    gap: 10px;
}
.card-body {
    background: #fff;
    border-radius: 0 0 16px 16px;
    padding: 24px 20px 16px 20px;
}
.form-control {
    border-radius: 8px;
    font-size: 1rem;
}
.btn, .btn-success, .btn-primary, .btn-danger, .btn-secondary {
    border-radius: 8px !important;
    font-weight: 600;
    font-size: 1rem;
    box-shadow: 0 2px 8px rgba(60,60,120,0.07);
}
.btn-success {
    background: #3a86ff;
    border: none;
}
.btn-success:hover {
    background: #4361ee;
}
.btn-danger {
    background: #fb5607;
    border: none;
}
.btn-danger:hover {
    background: #ff006e;
}
.btn-primary {
    background: #3a86ff;
    border: none;
}
.btn-primary:hover {
    background: #4361ee;
}
.table {
    border-radius: 12px;
    overflow: hidden;
    background: #fff;
}
.table th {
    background: #f4f6f8;
    color: #3a86ff;
    font-weight: 700;
}
.table td {
    vertical-align: middle;
}
.table-striped > tbody > tr:nth-of-type(odd) {
    background-color: #f8f9fa;
}
.table-striped > tbody > tr:nth-of-type(even) {
    background-color: #fff;
}
@media (max-width: 900px) {
    .manage-container {
        padding: 0 4px;
    }
    .card-body {
        padding: 12px 6px 8px 6px;
    }
}
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <div class="manage-container">

        <!-- Title -->
        <div class="page-header">
            <h2><i class="fa-solid fa-book-open"></i> Manage Courses</h2>
        </div>

        <!-- Add Course Section -->
        <div class="card shadow-lg border-0 rounded-3">
    <!-- Card Header -->
    <div class="card-header text-white d-flex align-items-center">
        <i class="fa-solid fa-plus-circle me-2"></i>
        <span>Add New Course</span>
    </div>

    <!-- Card Body -->
    <div class="card-body">
        <div class="row g-3">
            <!-- Instructor -->
            <div class="col-md-6">
                <div class="form-group">
                    <asp:Label ID="lblInstructor" runat="server" Text="Assign Instructor:" CssClass="form-label fw-bold" />
                    <asp:DropDownList ID="ddlInstructors" runat="server" CssClass="form-control" ValidateRequestMode="Enabled" ></asp:DropDownList>
                </div>
            </div>

            <!-- Course Title -->
            <div class="col-md-6">
                <div class="form-group">
                    <asp:Label ID="lblCourseTitle" runat="server" Text="Course Title:" CssClass="form-label fw-bold" />
                    <asp:TextBox ID="txtCourseTitle" runat="server" CssClass="form-control" ValidateRequestMode="Enabled" ></asp:TextBox>
                </div>
            </div>

            <!-- Start Date -->
            <div class="col-md-6">
                <div class="form-group">
                    <asp:Label ID="lblStartDate" runat="server" Text="Start Date:" CssClass="form-label fw-bold" />
                    <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" TextMode="Date" ValidateRequestMode="Enabled" ></asp:TextBox>
                </div>
            </div>

            <!-- End Date -->
            <div class="col-md-6">
                <div class="form-group">
                    <asp:Label ID="lblEndDate" runat="server" Text="End Date:" CssClass="form-label fw-bold" />
                    <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" TextMode="Date" ValidateRequestMode="Enabled" ></asp:TextBox>
                </div>
            </div>

            <!-- Description -->
            <div class="col-12">
                <div class="form-group">
                    <asp:Label ID="lblDescription" runat="server" Text="Description:" CssClass="form-label fw-bold" />
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                </div>
            </div>

            <!-- Submit Button -->
            <div class="col-12 d-flex align-items-center gap-3">
                <asp:Button ID="btnAddCourse" runat="server" Text="Add Course" CssClass="btn btn-success px-4" OnClick="btnAddCourse_Click" />
                <asp:Label ID="lblMessage" runat="server" CssClass="fw-bold text-success"></asp:Label>
            </div>
        </div>
    </div>
</div>


            


        <!-- Course List -->
        <div class="card mt-20">
            <div class="card-header">
                <i class="fa-solid fa-list"></i> Course List
            </div>
            <div class="card-body">
                <asp:GridView ID="gvCourses" runat="server" AutoGenerateColumns="False"
                                                        CssClass="table table-striped"
                                                        DataKeyNames="CourseID"
                                                        OnRowCommand="gvCourses_RowCommand"
                                                        OnRowEditing="gvCourses_RowEditing"
                                                        OnRowUpdating="gvCourses_RowUpdating"
                                                        OnRowCancelingEdit="gvCourses_RowCancelingEdit">


            <Columns>
                <asp:BoundField DataField="CourseID" HeaderText="<i class='fa-solid fa-id-badge'></i> ID" ReadOnly="True" />
                <asp:BoundField DataField="CourseName" HeaderText="Title" ValidateRequestMode="Enabled"/>
                <asp:BoundField DataField="Description" HeaderText="Description" />
                <asp:BoundField DataField="StartDate" HeaderText="Start Date" DataFormatString="{0:yyyy-MM-dd}" ValidateRequestMode="Enabled"/>
                <asp:BoundField DataField="EndDate" HeaderText="End Date" DataFormatString="{0:yyyy-MM-dd}" ValidateRequestMode="Enabled"/>
                <asp:BoundField DataField="InstructorName" HeaderText="Instructor" ReadOnly="True" ValidateRequestMode="Enabled"/>

               <asp:TemplateField HeaderText="Actions">
    <ItemTemplate>
        <asp:LinkButton ID="btnEdit" runat="server" 
            Text="<i class='fa-solid fa-pen-to-square'></i>" CssClass="btn btn-sm btn-primary"
            OnClientClick='<%# "openUpdateModal(" + Eval("CourseID") + "); return false;" %>' />
        <hr />
        <asp:LinkButton ID="btnDelete" runat="server" 
            Text="<i class='fa-solid fa-trash'></i>" CssClass="btn btn-sm btn-danger"
            OnClientClick='<%# "openDeleteModal(" + Eval("CourseID") + "); return false;" %>' />
    </ItemTemplate>
</asp:TemplateField>




    </Columns>
</asp:GridView>

            </div>
        </div>
        </div>




    

<!-- Delete Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      
      <!-- Modal Header -->
      <div class="modal-header bg-danger text-white">
        <h5 class="modal-title"><i class="fa-solid fa-triangle-exclamation me-2"></i>Confirm Delete</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
    </div>

      <!-- Modal Body -->
      <div class="modal-body">
        <p>Are you sure you want to delete this record?</p>
        <!-- Optional: hidden field to hold record ID -->
        <asp:HiddenField ID="hdnDeleteId" runat="server" />
      </div>

      <!-- Modal Footer -->
      <div class="modal-footer">
        <asp:Button ID="btnConfirmDelete" runat="server" Text="Yes, Delete"
    CssClass="btn btn-danger" OnClick="btnConfirmDelete_Click" />
        <button type="button" class="btn btn-secondary fa-solid fa-xmark" data-bs-dismiss="modal">Cancel</button>
      </div>
    </div>
  </div>
</div>

<!-- Script -->
<script>
function openDeleteModal(id) {
  // if you want to pass an ID from GridView row
  if (id) {
    document.getElementById('<%= hdnDeleteId.ClientID %>').value = id;
  }
  var modal = new bootstrap.Modal(document.getElementById('deleteModal'));
  modal.show();
}
</script>


    <!-- Update Modal -->
<div class="modal fade" id="updateModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <!-- Modal Header -->
        <div class="modal-header bg-primary text-white">
            <h5 class="modal-title"><i class="fa-solid fa-pen-to-square me-2"></i>Update Course</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
        </div>

      <!-- Modal Body -->
      <div class="modal-body">
        <asp:HiddenField ID="hdnUpdateId" runat="server" />

        <div class="row mb-3">
          <div class="col-md-6">
            <label>Title</label>
            <asp:TextBox runat="server" ID="UpdateTitle" CssClass="form-control" />
          </div>
          <div class="col-md-6">
            <label>Assign Instructor</label>
            <asp:DropDownList ID="UpdateddlInstructors" runat="server" CssClass="form-control" />
          </div>
        </div>

        <div class="row mb-3">
          <div class="col-md-6">
            <asp:Label Text="Start Date:" runat="server" />
            <asp:TextBox ID="UpdateStartDate" runat="server" CssClass="form-control" TextMode="Date" />
          </div>
          <div class="col-md-6">
            <asp:Label Text="End Date:" runat="server" />
            <asp:TextBox ID="UpdateEndDate" runat="server" CssClass="form-control" TextMode="Date" />
          </div>
        </div>

        <div class="mb-3">
          <asp:Label Text="Description:" runat="server" />
          <asp:TextBox ID="UpdateDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
        </div>
      </div>

      <!-- Modal Footer -->
      <div class="modal-footer">
        <asp:Button ID="BtnUpdate" runat="server" Text="Update" CssClass="btn btn-success" OnClick="BtnUpdate_Click" />
        <button type="button" class="btn btn-secondary fa-solid fa-xmark" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

    <asp:Button ID="btnLoadCourse" runat="server" Style="display:none;" OnClick="btnLoadCourse_Click" />


    <script>
function openUpdateModal(id) {
    // set hidden field value
    document.getElementById('<%= hdnUpdateId.ClientID %>').value = id;

    // Call server-side method via __doPostBack to load course data
    __doPostBack('<%= btnLoadCourse.UniqueID %>', id);
}
</script>


</asp:Content>
