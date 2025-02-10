using System;
using System.IO;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace library
{
    public partial class Notifications : System.Web.UI.Page
    {
        private string notificationsFile;

        protected void Page_Load(object sender, EventArgs e)
        {
            notificationsFile = Server.MapPath("~/App_Data/Notifications.txt");

            if (!IsPostBack)
            {
                LoadNotifications();
            }
        }

        private void LoadNotifications()
        {
            List<Notification> notifications = new List<Notification>();

            if (File.Exists(notificationsFile))
            {
                string[] lines = File.ReadAllLines(notificationsFile);
                foreach (string line in lines)
                {
                    string[] data = line.Split('|');
                    if (data.Length >= 5)
                    {
                        notifications.Add(new Notification
                        {
                            ID = data[0],
                            UserName = data[1],
                            UserEmail = data[2],
                            Message = data[3],
                            DateSent = data[4],
                            Reply = data.Length > 5 ? data[5] : "",
                            ReplyDate = data.Length > 6 ? data[6] : ""
                        });
                    }
                }
            }

            rptNotifications.DataSource = notifications;
            rptNotifications.DataBind();
        }

        protected void SendReply_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string notificationID = btn.CommandArgument;
            TextBox txtReply = (TextBox)btn.NamingContainer.FindControl("txtReply");

            if (txtReply != null && !string.IsNullOrEmpty(txtReply.Text))
            {
                string replyText = txtReply.Text.Trim();
                List<string> updatedLines = new List<string>();

                if (File.Exists(notificationsFile))
                {
                    string[] lines = File.ReadAllLines(notificationsFile);
                    foreach (string line in lines)
                    {
                        string[] data = line.Split('|');
                        if (data[0] == notificationID)
                        {
                            string newLine = string.Join("|", data[0], data[1], data[2], data[3], data[4], replyText, DateTime.Now.ToString("yyyy-MM-dd"));
                            updatedLines.Add(newLine);
                        }
                        else
                        {
                            updatedLines.Add(line);
                        }
                    }

                    File.WriteAllLines(notificationsFile, updatedLines);
                }

                LoadNotifications();
            }
        }

        public class Notification
        {
            public string ID { get; set; }
            public string UserName { get; set; }
            public string UserEmail { get; set; }
            public string Message { get; set; }
            public string DateSent { get; set; }
            public string Reply { get; set; }
            public string ReplyDate { get; set; }
        }
    }
}
