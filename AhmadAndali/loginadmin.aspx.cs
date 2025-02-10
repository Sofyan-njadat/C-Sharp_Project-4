using System;
using System.IO;
using System.Web;
using System.Web.UI;

namespace library
{
    public partial class loginadmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string filePath = Server.MapPath("~/App_Data/admins.txt");

            if (!File.Exists(filePath))
            {
                lblMessage.Text = "Error: Admin data file is missing!";
                return;
            }

            string[] lines = File.ReadAllLines(filePath);
            bool isAuthenticated = false;

            foreach (string line in lines)
            {
                string[] parts = line.Split(',');
                if (parts.Length == 2)
                {
                    string storedEmail = parts[0].Trim();
                    string storedPassword = parts[1].Trim();

                    if (txtEmail.Text.Trim() == storedEmail && txtPassword.Text.Trim() == storedPassword)
                    {
                        isAuthenticated = true;
                        break;
                    }
                }
            }

            if (isAuthenticated)
            {
                Session["AdminEmail"] = txtEmail.Text;
                Response.Redirect("AdminDashboard.aspx");
            }
            else
            {
                lblMessage.Text = "Invalid login credentials!";
            }
        }

        protected void btnLoginAdmin_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/AdminDashboard.aspx");
        }

       
    }
}

