using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace library
{
    public partial class Pending_Requests : Page
    {
        private string pendingRequestsFile = HttpContext.Current.Server.MapPath("~/App_Data/PendingRequests.txt");
        private string approvedRequestsFile = HttpContext.Current.Server.MapPath("~/App_Data/ApprovedRequests.txt");
        private string booksFile = HttpContext.Current.Server.MapPath("~/App_Data/books.txt");
        private string blacklistFile = HttpContext.Current.Server.MapPath("~/App_Data/blacklist.txt");
        private string rejectedRequestsFile = HttpContext.Current.Server.MapPath("~/App_Data/RejectedRequests.txt");
        private string invalidRequestsFile = HttpContext.Current.Server.MapPath("~/App_Data/InvalidRequests.txt");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Visible = false;
                LoadPendingRequests();
                LoadApprovedRequests();
            }
        }

        private void LoadPendingRequests()
        {
            List<BorrowRequest> requests = new List<BorrowRequest>();

            if (File.Exists(pendingRequestsFile))
            {
                foreach (var line in File.ReadAllLines(pendingRequestsFile))
                {
                    if (string.IsNullOrWhiteSpace(line)) continue;

                    var parts = line.Split('|');
                    if (parts.Length == 4)
                    {
                        requests.Add(new BorrowRequest
                        {
                            BookTitle = parts[0],
                            UserEmail = parts[1],
                            BorrowDate = parts[2],
                            ReturnDate = parts[3]
                        });
                    }
                    else
                    {
                        File.AppendAllText(invalidRequestsFile, line + Environment.NewLine);
                    }
                }
            }

            gvPendingRequests.DataSource = requests;
            gvPendingRequests.DataBind();
        }

        private void LoadApprovedRequests()
        {
            List<BorrowRequest> requests = new List<BorrowRequest>();

            if (File.Exists(approvedRequestsFile))
            {
                foreach (var line in File.ReadAllLines(approvedRequestsFile))
                {
                    var parts = line.Split('|');
                    if (parts.Length == 4)
                    {
                        requests.Add(new BorrowRequest
                        {
                            BookTitle = parts[0],
                            UserEmail = parts[1],
                            BorrowDate = parts[2],
                            ReturnDate = parts[3]
                        });
                    }
                }
            }

            gvApprovedRequests.DataSource = requests;
            gvApprovedRequests.DataBind();
        }

        protected void gvPendingRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Approve" || e.CommandName == "Reject")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                string[] requests = File.ReadAllLines(pendingRequestsFile);

                if (index >= 0 && index < requests.Length)
                {
                    string requestLine = requests[index];
                    var requestParts = requestLine.Split('|');

                    if (requestParts.Length != 4)
                    {
                        lblMessage.Text = "⚠️ Invalid request format.";
                        lblMessage.Visible = true;
                        return;
                    }

                    string bookTitle = requestParts[0];
                    string userEmail = requestParts[1];

                    if (e.CommandName == "Approve")
                    {
                        if (IsUserBlacklisted(userEmail))
                        {
                            lblMessage.Text = "⚠️ Cannot approve request. User is blacklisted.";
                            lblMessage.Visible = true;
                            return;
                        }

                        if (!IsBookAvailable(bookTitle))
                        {
                            lblMessage.Text = "❌ Cannot approve request. No available copies.";
                            lblMessage.Visible = true;
                            File.AppendAllText(rejectedRequestsFile, requestLine + Environment.NewLine);
                            return;
                        }

                        UpdateBookAvailability(bookTitle);
                        File.AppendAllText(approvedRequestsFile, requestLine + Environment.NewLine);
                    }

                    List<string> updatedRequests = requests.ToList();
                    updatedRequests.RemoveAt(index);
                    File.WriteAllLines(pendingRequestsFile, updatedRequests);

                    lblMessage.Text = e.CommandName == "Approve" ? "✅ Request approved!" : "❌ Request rejected!";
                    lblMessage.Visible = true;

                    LoadPendingRequests();
                    LoadApprovedRequests();
                }
            }
        }

        private bool IsUserBlacklisted(string userEmail)
        {
            return File.Exists(blacklistFile) && File.ReadAllLines(blacklistFile).Any(line => line.Contains(userEmail));
        }

        private bool IsBookAvailable(string bookTitle)
        {
            if (!File.Exists(booksFile)) return false;

            var lines = File.ReadAllLines(booksFile);
            foreach (var line in lines)
            {
                var parts = line.Split(',');
                if (parts.Length > 4 && parts[1] == bookTitle)
                {
                    int availableCopies = int.Parse(parts[4]);
                    return availableCopies > 0;
                }
            }
            return false;
        }

        private void UpdateBookAvailability(string bookTitle)
        {
            if (!File.Exists(booksFile)) return;

            var lines = File.ReadAllLines(booksFile).ToList();
            bool updated = false;

            for (int i = 0; i < lines.Count; i++)
            {
                var parts = lines[i].Split(',');
                if (parts.Length > 4 && parts[1] == bookTitle)
                {
                    int availableCopies = int.Parse(parts[4]);

                    if (availableCopies > 0)
                    {
                        parts[4] = (availableCopies - 1).ToString();
                        if (int.Parse(parts[4]) == 0)
                        {
                            parts[5] = "reserved";
                        }
                        lines[i] = string.Join(",", parts);
                        updated = true;
                    }
                }
            }

            if (updated)
            {
                File.WriteAllLines(booksFile, lines);
            }
        }

        public class BorrowRequest 
        {
            public string BookTitle { get; set; }
            public string UserEmail { get; set; }
            public string BorrowDate { get; set; }
            public string ReturnDate { get; set; }
        }
    }
}
