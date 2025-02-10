using System;
using System.IO;
using System.Web;

namespace library
{
    public partial class Register : System.Web.UI.Page
    {
        private string filePath = HttpContext.Current.Server.MapPath("~/App_Data/users.txt");

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // التحقق من مطابقة كلمة المرور
            if (txtPassword.Text != txtConfirmPassword.Text)
            {
                Response.Write("<script>alert('Passwords do not match.');</script>");
                return;
            }

            // إنشاء الملف إذا لم يكن موجودًا
            if (!File.Exists(filePath))
            {
                File.Create(filePath).Close();
            }

            // إعداد بيانات المستخدم
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string password = txtPassword.Text.Trim();

            // تخزين البيانات في الملف
            string userData = $"{firstName},{lastName},{email},{phone},{password}";
            File.AppendAllText(filePath, userData + Environment.NewLine);

            // إعادة تعيين الحقول بعد التسجيل
            txtFirstName.Text = txtLastName.Text = txtEmail.Text = txtPhone.Text = txtPassword.Text = txtConfirmPassword.Text = "";


            Response.Redirect("LoginUser.aspx");
        }
    }
}
