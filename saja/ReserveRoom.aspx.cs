using System;
using System.Collections.Generic;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace library
{


    public partial class ReserveRoom : System.Web.UI.Page
    {







        public class Reservation
        {
            public int Id { get; set; }
            public string FullName { get; set; }
            public string Room { get; set; }
            public string Date { get; set; }
            public string Time { get; set; }
            public string Snack { get; set; }
            public string Email { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadRooms();
                LoadPendingRequests();
                LoadApprovedRequests();
                LoadRejectedRequests();
            }
        }




        private void LoadRooms()
        {
            string filePath = Server.MapPath("~/App_Data/rooms.txt");

            if (File.Exists(filePath))
            {
                // قراءة ملف الغرف
                string[] rooms = File.ReadAllLines(filePath);

                // تفريغ الحاوية الخاصة بالغرف
                roomContainer.Controls.Clear();

                foreach (string room in rooms)
                {
                    string[] details = room.Split(',');

                    if (details.Length == 3)
                    {
                        // إنشاء زر لكل غرفة بناءً على الحالة (متاحة أو محجوزة)
                        Button btn = new Button
                        {
                            Text = details[0], // اسم الغرفة
                            CssClass = details[2].Trim().ToLower() == "available" ? "room available" : "room booked",
                            Enabled = details[2].Trim().ToLower() == "available" // السماح بالنقر فقط إذا كانت الغرفة متاحة
                        };

                        // إضافة حدث JavaScript لتحديد الغرفة عند النقر
                        btn.Attributes.Add("onclick", $"setSelectedRoom('{details[0]}', this);");

                        // إضافة الزر إلى الحاوية
                        roomContainer.Controls.Add(btn);
                    }
                }
            }
            else
            {
                // في حال عدم وجود ملف الغرف
                lblMessage.Visible = true;
                lblMessage.Text = "Rooms data file not found!";
            }
        }


// دالة قراءة البريد الإلكتروني من log.txt
private string emailuser()
{
    string logFilePath = Server.MapPath("~/App_Data/loggedInUser.txt"); // تحديد مسار الملف
    if (File.Exists(logFilePath))
    {
        string[] lines = File.ReadAllLines(logFilePath);
        if (lines.Length > 0)
        {
            return lines[0].Trim(); // إرجاع أول سطر بعد إزالة المسافات الفارغة
        }
    }
    return null; // إذا لم يكن هناك بيانات
}


        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text;
            string room = hiddenSelectedRoom.Value;
            string date = txtDate.Text;
            string time = txtTime.Text;
            string snack = ddlSnack.SelectedItem.Text;
            string email = emailuser();

            if (string.IsNullOrEmpty(room))
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Please select a room before confirming your reservation.";
                return;
            }

            int newId = GetNextReservationId(Server.MapPath("~/App_Data/PendingRequestsRoom.txt"));
            string reservationData = $"{newId}|{fullName}|{room}|{date}|{time}|{snack}|{email}";

            File.AppendAllText(Server.MapPath("~/App_Data/PendingRequestsRoom.txt"), reservationData + "\n");
            lblMessage.Visible = true;
            lblMessage.Text = "Reservation confirmed successfully! Your reservation ID is: " + newId;
            LoadPendingRequests();
            LoadRooms();
        }

        private int GetNextReservationId(string filePath)
        {
            if (!File.Exists(filePath)) return 1;
            string[] lines = File.ReadAllLines(filePath);
            int maxId = 0;
            foreach (string line in lines)
            {
                string[] parts = line.Split('|');
                if (parts.Length > 0 && int.TryParse(parts[0], out int id))
                {
                    maxId = Math.Max(maxId, id);
                }
            }
            return maxId + 1;
        }

        private void LoadRequestsFromFile(string filePath, GridView gridView)
        {
            string fullPath = Server.MapPath(filePath);
            List<Reservation> reservations = new List<Reservation>();

            if (File.Exists(fullPath))
            {
                string[] lines = File.ReadAllLines(fullPath);
                foreach (string line in lines)
                {
                    string[] parts = line.Split('|');
                    if (parts.Length == 7)
                    {
                        reservations.Add(new Reservation
                        {
                            Id = int.Parse(parts[0]),
                            FullName = parts[1],
                            Room = parts[2],
                            Date = parts[3],
                            Time = parts[4],
                            Snack = parts[5],
                            Email = parts[6]
                        });
                    }
                }
            }
            gridView.DataSource = reservations;
            gridView.DataBind();
        }

        private void LoadPendingRequests()
        {
            LoadRequestsFromFile("~/App_Data/PendingRequestsRoom.txt", gvPendingRequests);
        }

        private void LoadApprovedRequests()
        {
            LoadRequestsFromFile("~/App_Data/ApprovedRequestsRoom.txt", gvApprovedRequests);
        }

        private void LoadRejectedRequests()
        {
            LoadRequestsFromFile("~/App_Data/RejectedRequestsRoom.txt", gvRejectedRequests);
        }

        protected void gvPendingRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                RemoveReservationFromFile("~/App_Data/PendingRequestsRoom.txt", e.CommandArgument);
                LoadPendingRequests();
            }
            Response.Redirect("~/saja/ReserveRoom.aspx");

        }

        protected void gvApprovedRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Complete")
            {
                string roomId = GetRoomIdFromReservation("~/App_Data/ApprovedRequestsRoom.txt", e.CommandArgument);
                UpdateRoomStatus(roomId, "available");
                RemoveReservationFromFile("~/App_Data/ApprovedRequestsRoom.txt", e.CommandArgument);
                LoadApprovedRequests();
                LoadRooms();
            }
        }

        private void RemoveReservationFromFile(string filePath, object commandArgument)
        {
            int index = Convert.ToInt32(commandArgument);
            string fullPath = Server.MapPath(filePath);

            if (File.Exists(fullPath))
            {
                string[] lines = File.ReadAllLines(fullPath);
                if (index >= 0 && index < lines.Length)
                {
                    var updatedLines = new List<string>(lines);
                    updatedLines.RemoveAt(index);
                    File.WriteAllLines(fullPath, updatedLines);
                }
            }
        }

        private string GetRoomIdFromReservation(string filePath, object commandArgument)
        {
            int index = Convert.ToInt32(commandArgument);
            string fullPath = Server.MapPath(filePath);

            if (File.Exists(fullPath))
            {
                string[] lines = File.ReadAllLines(fullPath);
                if (index >= 0 && index < lines.Length)
                {
                    string[] parts = lines[index].Split('|');
                    if (parts.Length > 2) return parts[2]; // Room ID is the 3rd part
                }
            }
            return "";
        }

        private void UpdateRoomStatus(string roomId, string status)
        {
            string filePath = Server.MapPath("~/App_Data/rooms.txt");

            if (File.Exists(filePath))
            {
                string[] rooms = File.ReadAllLines(filePath);
                for (int i = 0; i < rooms.Length; i++)
                {
                    string[] details = rooms[i].Split(',');
                    if (details.Length == 3 && details[0] == roomId)
                    {
                        rooms[i] = $"{details[0]},{details[1]},{status}";
                        break;
                    }
                }
                File.WriteAllLines(filePath, rooms);
            }
        }

        protected void lnkHome_Click(object sender, EventArgs e)
        {


            Response.Redirect("~/Sofyan/index.aspx");

        }

        protected void lnkBooking_Click(object sender, EventArgs e)
        {

        }

        protected void lnkContact_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Sofyan/ContactUs.aspx");

        }

        protected void lnkLogin_Click(object sender, EventArgs e)
        {

            string filePath = Server.MapPath("~/App_Data/loggedInUser.txt");

            if (File.Exists(filePath))
            {
                File.WriteAllText(filePath, string.Empty);
            }
            Response.Redirect("~/Sofyan/LoginUser.aspx");

        }

        protected void lnkRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Sura/profilePage.aspx");



        }

        protected void lnkAbout_Click(object sender, EventArgs e)
        {

        }

        protected void lnkBookRoom_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/saja/ReserveRoom.aspx");

        }

        protected void lnkBorrowBook_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Abdullah/BorrowBooks.aspx");

        }

        protected void lnkAboutUs_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Sofyan/AboutUs.aspx");

        }

        protected void lnkMenu_Click(object sender, EventArgs e)
        {

        }
    }
}