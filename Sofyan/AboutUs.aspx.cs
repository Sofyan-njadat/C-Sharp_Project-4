using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace library.Sofyan
{
    public partial class AboutUs : System.Web.UI.Page
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




        protected void btnLogout_Click(object sender, EventArgs e)
        {
            string filePath = Server.MapPath("~/App_Data/loggedInUser.txt");

            if (File.Exists(filePath))
            {
                File.Delete(filePath); // حذف ملف الجلسة
            }

            // إعادة تحميل الصفحة لإظهار "Login" و "Register"
            Response.Redirect("AboutUs.aspx");
        }





        // Event handler for lnkHome Click
        protected void lnkHome_Click(object sender, EventArgs e)
        {
            // Handle home click action
            Response.Redirect("index.aspx");
        }

        // Event handler for lnkAboutUs Click
        protected void lnkAboutUs_Click(object sender, EventArgs e)
        {
            // Handle the About Us link click
            Response.Redirect("AboutUs.aspx");
        }

        // Event handler for lnkAbout Click1
        protected void lnkAbout_Click1(object sender, EventArgs e)
        {
            // Handle menu click action
            Response.Redirect("Menu.aspx");
        }

        // Event handler for lnkContact Click
        protected void lnkContact_Click(object sender, EventArgs e)
        {
            // Handle contact click action
            Response.Redirect("ContactUs.aspx");
        }

        // Event handler for lnkBookRoom Click
        protected void lnkBookRoom_Click(object sender, EventArgs e)
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

        // Event handler for lnkBorrowBook Click
        protected void lnkBorrowBook_Click(object sender, EventArgs e)
        {
            // Handle Borrow a Book click action
            Response.Redirect("~/Abdullah/BorrowBooks.aspx");
        }

        // Event handler for lnkLogin Click
        protected void lnkLogin_Click(object sender, EventArgs e)
        {
            // Handle login action, e.g., redirect to login page
            Response.Redirect("Login.aspx");
        }

        // Event handler for lnkRegister Click1
        protected void lnkRegister_Click1(object sender, EventArgs e)
        {
            // Handle register action, e.g., redirect to registration page
            Response.Redirect("Register.aspx");
        }

        protected void profile_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginUser.aspx");

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");

        }

        protected void btnLogout_Click1(object sender, EventArgs e)
        {
            string filePath = Server.MapPath("~/App_Data/loggedInUser.txt");

            if (File.Exists(filePath))
            {
                File.WriteAllText(filePath, string.Empty);
            }
            Response.Redirect("LoginUser.aspx");
        }
    }
}