using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace library.Sofyan
{
    public partial class ContactUs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) // تنفيذ الكود مرة واحدة عند تحميل الصفحة
            {
                string filePath = Server.MapPath("~/App_Data/loggedInUser.txt");

                if (File.Exists(filePath))
                {
                    string email = File.ReadAllText(filePath).Trim(); // قراءة البريد الإلكتروني

                    if (!string.IsNullOrEmpty(email))
                    {
                        // المستخدم مسجل دخولًا، إظهار زر "Logout" وإخفاء "Login" و "Register"
                        btnLogin.Visible = false;
                        btnRegister.Visible = false;
                        btnLogout.Visible = true;
                        profile.Visible = true;
                        return;
                    }
                }

                // المستخدم غير مسجل، إظهار زرّي "Login" و "Register"، وإخفاء "Logout"
                btnLogin.Visible = true;
                btnRegister.Visible = true;
                btnLogout.Visible = false;
                profile.Visible = false;

            }
        }

        protected void lnkHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("index.aspx");
        }

        protected void lnkMenu_Click(object sender, EventArgs e)
        {
            Response.Redirect("Menu.aspx");
        }

        protected void lnkBooking_Click(object sender, EventArgs e)
        {
            string filePath = Server.MapPath("~/App_Data/loggedInUser.txt");

            if (File.Exists(filePath))
            {
                string email = File.ReadAllText(filePath).Trim(); // قراءة البريد الإلكتروني

                if (!string.IsNullOrEmpty(email))
                {
                    // المستخدم مسجل دخولًا، نقله إلى الصفحة الرئيسية
                    Response.Redirect("~/saja/ReserveRoom.aspx");
                    return;
                }
            }

            // إذا لم يتم العثور على الإيميل، نقل المستخدم إلى صفحة تسجيل الدخول
            Response.Redirect("LoginUser.aspx");
        }

        protected void lnkAbout_Click(object sender, EventArgs e)
        {
            Response.Redirect("AboutUs.aspx");
        }

        protected void lnkContact_Click(object sender, EventArgs e)
        {
            Response.Redirect("ContactUs.aspx");
        }

        protected void lnkLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginUser.aspx");
        }

        protected void lnkRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string name = txtName.Text;
            string email = txtEmail.Text;
            string message = txtMessage.Text;

            // تنفيذ عمليات مثل حفظ البيانات أو إرسال بريد إلكتروني
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginUser.aspx");
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            string filePath = Server.MapPath("~/App_Data/loggedInUser.txt");

            if (File.Exists(filePath))
            {
                File.WriteAllText(filePath, string.Empty);
            }
            Response.Redirect("LoginUser.aspx");
        }

        protected void profile_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Sura/profilePage.aspx");
        }

        protected void lnkBorrowBook_Click(object sender, EventArgs e)
        {
            string filePath = Server.MapPath("~/App_Data/loggedInUser.txt");

            if (File.Exists(filePath))
            {
                string email = File.ReadAllText(filePath).Trim(); // قراءة البريد الإلكتروني

                if (!string.IsNullOrEmpty(email))
                {
                    // المستخدم مسجل دخولًا، نقله إلى الصفحة الرئيسية
                    Response.Redirect("~/Abdullah/BorrowBooks.aspx");
                    return;
                }
            }

            // إذا لم يتم العثور على الإيميل، نقل المستخدم إلى صفحة تسجيل الدخول
            Response.Redirect("LoginUser.aspx");
        }
    }
}