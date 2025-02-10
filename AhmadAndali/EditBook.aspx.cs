using System;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace library
{
    public partial class EditBook : Page
    {
        // مسار ملف الكتب
        private string filePath = HttpContext.Current.Server.MapPath("~/App_Data/books.txt");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // التحقق من وجود BookID في رابط الاستعلام
                if (Request.QueryString["BookID"] != null)
                {
                    string bookID = Request.QueryString["BookID"];
                    LoadBookDetails(bookID);
                }
            }
        }

        // تحميل بيانات الكتاب
        private void LoadBookDetails(string bookID)
        {
            string[] lines = File.ReadAllLines(filePath);

            foreach (string line in lines)
            {
                string[] data = line.Split(',');

                // التحقق من وجود بيانات كافية في السطر
                if (data.Length >= 6 && data[0] == bookID)
                {
                    txtBookID.Text = data[0];
                    txtTitle.Text = data[1];
                    txtAuthor.Text = data[2];
                    txtTotalCopies.Text = data[3];

                    // إذا كان الوصف موجودًا في السطر، قم بتحميله، وإلا اتركه فارغًا
                    txtDescription.Text = data.Length > 7 ? data[7] : "";
                    break;
                }
            }
        }

        // معالجة حفظ التعديلات
        protected void btnUpdateBook_Click(object sender, EventArgs e)
        {
            string bookID = txtBookID.Text;
            string title = txtTitle.Text;
            string author = txtAuthor.Text;
            string description = txtDescription.Text; // يمكن أن يكون فارغًا
            int totalCopies = int.TryParse(txtTotalCopies.Text, out int copies) ? copies : 0;

            string[] lines = File.ReadAllLines(filePath);

            for (int i = 0; i < lines.Length; i++)
            {
                string[] data = lines[i].Split(',');
                if (data[0] == bookID)
                {
                    // تعديل السطر مع التأكد من وجود الوصف
                    string updatedDescription = !string.IsNullOrEmpty(description) ? description : "";
                    lines[i] = $"{bookID},{title},{author},{totalCopies},{totalCopies},available,{data[6]},{updatedDescription}";
                    break;
                }
            }
            ClientScript.RegisterStartupScript(this.GetType(), "successAlert",
                   "Swal.fire({ title: 'Success!', text: 'Room added successfully!', icon: 'success', draggable: true });", true);
            // حفظ التعديلات في الملف
            File.WriteAllLines(filePath, lines);

            // إعادة التوجيه إلى صفحة إدارة الكتب
            Response.Redirect("ManageBooks.aspx");

        }
    }
}
