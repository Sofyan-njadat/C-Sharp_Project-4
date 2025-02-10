using System;
using System.IO;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iText.IO.Colors;

namespace library.Sura
{
    public partial class profilePage : System.Web.UI.Page
    {
        public string loggedInEmail;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadRoomHistory();

                LoadUserHistory();
                GetLoggedInUserEmail();
                viewUserData();
                editUserData();
                imgProfile.ImageUrl = "https://bootdey.com/img/Content/avatar/avatar7.png"; // الصورة الافتراضية
            }
        }

        // ✅ جلب البريد الإلكتروني للمستخدم المسجل حاليًا
        protected void GetLoggedInUserEmail()
        {
            string fileLogged = Server.MapPath("~/App_Data/loggedInUser.txt");
            if (File.Exists(fileLogged))
            {
                string[] lines = File.ReadAllLines(fileLogged);
                if (lines.Length > 0)
                {
                    loggedInEmail = lines[0].Trim(); // استخراج الإيميل
                }
            }
        }

        // ✅ عرض بيانات المستخدم بناءً على الإيميل المسجل حاليًا
        protected void viewUserData()
        {


            string file = Server.MapPath("~/App_Data/users.txt");
            if (File.Exists(file))
            {
                string[] data = File.ReadAllLines(file);
                foreach (string line in data)
                {
                    string[] userData = line.Split(',');



                    fullName.InnerHtml = $"<div>{userData[0]}</div>";
                    lastname.InnerHtml = $"<div>{userData[1]}</div>";
                    email1.InnerHtml = $"<div>{userData[2]}</div>";
                    phone1.InnerHtml = $"<div>{userData[3]}</div>";
                    FullN.InnerHtml = $"<div>{userData[0]} {userData[1]}</div>";
                    break;

                }
            }
        }

        // ✅ تعديل بيانات المستخدم وعرضها في الحقول
        protected void editUserData()
        {


            string file = Server.MapPath("~/App_Data/users.txt");
            if (File.Exists(file))
            {
                string[] data = File.ReadAllLines(file);
                foreach (string line in data)
                {
                    string[] userData = line.Split(',');
                    if (userData.Length >= 5 && userData[2] == loggedInEmail)
                    {
                        fName.Text = userData[0];
                        lName.Text = userData[1];
                        email.Text = userData[2];
                        phone.Text = userData[3];
                        break;
                    }
                }

            }
        }

        // ✅ حفظ التعديلات على بيانات المستخدم
        protected void save_Click(object sender, EventArgs e)
        {


            string file = Server.MapPath("~/App_Data/users.txt");
            if (string.IsNullOrEmpty(fName.Text) || string.IsNullOrEmpty(lName.Text) ||
                string.IsNullOrEmpty(email.Text) || string.IsNullOrEmpty(phone.Text))
            {
                result2.Text = "Please fill all fields!";
                result2.Visible = true;
                result2.CssClass = "danger";
                return;
            }

            if (File.Exists(file))
            {
                string[] lines = File.ReadAllLines(file);
                for (int i = 0; i < lines.Length; i++)
                {
                    string[] userData = lines[i].Split(',');
                    userData[0] = fName.Text;
                    userData[1] = lName.Text;
                    userData[2] = email.Text;
                    userData[3] = phone.Text;

                    lines[i] = string.Join(",", userData);
                    File.WriteAllLines(file, lines); // حفظ التعديلات في الملف

                    result2.Text = "Profile updated successfully!";
                    result2.Visible = true;
                    result2.CssClass = "success";

                    viewUserData(); // تحديث العرض بعد الحفظ
                    return;

                }
            }
        }

        // ✅ تحديث كلمة المرور
        protected void savepass_Click(object sender, EventArgs e)
        {


            string file = Server.MapPath("~/App_Data/users.txt");
            if (string.IsNullOrEmpty(CurrentPass.Text) || string.IsNullOrEmpty(newPass.Text) || string.IsNullOrEmpty(confirmPass.Text))
            {
                result.Text = "Please fill all fields!";
                result.Visible = true;
                result.CssClass = "danger";
                return;
            }

            if (File.Exists(file))
            {
                string[] lines = File.ReadAllLines(file);
                for (int i = 0; i < lines.Length; i++)
                {
                    string[] userData = lines[i].Split(',');

                    if (userData[4] != CurrentPass.Text)
                    {
                        result.Text = "The current password you entered is incorrect!";
                        result.Visible = true;
                        result.CssClass = "danger";
                        return;
                    }
                    else if (newPass.Text == confirmPass.Text)
                    {
                        userData[4] = newPass.Text; // تحديث كلمة المرور
                        lines[i] = string.Join(",", userData);
                        File.WriteAllLines(file, lines);

                        result.Text = "Password updated successfully!";
                        result.Visible = true;
                        result.CssClass = "success";
                        return;
                    }
                    else
                    {
                        result.Text = "Passwords do not match!";
                        result.Visible = true;
                        result.CssClass = "danger";
                        return;
                    }
                }
            }

        }
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (fuProfileImage.HasFile)
            {
                string folderPath = Server.MapPath("~/App_Data/ApprovedRequestsRoom"); // تأكد من وجود مجلد "Uploads" في المشروع

                // إنشاء المجلد إذا لم يكن موجودًا
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                // حفظ الملف في المجلد
                string fileName = Path.GetFileName(fuProfileImage.FileName);
                string filePath = Path.Combine(folderPath, fileName);
                fuProfileImage.SaveAs(filePath);

                // تحديث الصورة في الصفحة
                imgProfile.ImageUrl = "~//" + fileName;
            }
        }

        protected void LoadUserHistory()
        {
            // جلب البريد الإلكتروني للمستخدم من الـ Session (أو أي مصدر آخر)
            string userEmail = Server.MapPath("~/App_Data/loggedInUser.txt");


            if (string.IsNullOrEmpty(userEmail))
            {
                bookHis.InnerHtml = "<tr><td colspan='3'>يجب تسجيل الدخول لعرض السجل</td></tr>";
                return;
            }
            // تحديد مسار ملف الهيستوري
            string filePath = Server.MapPath("~/App_Data/ApprovedRequests.txt");

            if (File.Exists(filePath))
            {
                String[] email = File.ReadAllLines(userEmail);
                StringBuilder html = new StringBuilder();
                string[] historyLines = File.ReadAllLines(filePath);
                bool hasRecords = false;

                foreach (var line in historyLines)
                {
                    // تحديث تقسيم السطر بناءً على الفاصل المناسب (قد يكون مسافة أو فاصلة)
                    string[] historyData = line.Split('|'); // عدّل الفاصل إذا لزم الأمر

                    if (historyData.Length >= 4 && historyData[1] == email[0]) // التأكد من أن البريد يطابق المسجل
                    {
                        hasRecords = true;
                        string bookName = historyData[0].Trim();   // اسم الكتاب
                        string startDate = historyData[2].Trim(); // تاريخ البداية
                        string endDate = historyData[3].Trim();   // تاريخ النهاية

                        html.Append($"<tr><td>{bookName}</td><td>{startDate}</td><td>{endDate}</td></tr>");
                    }
                }

                // إذا لم تكن هناك بيانات للمستخدم
                if (!hasRecords)
                {
                    html.Append("<tr><td colspan='3'>لا يوجد سجل استعارة لهذا المستخدم</td></tr>");
                }

                bookHis.InnerHtml = html.ToString();
            }
            else
            {
                bookHis.InnerHtml = "<tr><td colspan='3'>ملف السجل غير موجود!</td></tr>";
            }

        }
    

private void LoadRoomHistory()
        {

            string userEmail = Server.MapPath("~/App_Data/loggedInUser.txt");

            // مسار ملف السجل
            string filePath = Server.MapPath("~/App_Data/ApprovedRequestsRoom.txt");

            if (File.Exists(filePath))
            {
                String[] email = File.ReadAllLines(userEmail);

                StringBuilder html = new StringBuilder();
                string[] lines = File.ReadAllLines(filePath);
                bool hasRecords = false;

                foreach (var line in lines)
                {
                    string[] data = line.Split('|');

                    // التأكد من أن السطر يحتوي على البيانات المطلوبة
                    if (data.Length >= 7 && !string.IsNullOrEmpty(data[6].Trim()) && data[6].Trim() == email[0])
                    {
                        hasRecords = true;

                        string roomName = data[1].Trim();  // اسم الغرفة
                        string date = data[3].Trim();      // التاريخ
                        string time = data[4].Trim();      // الوقت
                        string snack = data[5].Trim();     // الوجبة

                        html.Append($"<tr><td>{roomName}</td><td>{date}</td><td>{time}</td><td>{snack}</td></tr>");
                    }
                }

                if (!hasRecords)
                {
                    html.Append("<tr><td colspan='4'>لا يوجد سجل حجوزات لهذا المستخدم</td></tr>");
                }

                roomHis.InnerHtml = html.ToString();
            }
            else
            {
                roomHis.InnerHtml = "<tr><td colspan='4'>ملف السجل غير موجود!</td></tr>";
            }
        }

        protected void logout_Click(object sender, EventArgs e)
        {

            string filePath = Server.MapPath("~/App_Data/loggedInUser.txt");

            if (File.Exists(filePath))
            {
                File.WriteAllText(filePath, string.Empty);
            }
            Response.Redirect("LoginUser.aspx");

        }

        protected void profile_Click(object sender, EventArgs e)
        {
            Response.Redirect("");

        }
    }
    }

