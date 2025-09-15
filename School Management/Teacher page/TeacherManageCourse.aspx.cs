using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

namespace School_Management
{
    public partial class TeacherManageCourse : System.Web.UI.Page
    {


        

        private void LoadCourses()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;

            int instructorId = Convert.ToInt32(Session["InstructorId"]); // Ensure session exists
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT CourseID, CourseName, EnrollmentKey FROM Courses WHERE InstructorId=@InstructorId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@InstructorId", instructorId);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvCourses.DataSource = dt;
                gvCourses.DataBind();
            }
        }



        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (ddlOptions.SelectedValue != "" && !string.IsNullOrEmpty(txtInput.Text))
            {
                string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;


                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "UPDATE Courses SET EnrollmentKey = @EnrollmentKey WHERE CourseId = @CourseId";
                    SqlCommand cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@EnrollmentKey", txtInput.Text.Trim());
                    cmd.Parameters.AddWithValue("@CourseId", ddlOptions.SelectedValue);

                    con.Open();
                    int rows = cmd.ExecuteNonQuery();

                    if (rows > 0)
                    {
                        Response.Write("<script>alert('Enrollment Key updated successfully!');</script>");
                        txtInput.Text = "";
                        ddlOptions.SelectedIndex = 0;
                        BindCourses();
                    }
                    else
                    {
                        Response.Write("<script>alert('Update failed. Please try again.');</script>");
                    }
                }
            }
            else
            {
                Response.Write("<script>alert('Please select a course and enter an enrollment key.');</script>");
            }
        }

        private void PopulateQuizzes()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;

            if (Session["UserId"] == null)
            {
                Response.Redirect("~/web1.aspx");
                return;
            }
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT QuizID, Title FROM Quizzes where InstructorID = @InstructorID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@InstructorID", Convert.ToInt32(Session["UserId"].ToString()));
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    ddlQuizzes.DataSource = reader;
                    ddlQuizzes.DataTextField = "Title";  // What will display in dropdown
                    ddlQuizzes.DataValueField = "QuizID";    // The value behind the scenes
                    ddlQuizzes.DataBind();
                    conn.Close();
                }
            }

            // Optional: Add default item
            ddlQuizzes.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Quiz --", "0"));
        }


        private void LoadCourseDrop()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;
                int instructorId = Convert.ToInt32(Session["UserID"]);


                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    // ✅ Assuming courses are linked to instructor by InstructorId
                    string query = @"
                        
                SELECT CourseID, CourseName FROM Courses
                WHERE InstructorID = @InstructorID
                ORDER BY StartDate DESC, CourseTitle ASC;";

                    SqlCommand cmd = new SqlCommand(query, con);

                    // 🔑 Make sure Session["InstructorId"] is set after login
                    cmd.Parameters.AddWithValue("@InstructorId", instructorId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        ddlOptions.DataSource = dt;
                        ddlOptions.DataTextField = "CourseName"; // what student sees
                        ddlOptions.DataValueField = "CourseID"; // value behind
                        ddlOptions.DataBind();
                        ddlOptions.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Course --", ""));

                        cResorce.DataSource = dt;
                        cResorce.DataTextField = "CourseName"; // what student sees
                        cResorce.DataValueField = "CourseID"; // value behind
                        cResorce.DataBind();
                        cResorce.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Course --", ""));

                        qResorce.DataSource = dt;
                        qResorce.DataTextField = "CourseName"; // what student sees
                        qResorce.DataValueField = "CourseID"; // value behind
                        qResorce.DataBind();
                        qResorce.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Course --", ""));

                    }
                }
            }
            catch (Exception ex)
            {
                // Log error for debugging
                Response.Write("<script>alert('Error loading courses: " + ex.Message + "');</script>");
            }
        }




        static DataTable dtCourses = new DataTable();

        string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            


            // Require login
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/web1.aspx"); // your login page
                return;
            }

            if (!IsPostBack)
            {
                // Allow selecting a course without changing your markup
                gvInstructorCourses.AutoGenerateSelectButton = true;
                gvInstructorCourses.DataKeyNames = new[] { "CourseID" };
                LoadStudentAttempts();
                BindCourses();
                BindQuizzes();
                LoadCourseDrop();
                PopulateQuizzes();
                LoadCourses();
            }
        }

        protected void btnSaveQuiz_Click(object sender, EventArgs e)
        {
           

            string query = @"INSERT INTO Quizzes 
    (CourseID, Title, QuizType, StartDate, EndDate, CreatedBy, InstructorID) 
    VALUES (@CourseID, @Title, @QuizType, @StartDate, @EndDate, @CreatedBy, @IntructorID)";
            string connectionString = ConfigurationManager.ConnectionStrings["LMSConnectionString"].ConnectionString;
            int userid = Convert.ToInt32(Session["UserId"]);
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                int id = Convert.ToInt32(qResorce.SelectedValue);
                txtResourceName.Text = id.ToString();

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CourseID", id); // no longer null
                    cmd.Parameters.AddWithValue("@IntructorID", Convert.ToInt32(Session["UserId"].ToString()));
                    cmd.Parameters.AddWithValue("@Title", txtQuizTitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@QuizType", ddlQuizType.SelectedValue);
                    cmd.Parameters.AddWithValue("@StartDate", DateTime.Parse(txtStartDate.Text));
                    cmd.Parameters.AddWithValue("@EndDate", DateTime.Parse(txtEndDate.Text));
                    cmd.Parameters.AddWithValue("@CreatedBy", userid); // from session
              

                if (cmd.Parameters["@CourseID"].Value == null)
                    {
                        throw new Exception("CourseID is missing");
                    }
                    con.Open();
                    cmd.ExecuteNonQuery();
                    BindQuizzes();

                }
            }


            // trigger success popup
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "showModal();", true);

            LoadStudentAttempts();
        }

        private void LoadStudentAttempts()
        {
            // Defensive: Only proceed if a valid quiz is selected
            if (ddlQuizzes.SelectedIndex == 0 || string.IsNullOrEmpty(ddlQuizzes.SelectedValue) || ddlQuizzes.SelectedValue == "0")
                return;


            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"select r.StudentID, u.FullName, r.Score, r.DateTaken
                          from Results r inner join Users u on u.UserID = r.StudentID
                          inner join Quizzes q on q.QuizID = r.QuizID 
                          where q.InstructorID = 4;";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@QuizID", Convert.ToInt32(ddlQuizzes.SelectedValue));
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvStudentAttempts.DataSource = dt;
                gvStudentAttempts.DataBind();
            }
        }


        #region Binding

        private void BindCourses()
        {
            int instructorId = Convert.ToInt32(Session["UserID"]);

            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand(@"
                SELECT CourseID, CourseName, Description, EnrollmentKey,StartDate, EndDate
                FROM Courses
                WHERE InstructorID = @InstructorID
                ORDER BY StartDate DESC, CourseTitle ASC;", conn))
            {
                cmd.Parameters.AddWithValue("@InstructorID", instructorId);

                using (var da = new SqlDataAdapter(cmd))
                {
                    var dt = new DataTable();
                    da.Fill(dt);
                    gvInstructorCourses.DataSource = dt;
                    gvInstructorCourses.DataBind();

                    // If only one course, preselect it for uploads
                    if (dt.Rows.Count == 1)
                    {
                        ViewState["SelectedCourseID"] = dt.Rows[0]["CourseID"];
                        gvInstructorCourses.SelectedIndex = 0;
                    }
                }
            }
        }

        private void BindQuizzes()
        {
            int instructorId = Convert.ToInt32(Session["UserID"]);

            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand(@"
                SELECT QuizID, Title, QuizType, CreatedAt
                FROM Quizzes
                WHERE CreatedBy = @InstructorID
                ORDER BY CreatedAt DESC;", conn))
            {
                cmd.Parameters.AddWithValue("@InstructorID", instructorId);

                using (var da = new SqlDataAdapter(cmd))
                {
                    var dt = new DataTable();
                    da.Fill(dt);
                    GridView2.DataSource = dt;
                    GridView2.DataBind();
                }
            }
        }

        #endregion

        #region Grid events

        protected void gvInstructorCourses_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Store selected CourseID for uploads
            if (gvInstructorCourses.SelectedDataKey != null)
            {
                ViewState["SelectedCourseID"] = gvInstructorCourses.SelectedDataKey.Value;
            }
        }

        #endregion

        #region Upload resource

        // NOTE: Your markup has two FileUpload controls (FileUpload1 and FileUpload2).
        // We'll use FileUpload1 as the actual file input. FileUpload2 seems redundant.
        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                // Validate selected course
                if (cResorce.SelectedIndex == 0)
                {
                        ShowToast("Please select a course from the list above before uploading.", false);
                        return;
                }

                int courseId = Convert.ToInt32(cResorce.SelectedValue);
                int instructorId = Convert.ToInt32(Session["UserID"]);

                // Validate inputs
                string resourceName = (txtResourceName.Text ?? string.Empty).Trim();
                string resourceType = ddlResourceType.SelectedValue;

                if (string.IsNullOrWhiteSpace(resourceName))
                {
                    ShowToast("Enter a resource name.", false);
                    return;
                }
                if (string.IsNullOrWhiteSpace(resourceType))
                {
                    ShowToast("Select a resource type.", false);
                    return;
                }
                if (!FileUpload1.HasFile)
                {
                    ShowToast("Please choose a file to upload.", false);
                    return;
                }

                // Save file
                string uploadsFolderVirtual = "~/Uploads/Resources";
                string uploadsFolderPhysical = Server.MapPath(uploadsFolderVirtual);
                EnsureFolder(uploadsFolderPhysical);

                // Make filename unique to avoid collisions
                string originalName = Path.GetFileName(FileUpload1.FileName);
                string uniqueName = $"{Path.GetFileNameWithoutExtension(originalName)}_{Guid.NewGuid():N}{Path.GetExtension(originalName)}";
                string savePathPhysical = Path.Combine(uploadsFolderPhysical, uniqueName);
                string savePathVirtual = $"{uploadsFolderVirtual}/{uniqueName}";

                FileUpload1.SaveAs(savePathPhysical);

                // Insert DB row
                using (var conn = new SqlConnection(connectionString))
                using (var cmd = new SqlCommand(@"
                    INSERT INTO Resources (CourseID, InstructorID, ResourceName, ResourceType, ResourcePath, UploadedAt)
                    VALUES (@CourseID, @InstructorID, @ResourceName, @ResourceType, @ResourcePath, GETDATE());", conn))
                {
                    cmd.Parameters.AddWithValue("@CourseID", courseId);
                    cmd.Parameters.AddWithValue("@InstructorID", instructorId);
                    cmd.Parameters.AddWithValue("@ResourceName", resourceName);
                    cmd.Parameters.AddWithValue("@ResourceType", resourceType);
                    cmd.Parameters.AddWithValue("@ResourcePath", savePathVirtual);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                // Clear inputs
                txtResourceName.Text = string.Empty;
                ddlResourceType.ClearSelection();
                cResorce.SelectedIndex = 0;
                ShowToast("Resource uploaded successfully.", true);
            }
            catch (Exception ex)
            {
                ShowToast("Upload failed: " + ex.Message, false);
            }
        }

        private static void EnsureFolder(string physicalPath)
        {
            if (!Directory.Exists(physicalPath))
            {
                Directory.CreateDirectory(physicalPath);
            }
        }

        private void ShowToast(string message, bool success)
        {
            // Simple client-side toast using alert (replace with a nicer toast if you wish)
            ScriptManager.RegisterStartupScript(
                this, GetType(), "toast",
                $"alert('{(success ? "✅ " : "⚠️ ")}{message.Replace("'", "\\'")}');",
                true);
        }

        #endregion

        #region Quizzes

        protected void btnAddQuiz_Click(object sender, EventArgs e)
        {
            // Navigate to your quiz management/creation page
            Response.Redirect("~/Teacher page/InstructorManageQuiz.aspx");
        }

        #endregion

        protected void ddlQuizzes_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadStudentAttempts();
        }
    }
}