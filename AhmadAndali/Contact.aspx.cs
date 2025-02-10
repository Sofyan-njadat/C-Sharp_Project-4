using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.UI;

namespace library
{
    public partial class Contact : System.Web.UI.Page
    {
        private string notificationsFile = HttpContext.Current.Server.MapPath("~/App_Data/Notifications.txt");
        private string loginFile = HttpContext.Current.Server.MapPath("~/App_Data/loggedInUser.txt");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (File.Exists(loginFile) && File.ReadAllLines(loginFile).Length > 0)
                {
                    string loggedInEmail = File.ReadAllText(loginFile).Trim();
                    txtEmail.Text = loggedInEmail;
                    LoadReplies(loggedInEmail); // تحميل الردود المرتبطة بالبريد الإلكتروني
                }
                else
                {
                    lblStatus.Text = "⚠️ يجب عليك تسجيل الدخول لإرسال رسالة.";
                    txtMessage.Enabled = false;
                    btnSendMessage.Enabled = false;
                }
            }
        }

        protected void btnSendMessage_Click(object sender, EventArgs e)
        {
            string userEmail = txtEmail.Text.Trim();
            string userName = File.ReadAllText(loginFile).Trim(); // افتراض وجود اسم المستخدم في الجلسة
            string message = txtMessage.Text.Trim();

            if (string.IsNullOrEmpty(userEmail) || string.IsNullOrEmpty(message))
            {
                lblStatus.Text = "⚠️ يجب تسجيل الدخول وإدخال رسالة قبل الإرسال.";
                return;
            }

            // توليد ID للرسالة بناءً على عدد الرسائل المخزنة
            int messageID = File.Exists(notificationsFile) ? File.ReadAllLines(notificationsFile).Length + 1 : 1;

            // تنسيق البيانات لتتوافق مع الشكل المطلوب: ID|UserName|Email|Message|Date
            string formattedMessage = $"{messageID:D3}|{userName}|{userEmail}|{message}|{DateTime.Now:yyyy-MM-dd}";

            // إنشاء الملف إذا لم يكن موجودًا
            if (!File.Exists(notificationsFile))
            {
                File.Create(notificationsFile).Close();
            }

            // تخزين الرسالة في الملف
            File.AppendAllText(notificationsFile, formattedMessage + Environment.NewLine);

            lblStatus.Text = " The message has been sent successufully!✅";
            txtMessage.Text = "";
        }

        private void LoadReplies(string userEmail)
        {
            List<Notification> userNotifications = new List<Notification>();

            if (File.Exists(notificationsFile))
            {
                string[] lines = File.ReadAllLines(notificationsFile);
                foreach (string line in lines)
                {
                    string[] data = line.Split('|');
                    if (data.Length >= 7 && data[2] == userEmail && !string.IsNullOrEmpty(data[5])) // التحقق من وجود رد
                    {
                        userNotifications.Add(new Notification
                        {
                            Reply = data[5],
                            ReplyDate = data.Length > 6 ? data[6] : "N/A"
                        });
                    }
                }
            }

            rptReplies.DataSource = userNotifications;
            rptReplies.DataBind();
        }

        public class Notification
        {
            public string Reply { get; set; }
            public string ReplyDate { get; set; }
        }
    }
}
