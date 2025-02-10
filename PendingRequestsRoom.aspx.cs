using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace library
{
    public partial class PendingRequestsRoom : System.Web.UI.Page
    {
        private string pendingRequestsFile = HttpContext.Current.Server.MapPath("~/App_Data/PendingRequestsRoom.txt");
        private string approvedRequestsFile = HttpContext.Current.Server.MapPath("~/App_Data/ApprovedRequestsRoom.txt");
        private string roomsFile = HttpContext.Current.Server.MapPath("~/App_Data/rooms.txt");
        private string blacklistFile = HttpContext.Current.Server.MapPath("~/App_Data/blacklist.txt");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblAdminMessage.Visible = false;
                LoadPendingRequests();
                LoadApprovedRequests();
            }
        }

        private void LoadPendingRequests()
        {
            List<RoomReservationRequest> requests = new List<RoomReservationRequest>();

            if (File.Exists(pendingRequestsFile))
            {
                foreach (var line in File.ReadAllLines(pendingRequestsFile))
                {
                    var parts = line.Split('|');
                    if (parts.Length == 7)
                    {
                        requests.Add(new RoomReservationRequest
                        {
                            Id = parts[0],
                            FullName = parts[1],
                            Room = parts[2],
                            ReservationDate = parts[3],
                            ReservationTime = parts[4],
                            SnackAndPrice = parts[5],
                            Email = parts[6]
                        });
                    }
                }
            }

            gvPendingRequests.DataSource = requests;
            gvPendingRequests.DataBind();
        }

        private void LoadApprovedRequests()
        {
            List<RoomReservationRequest> requests = new List<RoomReservationRequest>();

            if (File.Exists(approvedRequestsFile))
            {
                foreach (var line in File.ReadAllLines(approvedRequestsFile))
                {
                    var parts = line.Split('|');
                    if (parts.Length == 7)
                    {
                        requests.Add(new RoomReservationRequest
                        {
                            Id = parts[0],
                            FullName = parts[1],
                            Room = parts[2],
                            ReservationDate = parts[3],
                            ReservationTime = parts[4],
                            SnackAndPrice = parts[5],
                            Email = parts[6]
                        });
                    }
                }
            }

            gvApprovedRequests.DataSource = requests;
            gvApprovedRequests.DataBind();
        }

        protected void gvPendingRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Approve")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                string[] requests = File.ReadAllLines(pendingRequestsFile);

                if (index >= 0 && index < requests.Length)
                {
                    string requestLine = requests[index];
                    var requestParts = requestLine.Split('|');

                    if (IsUserBlacklisted(requestParts[6]))
                    {
                        lblAdminMessage.Text = "⚠️ Cannot approve request. User is blacklisted.";
                        lblAdminMessage.Visible = true;
                        return;
                    }

                    if (IsRoomAvailable(requestParts[2]))
                    {
                        // تحديث حالة الغرفة إلى "غير متاحة"
                        UpdateRoomAvailability(requestParts[2]);

                        // نقل الطلب إلى قائمة الطلبات المقبولة
                        File.AppendAllText(approvedRequestsFile, requestLine + Environment.NewLine);

                        // إزالة الطلب من قائمة الانتظار
                        List<string> updatedRequests = requests.ToList();
                        updatedRequests.RemoveAt(index);
                        File.WriteAllLines(pendingRequestsFile, updatedRequests);

                        lblAdminMessage.Text = "✅ Request approved successfully!";
                    }
                    else
                    {
                        lblAdminMessage.Text = "❌ Room is already booked!";
                    }

                    lblAdminMessage.Visible = true;
                    LoadPendingRequests();
                    LoadApprovedRequests();
                }
            }
        }

        private bool IsUserBlacklisted(string userEmail)
        {
            return File.Exists(blacklistFile) && File.ReadAllLines(blacklistFile).Any(line => line.Contains(userEmail));
        }

        private bool IsRoomAvailable(string room)
        {
            if (!File.Exists(roomsFile)) return false;

            var lines = File.ReadAllLines(roomsFile);
            foreach (var line in lines)
            {
                var parts = line.Split(',');
                if (parts.Length > 2 && parts[0] == room && parts[2] == "available") // تأكد أن الغرفة متاحة
                {
                    return true;
                }
            }
            return false;
        }

        private void UpdateRoomAvailability(string room)
        {
            if (!File.Exists(roomsFile)) return;

            var lines = File.ReadAllLines(roomsFile).ToList();
            for (int i = 0; i < lines.Count; i++)
            {
                var parts = lines[i].Split(',');
                if (parts.Length > 2 && parts[0] == room && parts[2] == "available")
                {
                    parts[2] = "booked"; // تغيير الحالة إلى محجوزة
                    lines[i] = string.Join(",", parts);
                    break;
                }
            }

            File.WriteAllLines(roomsFile, lines);
        }

        public class RoomReservationRequest
        {
            public string Id { get; set; }
            public string FullName { get; set; }
            public string Room { get; set; }
            public string ReservationDate { get; set; }
            public string ReservationTime { get; set; }
            public string SnackAndPrice { get; set; }
            public string Email { get; set; }
        }
    }
}
