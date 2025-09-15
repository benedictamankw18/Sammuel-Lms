using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Configuration;

namespace School_Management
{
    public partial class TeacherGradeBook : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] == null)
                {
                    Response.Redirect("~/web1.aspx"); // redirect if not logged in
                    return;
                }
                LoadGradeBook();
                LoadCourses();
                LoadCourseEnrollmentDistribution();
            }
        }
        private void LoadGradeBook(string search = "")
        {
            int instructorId = Convert.ToInt32(Session["UserId"].ToString());

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT c.CourseName, q.Title, u.FullName AS StudentName, 
                   qa.Score, q.TotalMarks, qa.DateTaken
            FROM Results qa
            inner JOIN Quizzes q ON qa.QuizID = q.QuizID
            inner JOIN Courses c ON q.CourseID = c.CourseID
            inner JOIN Users u ON qa.StudentID = u.UserID
			WHERE c.InstructorID = @InstructorID";

                if (!string.IsNullOrEmpty(search))
                {
                    query += " AND (u.FullName LIKE @Search OR q.Title LIKE @Search)";
                }

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@InstructorID", instructorId);

                    if (!string.IsNullOrEmpty(search))
                    {
                        cmd.Parameters.AddWithValue("@Search", "%" + search + "%");
                    }
                    conn.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvGradeBook.DataSource = dt;
                        gvGradeBook.DataBind();
                    }
                }
            }
        }

        private void LoadCourses()
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            int instructorId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT CourseID, CourseName FROM Courses WHERE InstructorID = @InstructorID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@InstructorID", instructorId);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        ddlCourse.DataSource = dt;
                        ddlCourse.DataTextField = "CourseName";   // what user sees
                        ddlCourse.DataValueField = "CourseID";   // actual value
                        ddlCourse.DataBind();
                    }
                }
            }
        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadGradeBook(txtSearchStudent.Text.Trim());
        }

        protected void gvGradeBook_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvGradeBook.PageIndex = e.NewPageIndex;
            LoadGradeBook(); // reload your data
        }



        protected void btnExportPdf_Click(object sender, EventArgs e)
        {
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=GradeBook.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            // 🔹 Make sure GridView has data before export
            gvGradeBook.AllowPaging = false;
            LoadGradeBook("");  // <-- Reload your GradeBook data from DB here
            gvGradeBook.DataBind();

            if (gvGradeBook.Rows.Count == 0)
            {
                Response.Write("No data available to export.");
                Response.End();
                return;
            }

            Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 20f, 20f);
            PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            pdfDoc.Open();

            PdfPTable pdfTable = new PdfPTable(gvGradeBook.Columns.Count);
            pdfTable.WidthPercentage = 100;

            // 🔹 Add header row safely
            if (gvGradeBook.HeaderRow != null)
            {
                foreach (TableCell headerCell in gvGradeBook.HeaderRow.Cells)
                {
                    Font font = FontFactory.GetFont("Arial", 10, Font.BOLD);
                    PdfPCell cell = new PdfPCell(new Phrase(headerCell.Text, font));
                    cell.BackgroundColor = new BaseColor(240, 240, 240);
                    pdfTable.AddCell(cell);
                }
            }

            // 🔹 Add rows
            foreach (GridViewRow row in gvGradeBook.Rows)
            {
                foreach (TableCell cell in row.Cells)
                {
                    Font font = FontFactory.GetFont("Arial", 10, Font.NORMAL);
                    pdfTable.AddCell(new Phrase(cell.Text, font));
                }
            }

            pdfDoc.Add(pdfTable);
            pdfDoc.Close();

            Response.Write(pdfDoc);
            Response.End();
        }

        protected void btnExportExcel_Click(object sender, EventArgs e)
        {
            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment; filename=GradeBook.xls");
            Response.ContentType = "application/vnd.ms-excel";
            Response.Charset = "";

            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            gvGradeBook.AllowPaging = false; // export all rows
            LoadGradeBook(""); // reload grid before export

            gvGradeBook.RenderControl(htw);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }

        // Required override for GridView export
        public override void VerifyRenderingInServerForm(Control control)
        {
            // Confirms GridView is rendered before exporting
        }

private void LoadCourseEnrollmentDistribution()
{
    int instructorId = Convert.ToInt32(Session["UserId"]);
    string query = @"
        SELECT c.CourseName, COUNT(e.StudentCourseID) AS StudentCount
        FROM Courses c
        LEFT JOIN StudentCourses e ON c.CourseID = e.CourseID
        WHERE c.InstructorID = @InstructorID
        GROUP BY c.CourseName
        ORDER BY c.CourseName";

    List<string> courseNames = new List<string>();
    List<int> studentCounts = new List<int>();

    using (SqlConnection con = new SqlConnection(connectionString))
    using (SqlCommand cmd = new SqlCommand(query, con))
    {
        cmd.Parameters.AddWithValue("@InstructorID", instructorId);
        con.Open();
        using (SqlDataReader reader = cmd.ExecuteReader())
        {
            while (reader.Read())
            {
                courseNames.Add(reader["CourseName"].ToString());
                studentCounts.Add(Convert.ToInt32(reader["StudentCount"]));
            }
        }
    }

    // Store as comma-separated values in HiddenFields for JS
    hfCourseNames.Value = string.Join(",", courseNames.Select(n => n.Replace(",", " "))); // Remove commas from names
    hfStudentCounts.Value = string.Join(",", studentCounts);
}
    }
}