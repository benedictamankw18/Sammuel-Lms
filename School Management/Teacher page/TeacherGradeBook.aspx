<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher page/Teacher.Master" AutoEventWireup="true" CodeBehind="TeacherGradeBook.aspx.cs" Inherits="School_Management.TeacherGradeBook" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <meta charset="utf-8" />
    <title> Grade Book</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .gradebook-container {
            padding: 30px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.15);
        }
        .gradebook-header {
            font-size: 24px;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 20px;
        }
        .grid {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        .grid th {
            background: #34495e;
            color: white;
            padding: 10px;
            text-align: center;
        }
        .grid td {
            padding: 8px;
            border: 1px solid #ddd;
            text-align: center;
        }
        .btn {
            padding: 8px 16px;
            border-radius: 6px;
            margin: 5px;
            cursor: pointer;
            border: none;
        }
        .btn-save { background: #27ae60; color: white; }
        .btn-export { background: #2980b9; color: white; }
        .btn:hover { opacity: 0.9; }
    </style>


</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

   <div id="form1" runat="server">
        <div class="container py-4">
            
            <!-- Page Title -->
            <h2 class="mb-4 text-center">📘 Grade Book</h2>

            <!-- Filters Section -->
            <div class="row mb-4">
                <div class="col-md-3">
    <asp:DropDownList ID="ddlCourse" runat="server" 
        CssClass="form-select" 
        AppendDataBoundItems="true">
        <asp:ListItem Text="-- Select Course --" Value="" />
    </asp:DropDownList>
</div>

                <div class="col-md-4">
                    <asp:TextBox ID="txtSearchStudent" runat="server" CssClass="form-control" Placeholder="Search student..."></asp:TextBox>
                </div>
                <div class="col-md-2">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary w-100" OnClick="btnSearch_Click" />
                </div>
            </div>

                       <!-- Action Buttons -->
            <div class="mt-4 text-center">
                <asp:Button ID="btnExportExcel" runat="server" Text="Export to Excel" CssClass="btn btn-success me-2" OnClick="btnExportExcel_Click" />
                <asp:Button ID="btnExportPdf" runat="server" Text="Export to PDF" CssClass="btn btn-danger me-2" OnClick="btnExportPdf_Click" />
                <asp:Button ID="btnPrint" runat="server" Text="Print Report" CssClass="btn btn-secondary"/>
            </div>

            <asp:GridView ID="gvGradeBook" runat="server"
                    AutoGenerateColumns="False"
                    CssClass="table table-bordered table-striped"
                    AllowPaging="true" PageSize="10"
                    OnPageIndexChanging="gvGradeBook_PageIndexChanging"
                    HeaderStyle-BackColor="#343a40" HeaderStyle-ForeColor="White"
                    RowStyle-BackColor="White" AlternatingRowStyle-BackColor="#f8f9fa">

                    <Columns>
                        <asp:BoundField DataField="CourseName" HeaderText="Course" />
                        <asp:BoundField DataField="Title" HeaderText="Quiz" />
                        <asp:BoundField DataField="StudentName" HeaderText="Student" />
                        <asp:BoundField DataField="Score" HeaderText="Score" />
                        <asp:BoundField DataField="TotalMarks" HeaderText="Total Marks" />
                        <asp:BoundField DataField="DateTaken" HeaderText="Date Attempted" 
                                        DataFormatString="{0:dd-MMM-yyyy}" />
                    </Columns>
                </asp:GridView>

<asp:HiddenField ID="hfCourseNames" runat="server" />
<asp:HiddenField ID="hfStudentCounts" runat="server" />
            <!-- Grade Distribution Chart -->
            <div class="mt-5">
                <h5 class="text-center">📊 Your Course Distribution</h5>
                <canvas id="gradeChart" height="120"></canvas>
            </div>
        </div>
    </div>

     <!-- ChartJS Script--> 
    <script>
    // Get data from hidden fields
    var courseNames = '<%= hfCourseNames.Value %>'.split(',');
    var studentCounts = '<%= hfStudentCounts.Value %>'.split(',').map(Number);

    var ctx = document.getElementById('gradeChart').getContext('2d');
    var gradeChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: courseNames,
            datasets: [{
                label: 'Number of Students Enrolled',
                data: studentCounts,
                backgroundColor: '#17a2b8'
            }]
        }
    });
</script>

</asp:Content>
