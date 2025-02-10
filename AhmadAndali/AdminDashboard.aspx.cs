using System;
using System.IO;
using System.Linq;
using System.Web.UI;

namespace library
{
    public partial class AdminDashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboardData();
            }
        }

        private void LoadDashboardData()
        {
            int totalBooks = GetTotalBooks();
            int availableRooms = GetAvailableRooms();
            int pendingReservations = GetPendingReservations();
            int pendingReservationsRooms = GetPendingReservationsRooms();

            lblTotalBooks.Text = totalBooks.ToString();
            lblAvailableRooms.Text = availableRooms.ToString();
            lblPendingReservations.Text = pendingReservations.ToString();
            lblPendingReservationsRooms.Text = pendingReservationsRooms.ToString();
        }

        private int GetTotalBooks()
        {
            string filePath = Server.MapPath("~/App_Data/books.txt");
            if (!File.Exists(filePath)) return 0;

            return File.ReadLines(filePath).Count(); // كل سطر يمثل كتابًا
        }

        private int GetAvailableRooms()
        {
            string filePath = Server.MapPath("~/App_Data/rooms.txt");
            if (!File.Exists(filePath)) return 0;

            return File.ReadLines(filePath).Count(line => line.Contains("available")); // عد الغرف المتاحة فقط
        }

        private int GetPendingReservations()
        {
            string filePath = Server.MapPath("~/App_Data/PendingRequests.txt");
            if (!File.Exists(filePath)) return 0;

            return File.ReadLines(filePath).Count(); // قراءة عدد السطور فقط
        }

        private int GetPendingReservationsRooms()
        {
            string filePath = Server.MapPath("~/App_Data/PendingRequestsRoom.txt"); // ✅ تصحيح المسار ليشير إلى ملف وليس مجلد
            if (!File.Exists(filePath)) return 0;

            return File.ReadLines(filePath).Count(); // قراءة عدد السطور فقط
        }
    }
}
