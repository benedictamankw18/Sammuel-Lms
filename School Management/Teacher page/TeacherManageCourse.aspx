<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher page/Teacher.Master" AutoEventWireup="true" CodeBehind="TeacherManageCourse.aspx.cs" Inherits="School_Management.TeacherManageCourse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        /* === Page Layout === */
        .manage-course-container {
            max-width: 1100px;
            margin: 30px auto;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            padding: 25px 30px;
        }

        h2 {
            font-size: 22px;
            color: #333;
            font-weight: 600;
            margin-bottom: 20px;
            border-bottom: 2px solid #007bff;
            padding-bottom: 8px;
        }

        /* === Grid Styling === */
        .grid {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 25px;
        }

        .grid th {
            background: #007bff;
            color: #fff;
            text-align: left;
            padding: 12px;
            font-size: 14px;
        }

        .grid td {
            padding: 10px 12px;
            border-bottom: 1px solid #ddd;
            font-size: 13px;
            color: #555;
        }

        .grid tr:nth-child(even) {
            background: #f9f9f9;
        }

        /* === Upload Panel === */
        .upload-panel {
            background: #f8faff;
            border: 1px solid #cce5ff;
            border-radius: 10px;
            padding: 20px;
            margin-top: 20px;
        }

        .upload-panel label {
            font-weight: 500;
            color: #333;
            display: block;
            margin-bottom: 6px;
        }

        .upload-panel input[type="text"],
        .upload-panel input[type="file"],
        .upload-panel select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
        }

        /* === Buttons === */
        .btn {
            display: inline-block;
            padding: 10px 18px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.2s ease-in-out;
        }

        .btn-primary {
            background: #007bff;
            color: #fff;
        }
        .btn-primary:hover {
            background: #0056b3;
        }

        .btn-success {
            background: #28a745;
            color: #fff;
        }
        .btn-success:hover {
            background: #1e7e34;
        }

        .btn-danger {
            background: #dc3545;
            color: #fff;
        }
        .btn-danger:hover {
            background: #a71d2a;
        }

        /* === Quiz Section === */
        .quiz-section {
            margin-top: 30px;
        }
    </style>


           <style>
        .quiz-container {
            max-width: 950px;
            margin: 30px auto;
            padding: 25px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        h2 {
            margin-bottom: 20px;
            font-size: 22px;
            font-weight: 600;
            border-bottom: 2px solid #007bff;
            padding-bottom: 8px;
        }
        label {
            font-weight: 500;
            margin-top: 12px;
            display: block;
        }
        .form-control {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }
        .btn {
            margin-top: 15px;
            padding: 10px 20px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
        }
        .btn-primary { background: #007bff; color: #fff; }
        .btn-success { background: #28a745; color: #fff; }
        .btn-danger { background: #dc3545; color: #fff; }

        /* === Modal === */
        .modal {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.5);
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            width: 400px;
        }
    </style>





</asp:Content>

        <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <div class="container mt-4">
        <h2 class="mb-3">My Assigned Courses</h2>
        <asp:GridView ID="gvCourses" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-striped">
            <Columns>
                <asp:BoundField DataField="CourseID" HeaderText="Course ID" />
                <asp:BoundField DataField="CourseName" HeaderText="Course Name" />
                <asp:BoundField DataField="EnrollmentKey" HeaderText="Enrollment Key" />
            </Columns>
        </asp:GridView>
    </div>





    <div class="manage-course-container">
        <h2>📘 Manage My Courses</h2>


        <div style="display:flex; justify-content:flex-end; align-items:center; gap:12px; margin:20px;">

    <!-- TextBox -->
    <asp:TextBox ID="txtInput" runat="server"
        placeholder="Enter Enrollment Key..."
        Style="padding:8px; border:1px solid #ccc; border-radius:6px; width:200px;"/>

    <!-- DropDownList -->
    <asp:DropDownList ID="ddlOptions" runat="server"
        Style="padding:8px; border:1px solid #ccc; border-radius:6px; width:180px;">
        <asp:ListItem Text="-- Select Option --" Value="" />
        <%--<asp:ListItem Text="Option 1" Value="1" />
        <asp:ListItem Text="Option 2" Value="2" />
        <asp:ListItem Text="Option 3" Value="3" />--%>
    </asp:DropDownList>

    <!-- Button -->
    <asp:Button ID="btnSubmit" runat="server" Text="Submit"
        Style="padding:8px 16px; background:#2980b9; color:#fff; border:none; border-radius:6px; cursor:pointer;" Onclick="btnUpdate_Click" />
</div>



        <!-- Courses assigned to the instructor -->
        <asp:GridView ID="gvInstructorCourses" runat="server" AutoGenerateColumns="False" 
    DataKeyNames="CourseID" CssClass="grid">
    <Columns>
        <asp:BoundField DataField="CourseName" HeaderText="Course Title" />
        <asp:BoundField DataField="EnrollmentKey" HeaderText="Enrollment Key" ReadOnly="true" />
        <asp:BoundField DataField="Description" HeaderText="Description" />
        <asp:BoundField DataField="StartDate" HeaderText="Start Date" DataFormatString="{0:yyyy-MM-dd}" />
        <asp:BoundField DataField="EndDate" HeaderText="End Date" DataFormatString="{0:yyyy-MM-dd}" />
    </Columns>
</asp:GridView>

        <!-- Upload resources -->
        <div class="upload-panel">
            <h2>📂 Upload Course Resource</h2>
            <asp:DropDownList ID="cResorce" runat="server"
        Style="padding:8px; border:1px solid #ccc; ">
        <asp:ListItem Text="-- Select Course --" Value="" />
        <%--<asp:ListItem Text="Option 1" Value="1" />
        <asp:ListItem Text="Option 2" Value="2" />
        <asp:ListItem Text="Option 3" Value="3" />--%>
    </asp:DropDownList>

            <label for="txtResourceName">Resource Name</label>
            <asp:TextBox ID="txtResourceName" runat="server" CssClass="form-control"></asp:TextBox>

            <label for="ddlResourceType">Resource Type</label>
            
            <asp:DropDownList ID="ddlResourceType" runat="server" CssClass="form-control mt-2">
                <asp:ListItem Text="-- Select Type --" Value="" />
                <asp:ListItem Value="PDF">PDF</asp:ListItem>
                <asp:ListItem Value="Image">Image</asp:ListItem>
                <asp:ListItem Value="Video">Video</asp:ListItem>
            </asp:DropDownList>

            <label for="fuResource">Select File</label>
            <asp:FileUpload ID="FileUpload1" runat="server" />

            <asp:Button ID="Button1" runat="server" CssClass="btn btn-success" Text="Upload Resource" OnClick="Button1_Click"  />
           
           <!-- Add Quiz Section -->
    <div class="quiz-container">
        <h2>➕ Add New Quiz</h2>
        <asp:DropDownList ID="qResorce" runat="server"
        Style="padding:8px; border:1px solid #ccc; ">
        <asp:ListItem Text="-- Select Course --" Value="" />
        <%--<asp:ListItem Text="Option 1" Value="1" />
        <asp:ListItem Text="Option 2" Value="2" />
        <asp:ListItem Text="Option 3" Value="3" />--%>
    </asp:DropDownList>
        <label>Quiz Title</label>
        <asp:TextBox ID="txtQuizTitle" runat="server" CssClass="form-control" />

        <label>Quiz Type</label>
        <asp:DropDownList ID="ddlQuizType" runat="server" CssClass="form-control">
            <asp:ListItem Text="Graded" Value="Graded"></asp:ListItem>
            <asp:ListItem Text="Exam" Value="Exam"></asp:ListItem>
        </asp:DropDownList>

        <label>Start Date & Time</label>
        <asp:TextBox ID="txtStartDate" runat="server" TextMode="DateTimeLocal" CssClass="form-control" />

        <label>End Date & Time</label>
        <asp:TextBox ID="txtEndDate" runat="server" TextMode="DateTimeLocal" CssClass="form-control" />

        <asp:Button ID="btnSaveQuiz" runat="server" Text="Save Quiz" CssClass="btn btn-success" OnClick="btnSaveQuiz_Click" />
        <asp:Button ID="btnBack" runat="server" Text="⬅ Back to Manage Course" CssClass="btn btn-primary" PostBackUrl="~/Teacher page/TeacherManageCourse.aspx" />
    </div>

            <!-- Quiz section --> 
            <div class="quiz-section"> 
                <h2>📝 Manage Quizzes</h2> 
                <asp:Button ID="btnAddQuiz" runat="server" CssClass="btn btn-primary" Text="Add New Quiz"/> 
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CssClass="grid"> 
                    <Columns>
                        <asp:BoundField DataField="QuizID" HeaderText="Quiz ID" /> 
                        <asp:BoundField DataField="Title" HeaderText="Title" />
                        <asp:BoundField DataField="QuizType" HeaderText="Type" />
                        <asp:BoundField DataField="CreatedAt" HeaderText="Created At" DataFormatString="{0:yyyy-MM-dd}" />

                    </Columns>

                </asp:GridView>

            </div> 

        </div>



    <!-- Student Attempts -->
    <div class="quiz-container" style="margin-top:30px;">
        <div class="form-group">
    <label for="ddlQuizzes">📚 Select Quiz:</label>
    <asp:DropDownList ID="ddlQuizzes" runat="server" CssClass="form-control" AutoPostBack="true" 
        OnSelectedIndexChanged="ddlQuizzes_SelectedIndexChanged">
    </asp:DropDownList>
            </div>

        <h2>👨‍🎓 Students Who Attempted This Quiz</h2>
        <asp:GridView ID="gvStudentAttempts" runat="server" AutoGenerateColumns="False"
    CssClass="table table-striped table-bordered align-middle text-center">
    <Columns>
        <asp:BoundField DataField="StudentID" HeaderText="Student ID" />
        <asp:BoundField DataField="FullName" HeaderText="Student Name" />
        <asp:BoundField DataField="Score" HeaderText="Score" />
        <asp:BoundField DataField="DateTaken" HeaderText="Attempt Date" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
    </Columns>
</asp:GridView>
    </div>

    <!-- Bootstrap Modal for Success -->
<div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header bg-success text-white">
        <h5 class="modal-title" id="successModalLabel">Quiz Uploaded Successfully!</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body text-center">
        <i class="bi bi-check-circle-fill" style="font-size:2rem;color:#28a745;"></i>
        <p class="mt-3">✅ Quiz Uploaded Successfully!</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

    <script>
        function showModal() {
            document.getElementById("successModal").style.display = "flex";
        }
        function hideModal() {
            document.getElementById("successModal").style.display = "none";
        }
    </script>


</asp:Content>
