
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using library.Sofyan;

namespace library.Abdullah
{
    public partial class BorrowBooks : System.Web.UI.Page
    {

        string loggedInUserFile;

        protected void Page_Load(object sender, EventArgs e)
        {
            loggedInUserFile = Server.MapPath("~/App_Data/loggedInUser.txt");

            if (!IsPostBack)
            {
                LoadBooks();
                LoadBorrowedBooks();
            }
        }

        private void LoadBooks(string searchTerm = "")
        {
            string filePath = Server.MapPath("~/App_Data/books.txt");
            List<Book> books = new List<Book>();

            if (File.Exists(filePath))
            {
                string[] lines = File.ReadAllLines(filePath);
                foreach (string line in lines)
                {
                    string[] parts = line.Split(',');

                    if (parts.Length == 8)
                    {
                        // قراءة البيانات بناءً على التنسيق الجديد
                        Book book = new Book()
                        {
                            ID = parts[0],
                            Title = parts[1],
                            Author = parts[2],
                            TotalCopies = int.Parse(parts[3]),
                            AvailableCopies = int.Parse(parts[4]),
                            Status = parts[5].ToLower() == "available" ? "Available" : "Not Available",
                            ImageURL = ResolveUrl(parts[6]), // تحديد المسار الصحيح للصورة
                            Description = parts[7]
                        };

                        // فقط عرض الكتب المتاحة للحجز
                        books.Add(book);
                    }
                }
            }

            // تطبيق البحث
            if (!string.IsNullOrEmpty(searchTerm))
            {
                books = books.Where(b => b.Title.IndexOf(searchTerm, StringComparison.OrdinalIgnoreCase) >= 0).ToList();
            }

            BooksRepeater.DataSource = books;
            BooksRepeater.DataBind();
        }

        private void LoadBorrowedBooks()
        {
            string filePath = Server.MapPath("~/App_Data/ApprovedRequests.txt");
            List<BorrowRequest> borrowedBooks = new List<BorrowRequest>();

            if (File.Exists(filePath))
            {
                string[] lines = File.ReadAllLines(filePath);
                foreach (string line in lines)
                {
                    string[] parts = line.Split('|');
                    if (parts.Length == 4)
                    {
                        borrowedBooks.Add(new BorrowRequest
                        {
                            BookTitle = parts[0],
                            EmailUser = parts[1],
                            PickupTime = parts[2],
                            DeliveryTime = parts[3]
                        });
                    }
                }
            }

            BorrowedBooksRepeater.DataSource = borrowedBooks;
            BorrowedBooksRepeater.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Text.Trim();
            LoadBooks(searchTerm);

            if (BooksRepeater.Items.Count == 0)
            {
                // No books found, show SweetAlert
                ScriptManager.RegisterStartupScript(this, GetType(), "noBooksAlert", "Swal.fire({ icon: 'info', title: 'No Books Found', text: 'No books found with the given search term.' });", true);
            }
            else
            {
                // Clear any previous messages
                lblMessage.Text = "";
            }
        }

        protected void BooksRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Borrow")
            {
                string bookTitle = e.CommandArgument.ToString();
                hiddenBookTitle.Value = bookTitle;

                string status = "";

                string filePath = Server.MapPath("~/App_Data/books.txt");
                string[] lines = File.ReadAllLines(filePath);
                foreach (string line in lines)
                {
                    string[] parts = line.Split(',');

                    if (parts[1] == bookTitle)
                    {
                        status = parts[5];
                        break; // Exit the loop once the book is found
                    }
                }

                string email = File.ReadAllText(loggedInUserFile).Trim();
                string blackList = Server.MapPath("~/App_Data/blacklist.txt");

                if (File.Exists(blackList))
                {
                    string[] lines2 = File.ReadAllLines(blackList);
                    foreach (string line in lines2)
                    {
                        string[] parts = line.Split(',');

                        if (parts.Length >= 3 && parts[2] == email)
                        {
                            // User is in the blacklist
                            ScriptManager.RegisterStartupScript(this, GetType(), "blacklistAlert", "Swal.fire({ icon: 'error', title: 'Oops...', text: 'You are in the blacklist and cannot borrow books.' });", true);
                            return;
                        }
                    }
                }

                if (status.ToLower() == "available")
                {
                    borrowForm.Visible = true; // Show the borrow form
                }
                else
                {
                    // Book is not available
                    ScriptManager.RegisterStartupScript(this, GetType(), "notAvailableAlert", "Swal.fire({ icon: 'error', title: 'Oops...', text: 'Not available.' });", true);
               
                }
            }
        }

        protected void btnSubmitBorrow_Click(object sender, EventArgs e)
        {
            string bookTitle = hiddenBookTitle.Value;
            string pickupTime = txtPickupTime.Text;
            string deliveryTime = txtDeliveryTime.Text;

            string emailUser = GetLoggedInUserEmail();

            if (string.IsNullOrEmpty(emailUser))
            {
                // Use SweetAlert for error message
                ScriptManager.RegisterStartupScript(this, GetType(), "showErrorAlert", "Swal.fire({ title: 'Error', text: 'Could not retrieve logged-in user email.', icon: 'error', draggable: true });", true);
                return;
            }

            string filePath = Server.MapPath("~/App_Data/PendingRequests.txt");
            string requestDetails = $"{bookTitle}|{emailUser}|{pickupTime}|{deliveryTime}";

            File.AppendAllText(filePath, requestDetails + Environment.NewLine);

            // Use SweetAlert for success message
            ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessAlert", $"Swal.fire({{ title: 'Success', text: 'Your request to borrow \"{bookTitle}\" has been sent to the admin.', icon: 'success', draggable: true }});", true);

            borrowForm.Visible = false;
        }

        private string GetLoggedInUserEmail()
        {


            string email = File.ReadAllText(loggedInUserFile).Trim();
            if (!string.IsNullOrEmpty(email))
            {
                return email;
            }
            else
            {
                lblBorrowMessage.Text = "Error: The logged-in user file is empty.";
                lblBorrowMessage.ForeColor = System.Drawing.Color.Red;
                return string.Empty;

            }
        }


        public class Book
        {
            public string ID { get; set; }
            public string Title { get; set; }
            public string Author { get; set; }
            public int TotalCopies { get; set; }
            public int AvailableCopies { get; set; }
            public string Status { get; set; }
            public string ImageURL { get; set; }
            public string Description { get; set; }
        }

        public class BorrowRequest
        {
            public string BookTitle { get; set; }
            public string EmailUser { get; set; }
            public string PickupTime { get; set; }
            public string DeliveryTime { get; set; }
        }

        protected void lnkHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Sofyan/index.aspx");

        }

        protected void lnkAbout_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Sofyan/AboutUs.aspx");

        }

        protected void lnkBookRoom_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/saja/ReserveRoom.aspx");

        }

        protected void lnkBorrowBook_Click(object sender, EventArgs e)
        {
            Response.Redirect("");

        }

        protected void lnkAboutUs_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Sofyan/AboutUs.aspx");

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
            Response.Redirect("LoginUser.aspx");







        }

        protected void lnkRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/sura/profilePage.aspx");

        }
    }
}