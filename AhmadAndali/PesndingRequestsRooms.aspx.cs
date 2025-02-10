using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace library
{
    public partial class PendingRequestsRooms : System.Web.UI.Page
    {
        private string pendingRequestsFilePath;
        private string approvedRequestsFilePath;
        private string rejectedRequestsFilePath;
        private string roomsFilePath;

        protected void Page_Load(object sender, EventArgs e)
        {
            pendingRequestsFilePath = Server.MapPath("~/App_Data/PendingRequestsRoom.txt");
            approvedRequestsFilePath = Server.MapPath("~/App_Data/ApprovedRequestsRoom.txt");
            rejectedRequestsFilePath = Server.MapPath("~/App_Data/RejectedRequestsRoom.txt");
            roomsFilePath = Server.MapPath("~/App_Data/rooms.txt");

            if (!IsPostBack)
            {
                LoadPendingRequests();
                LoadApprovedRequests();
            }
        }

        private void LoadPendingRequests()
        {
            if (!File.Exists(pendingRequestsFilePath))
                File.Create(pendingRequestsFilePath).Close();

            List<RoomReservationRequest> requests = new List<RoomReservationRequest>();
            string[] lines = File.ReadAllLines(pendingRequestsFilePath);

            foreach (string line in lines)
            {
                string[] parts = line.Split('|');
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
                        Email = parts[6],
                    });
                }
            }
            gvPendingRequests.DataSource = requests;
            gvPendingRequests.DataBind();
        }

        private void LoadApprovedRequests()
        {
            if (!File.Exists(approvedRequestsFilePath))
                File.Create(approvedRequestsFilePath).Close();

            List<RoomReservationRequest> approvedRequests = new List<RoomReservationRequest>();
            string[] lines = File.ReadAllLines(approvedRequestsFilePath);

            foreach (string line in lines)
            {
                string[] parts = line.Split('|');
                if (parts.Length == 7)
                {
                    approvedRequests.Add(new RoomReservationRequest
                    {
                        Id = parts[0],
                        FullName = parts[1],
                        Room = parts[2],
                        ReservationDate = parts[3],
                        ReservationTime = parts[4],
                        SnackAndPrice = parts[5],
                        Email = parts[6],
                    });
                }
            }
            gvApprovedRequests.DataSource = approvedRequests;
            gvApprovedRequests.DataBind();
        }

        protected void gvPendingRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Approve" || e.CommandName == "Reject")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                string[] requests = File.ReadAllLines(pendingRequestsFilePath).ToArray();

                if (index >= 0 && index < requests.Length)
                {
                    string request = requests[index];

                    if (e.CommandName == "Approve")
                    {
                        // نقل الطلب إلى الطلبات الموافق عليها
                        File.AppendAllText(approvedRequestsFilePath, request + Environment.NewLine);

                        // تحديث حالة الغرفة إلى "محجوزة"
                        UpdateRoomStatus(request.Split('|')[2], "reserved");

                        lblAdminMessage.Text = "Request approved successfully! Room status updated.";
                    }
                    else if (e.CommandName == "Reject")
                    {
                        // حفظ الطلب المرفوض في ملف خاص
                        File.AppendAllText(rejectedRequestsFilePath, request + Environment.NewLine);
                        lblAdminMessage.Text = "Request rejected and saved successfully!";
                    }

                    // حذف الطلب من القائمة المعلقة
                    var updatedRequests = requests.ToList();
                    updatedRequests.RemoveAt(index);
                    File.WriteAllLines(pendingRequestsFilePath, updatedRequests);

                    // تحديث البيانات في الجدول
                    LoadPendingRequests();
                    LoadApprovedRequests();
                }
            }
        }

        private void UpdateRoomStatus(string roomId, string status)
        {
            if (!File.Exists(roomsFilePath))
                File.Create(roomsFilePath).Close();

            string[] rooms = File.ReadAllLines(roomsFilePath);
            for (int i = 0; i < rooms.Length; i++)
            {
                string[] roomDetails = rooms[i].Split(',');
                if (roomDetails.Length == 3 && roomDetails[0] == roomId)
                {
                    rooms[i] = $"{roomDetails[0]},{roomDetails[1]},{status}";
                    break;
                }
            }
            File.WriteAllLines(roomsFilePath, rooms);
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
