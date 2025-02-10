<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginUser.aspx.cs" Inherits="library.Sofyan.LoginUser" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Library</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('https://aue.ae/wp-content/uploads/2022/07/library_gn.jpg') no-repeat center center fixed;
            background-size: cover;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .form-container {
            background-color: rgba(255, 255, 255, 0.95);
            padding: 20px 30px;
            border-radius: 10px;
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
            width: 400px;
        }

        .form-container h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            font-size: 14px;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
            display: block;
        }

        .form-control {
            border-radius: 5px;
            border: 1px solid #ccc;
            height: 40px;
        }

        .btn-register {
            background-color: #2c3e50;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px;
            width: 100%;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-register:hover {
            background-color: #34495e;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h2>Library Registration</h2>
            <asp:Panel runat="server">
                <div class="form-group">
                    <label for="txtEmail">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" required></asp:TextBox>
                </div>
               
                <div class="form-group">
                    <label for="txtPassword">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" required></asp:TextBox>
                </div>
                <asp:Button ID="btnLogin" runat="server" CssClass="btn-register" Text="Login" OnClick="btnLogin_Click" />
                <br>
                <br>
                <asp:HyperLink NavigateUrl="~/Sofyan/Register.aspx" ID="HyperLink1" runat="server" Text="Register" class="aa" CssClass="nav-link"></asp:HyperLink>

                <asp:HyperLink NavigateUrl="~/AhmadAndali/loginadmin.aspx" ID="CONTACT" runat="server" Text="Login Admin" class="aa" CssClass="nav-link"></asp:HyperLink>

            </asp:Panel>
        </div>
    </form>
</body>
</html>
