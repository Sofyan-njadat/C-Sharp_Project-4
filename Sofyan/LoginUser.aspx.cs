using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace library.Sofyan
{
    public partial class LoginUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            string usersFilePath = HttpContext.Current.Server.MapPath("~/App_Data/users.txt");
            string loggedInFilePath = HttpContext.Current.Server.MapPath("~/App_Data/loggedInUser.txt");

            // التحقق من وجود ملف المستخدمين
            if (File.Exists(usersFilePath))
            {
                var users = File.ReadAllLines(usersFilePath);
                foreach (var user in users)
                {
                    var parts = user.Split(',');
                    if (parts.Length >= 2 && parts[2] == email && parts[4] == password)
                    {
                        // تسجيل البريد الإلكتروني في ملف
                        File.WriteAllText(loggedInFilePath, email);


                        Response.Redirect("index.aspx");
                        return;
                    }
                }
            }

            // إذا كانت بيانات الدخول غير صحيحة
            Response.Write("<script>alert('Invalid email or password.');</script>");
        }

        protected void btnLoginAdmin_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/AhmadAndali/loginadmin.aspx");
        }
    }
}