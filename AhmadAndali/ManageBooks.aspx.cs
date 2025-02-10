using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iText.Kernel.Pdf;
using iText.Layout;
using iText.Layout.Element;
using iText.Kernel.Colors;

namespace library
{
    public partial class ManageBooks : Page
    {
        private string filePath = HttpContext.Current.Server.MapPath("~/App_Data/books.txt");
        private string filterFilePath = HttpContext.Current.Server.MapPath("~/App_Data/filteredBooks.txt");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBooks();
            }
        }

        private void LoadBooks(string filter = "all", string searchQuery = "")
        {
            List<Book> books = File.Exists(filePath)
                ? File.ReadAllLines(filePath)
                    .Where(line => !string.IsNullOrWhiteSpace(line))
                    .Select(line => line.Split(','))
                    .Select(parts => new Book
                    {
                        BookID = parts[0],
                        Title = parts[1],
                        Author = parts[2],
                        TotalCopies = int.Parse(parts[3]),
                        AvailableCopies = int.Parse(parts[4]),
                        Status = parts[5],
                        ImagePath = parts.Length > 6 ? parts[6] : "~/Images/Books/default.png",
                        Description = parts.Length > 7 ? parts[7] : "No Description"
                    }).ToList()
                : new List<Book>();

            if (!string.IsNullOrEmpty(searchQuery))
            {
                books = books.Where(b => b.Title.ToLower().Contains(searchQuery.ToLower()) ||
                                         b.BookID.ToLower().Contains(searchQuery.ToLower())).ToList();
            }

            if (filter == "available")
                books = books.Where(b => b.AvailableCopies > 0).ToList();
            else if (filter == "reserved")
                books = books.Where(b => b.AvailableCopies == 0).ToList();

            gvBooks.DataSource = books;
            gvBooks.DataBind();

            File.WriteAllLines(filterFilePath, books.Select(b =>
                $"{b.BookID},{b.Title},{b.Author},{b.TotalCopies},{b.AvailableCopies},{b.Status},{b.ImagePath},{b.Description}"));
        }

        protected void btnSearch_Click(object sender, EventArgs e) => LoadBooks("all", txtSearch.Text.Trim());

        protected void btnFilter_Click(object sender, EventArgs e) => LoadBooks(ddlFilter.SelectedValue);

        protected void btnAddBook_Click(object sender, EventArgs e)
        {
            int nextId = File.Exists(filePath) && File.ReadLines(filePath).Any()
                ? int.Parse(File.ReadLines(filePath).Last().Split(',')[0]) + 1
                : 1;

            string title = txtTitle.Text.Trim();
            string author = txtAuthor.Text.Trim();
            string description = txtDescription.Text.Trim();
            int totalCopies = int.TryParse(txtTotalCopies.Text.Trim(), out int copies) ? copies : 0;
            string status = totalCopies > 0 ? "available" : "reserved";

            string imagePath = "~/Images/Books/default.png";
            if (fuBookImage.HasFile)
            {
                string fileName = $"{nextId}_{Path.GetFileName(fuBookImage.FileName)}";
                string folderPath = Server.MapPath("~/Images/Books/");
                if (!Directory.Exists(folderPath)) Directory.CreateDirectory(folderPath);
                fuBookImage.SaveAs(Path.Combine(folderPath, fileName));
                imagePath = "~/Images/Books/" + fileName;
            }

            string newBook = $"{nextId},{title},{author},{totalCopies},{totalCopies},{status},{imagePath},{description}";
            File.AppendAllText(filePath, newBook + Environment.NewLine);

            txtTitle.Text = txtAuthor.Text = txtTotalCopies.Text = txtDescription.Text = "";
            LoadBooks();
        }

        protected void btnExportPDF_Click(object sender, EventArgs e)
        {
            string selectedFilter = ddlFilter.SelectedValue;
            string sourceFile = (selectedFilter == "all" || !File.Exists(filterFilePath)) ? filePath : filterFilePath;

            var books = File.ReadAllLines(sourceFile)
                            .Where(line => !string.IsNullOrWhiteSpace(line))
                            .Select(line => line.Split(','))
                            .Select(parts => new Book
                            {
                                BookID = parts[0],
                                Title = parts[1],
                                Author = parts[2],
                                TotalCopies = int.Parse(parts[3]),
                                AvailableCopies = int.Parse(parts[4]),
                                Status = parts[5],
                                Description = parts.Length > 7 ? parts[7] : "No Description"
                            }).ToList();

            if (!books.Any())
            {
                Response.Write("<script>alert('No data available to export.');</script>");
                return;
            }

            string pdfPath = Path.GetTempPath() + "BooksList.pdf";

            using (PdfWriter writer = new PdfWriter(pdfPath))
            using (PdfDocument pdf = new PdfDocument(writer))
            using (Document document = new Document(pdf))
            {
                document.Add(new Paragraph("Library Books List")
                    .SetFontSize(20)
                    .SetTextAlignment(iText.Layout.Properties.TextAlignment.CENTER));
                document.Add(new Paragraph("\n"));

                iText.Layout.Element.Table table = new iText.Layout.Element.Table(new float[] { 1, 3, 3, 2, 2, 3 }).UseAllAvailableWidth();
                table.AddHeaderCell(new Cell().Add(new Paragraph("Book ID").SetBackgroundColor(ColorConstants.LIGHT_GRAY)));
                table.AddHeaderCell(new Cell().Add(new Paragraph("Title").SetBackgroundColor(ColorConstants.LIGHT_GRAY)));
                table.AddHeaderCell(new Cell().Add(new Paragraph("Author").SetBackgroundColor(ColorConstants.LIGHT_GRAY)));
                table.AddHeaderCell(new Cell().Add(new Paragraph("Total Copies").SetBackgroundColor(ColorConstants.LIGHT_GRAY)));
                table.AddHeaderCell(new Cell().Add(new Paragraph("Available Copies").SetBackgroundColor(ColorConstants.LIGHT_GRAY)));
                table.AddHeaderCell(new Cell().Add(new Paragraph("Description").SetBackgroundColor(ColorConstants.LIGHT_GRAY)));

                foreach (var book in books)
                {
                    table.AddCell(book.BookID);
                    table.AddCell(book.Title);
                    table.AddCell(book.Author);
                    table.AddCell(book.TotalCopies.ToString());
                    table.AddCell(book.AvailableCopies.ToString());
                    table.AddCell(book.Description);
                }

                document.Add(table);
            }

            Response.ContentType = "application/pdf";
            Response.AppendHeader("Content-Disposition", "attachment; filename=BooksList.pdf");
            Response.TransmitFile(pdfPath);
            Response.End();
        }

        protected void gvBooks_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditBook") // تعديل الكتاب
            {
                string bookID = e.CommandArgument.ToString();

                if (!string.IsNullOrEmpty(bookID))
                {
                    Response.Redirect($"EditBook.aspx?BookID={bookID}");
                }
                else
                {
                    Response.Write("<script>alert('Error: Book ID is missing!');</script>");
                }
            }
            else if (e.CommandName == "DeleteBook") // حذف الكتاب
            {
                string bookID = e.CommandArgument.ToString();

                if (!string.IsNullOrEmpty(bookID))
                {
                    DeleteBook(bookID);
                    ClientScript.RegisterStartupScript(this.GetType(), "successAlert",
                   "Swal.fire({ title: 'Success!', text: 'Book Deleted successfully!', icon: 'success', draggable: true });", true);
                }
                else
                {
                    Response.Write("<script>alert('Error: Book ID is missing!');</script>");
                }
            }
        }

        // دالة لحذف الكتاب من ملف الـ TXT
        private void DeleteBook(string bookID)
        {
            if (File.Exists(filePath))
            {
                var lines = File.ReadAllLines(filePath).Where(line => !line.StartsWith(bookID + ",")).ToList();
                File.WriteAllLines(filePath, lines);
                ShowSweetAlert("Deleted!", "Book deleted successfully.", "success");

                LoadBooks();
            }
            else
            {
                Response.Write("<script>alert('Error: File not found!');</script>");


            }
        }

        private class Book
        {
            public string BookID { get; set; }
            public string Title { get; set; }
            public string Author { get; set; }
            public int TotalCopies { get; set; }
            public int AvailableCopies { get; set; }
            public string Status { get; set; }
            public string ImagePath { get; set; }
            public string Description { get; set; }
        }

        private void ShowSweetAlert(string title, string message, string icon)
        {
            string script = $"Swal.fire({{title: '{title}', text: '{message}', icon: '{icon}', timer: 2000, showConfirmButton: false }});";
            //ScriptManager.RegisterStartupScript(this, GetType(), "SweetAlert", script, true);
        }



    }
}