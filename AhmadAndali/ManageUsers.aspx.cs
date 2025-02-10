using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using iText.Kernel.Colors;
using iText.Kernel.Pdf;
using iText.Layout;
using iText.Layout.Element;
using System.Web.UI.WebControls;


namespace ProjectWebforms.Ahmad
{
    public partial class ManageUsers : System.Web.UI.Page
    {
        private string usersFilePath = HttpContext.Current.Server.MapPath("~/App_Data/users.txt");
        private string manageUsersFilePath = HttpContext.Current.Server.MapPath("~/App_Data/manageUsers.txt");
        private string blacklistFilePath = HttpContext.Current.Server.MapPath("~/App_Data/blacklist.txt");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUsers();
            }
        }

        private void LoadUsers()
        {
            // قراءة المستخدمين من ملف users.txt
            List<User> originalUsers = ReadUsersFromFile(usersFilePath);

            // التأكد من وجود المستخدمين في manageUsers.txt
            List<User> managedUsers = ReadUsersFromFile(manageUsersFilePath);

            foreach (var originalUser in originalUsers)
            {
                if (!managedUsers.Any(u => u.Email == originalUser.Email))
                {
                    originalUser.Bookings = 0;
                    originalUser.Delays = 0;
                    managedUsers.Add(originalUser);
                }
            }

            // تحديث ملف manageUsers.txt
            WriteUsersToFile(manageUsersFilePath, managedUsers);

            // عرض البيانات
            gvUsers.DataSource = managedUsers;
            gvUsers.DataBind();

            // تحميل القائمة السوداء
            List<User> blacklistedUsers = ReadUsersFromFile(blacklistFilePath);
            gvBlacklistedUsers.DataSource = blacklistedUsers;
            gvBlacklistedUsers.DataBind();
        }

        private List<User> ReadUsersFromFile(string filePath)
        {
            List<User> users = new List<User>();

            if (File.Exists(filePath))
            {
                var lines = File.ReadAllLines(filePath);
                foreach (var line in lines)
                {
                    users.Add(User.FromCsv(line));
                }
            }

            return users;
        }

        private void WriteUsersToFile(string filePath, List<User> users)
        {
            File.WriteAllLines(filePath, users.Select(u => u.ToCsv()));
        }

        protected void btnSearchUser_Click(object sender, EventArgs e)
        {
            string searchQuery = txtUserSearch.Text.Trim().ToLower();
            List<User> users = ReadUsersFromFile(manageUsersFilePath);

            var filteredUsers = users.Where(u => u.Email.ToLower().Contains(searchQuery) || u.FirstName.ToLower().Contains(searchQuery)).ToList();

            gvUsers.DataSource = filteredUsers;
            gvUsers.DataBind();
        }

        protected void btnWarnUser_Click(object sender, EventArgs e)
        {
            string userEmail = (sender as Button).CommandArgument;
            List<User> managedUsers = ReadUsersFromFile(manageUsersFilePath);

            foreach (var user in managedUsers)
            {
                if (user.Email == userEmail)
                {
                    user.Delays++;

                    // إذا وصل إلى 3 تحذيرات، يتم نقله إلى القائمة السوداء
                    if (user.Delays >= 3)
                    {
                        managedUsers.Remove(user);
                        AppendUserToBlacklist(user);
                    }
                    break;
                }
            }

            WriteUsersToFile(manageUsersFilePath, managedUsers);
            LoadUsers();
        }

        protected void btnRestoreUser_Click(object sender, EventArgs e)
        {
            string userEmail = (sender as Button).CommandArgument;
            List<User> blacklistedUsers = ReadUsersFromFile(blacklistFilePath);
            List<User> managedUsers = ReadUsersFromFile(manageUsersFilePath);

            var userToRestore = blacklistedUsers.FirstOrDefault(u => u.Email == userEmail);
            if (userToRestore != null)
            {
                // إزالة المستخدم من القائمة السوداء
                blacklistedUsers.Remove(userToRestore);

                // التأكد من عدم وجود المستخدم في القائمة المُدارة قبل الإضافة
                managedUsers.RemoveAll(u => u.Email == userEmail);

                // إعادة ضبط التحذيرات وإضافته للقائمة المُدارة
                userToRestore.Delays = 2;
                managedUsers.Add(userToRestore);

                // تحديث الملفات
                WriteUsersToFile(blacklistFilePath, blacklistedUsers);
                WriteUsersToFile(manageUsersFilePath, managedUsers);
            }

            LoadUsers(); // إعادة تحميل البيانات بعد التعديل
        }


        private void AppendUserToBlacklist(User user)
        {
            File.AppendAllText(blacklistFilePath, user.ToCsv() + Environment.NewLine);
        }

        protected void btnExportUsersPDF_Click(object sender, EventArgs e)
        {
            string pdfPath = Path.GetTempPath() + "UsersList.pdf";
            var users = ReadUsersFromFile(manageUsersFilePath);

            using (PdfWriter writer = new PdfWriter(pdfPath))
            using (PdfDocument pdf = new PdfDocument(writer))
            using (Document document = new Document(pdf))
            {
                document.Add(new Paragraph("Library Users List")
                    .SetFontSize(20)
                    .SetTextAlignment(iText.Layout.Properties.TextAlignment.CENTER));
                document.Add(new Paragraph("\n"));

                var table = new iText.Layout.Element.Table(new float[] { 2, 2, 3, 2, 2, 2 }).UseAllAvailableWidth();
                table.AddHeaderCell(new Cell().Add(new Paragraph("First Name").SetBackgroundColor(ColorConstants.LIGHT_GRAY)));
                table.AddHeaderCell(new Cell().Add(new Paragraph("Last Name").SetBackgroundColor(ColorConstants.LIGHT_GRAY)));
                table.AddHeaderCell(new Cell().Add(new Paragraph("Email").SetBackgroundColor(ColorConstants.LIGHT_GRAY)));
                table.AddHeaderCell(new Cell().Add(new Paragraph("Phone").SetBackgroundColor(ColorConstants.LIGHT_GRAY)));
                table.AddHeaderCell(new Cell().Add(new Paragraph("Bookings").SetBackgroundColor(ColorConstants.LIGHT_GRAY)));
                table.AddHeaderCell(new Cell().Add(new Paragraph("Delays").SetBackgroundColor(ColorConstants.LIGHT_GRAY)));

                foreach (var user in users)
                {
                    table.AddCell(user.FirstName);
                    table.AddCell(user.LastName);
                    table.AddCell(user.Email);
                    table.AddCell(user.Phone);
                    table.AddCell(user.Bookings.ToString());
                    table.AddCell(user.Delays.ToString());
                }

                document.Add(table);
            }

            Response.ContentType = "application/pdf";
            Response.AppendHeader("Content-Disposition", "attachment; filename=UsersList.pdf");
            Response.TransmitFile(pdfPath);
            Response.End();
        }

        public class User
        {
            public string FirstName { get; set; }
            public string LastName { get; set; }
            public string Email { get; set; }
            public string Phone { get; set; }
            public string Password { get; set; }
            public int Bookings { get; set; }
            public int Delays { get; set; }

            public string ToCsv()
            {
                return $"{FirstName},{LastName},{Email},{Phone},{Password},{Bookings},{Delays}";
            }

            public static User FromCsv(string csvLine)
            {
                var parts = csvLine.Split(',');
                return new User
                {
                    FirstName = parts.ElementAtOrDefault(0) ?? "",
                    LastName = parts.ElementAtOrDefault(1) ?? "",
                    Email = parts.ElementAtOrDefault(2) ?? "",
                    Phone = parts.ElementAtOrDefault(3) ?? "",
                    Password = parts.ElementAtOrDefault(4) ?? "",
                    Bookings = int.TryParse(parts.ElementAtOrDefault(5), out int bookings) ? bookings : 0,
                    Delays = int.TryParse(parts.ElementAtOrDefault(6), out int delays) ? delays : 0
                };
            }
        }
    }
}
