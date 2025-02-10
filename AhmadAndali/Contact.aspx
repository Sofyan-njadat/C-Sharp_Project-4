<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="library.Contact" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Contact Us</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-image: url('https://source.unsplash.com/1600x900/?library');
            background-size: cover;
            background-position: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .container {
            max-width: 500px;
            margin: 50px auto;
            background: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .btn-submit {
            background-color: #2c3e50;
            color: white;
            padding: 10px;
            border: none;
            width: 100%;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-submit:hover {
            background-color: #34495e;
        }
        .reply-container {
            margin-top: 20px;
            padding: 10px;
            background: #f8f9fa;
            border-left: 4px solid #2c3e50;
            border-radius: 5px;
        }
        .reply-container h5 {
            color: #2c3e50;
            font-size: 14px;
        }
        .reply-container p {
            font-size: 12px;
            margin-bottom: 0;
            color: #555;
        }


        
          margin: 0;
          padding: 0;
          box-sizing: border-box;}

        body {
            font-family: Arial, sans-serif;
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            background-color: #fff;
            border-bottom: 1px solid #ddd;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .logo img {
            width: 30px;
            height: 30px;
        }

        .logo h1 {
            font-size: 20px;
            font-weight: bold;
            color: #333;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .nav-links a {
            text-decoration: none;
            color: #333;
            font-size: 16px;
        }

        .buttons {
            display: flex;
            gap: 10px;
        }

        .buttons button {
            border: 1px solid #333;
            background: transparent;
            padding: 5px 10px;
            cursor: pointer;
            font-size: 16px;
            border-radius: 5px;
            transition: all 0.3s;
        }

        .buttons button:hover {
            background-color: #333;
            color: #fff;
        }

        @media (max-width: 425px) {
            nav {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .nav-links {
                flex-direction: column;
                gap: 10px;
                width: 100%;
                text-align: left;
            }

            .buttons {
                width: 100%;
                justify-content: flex-start;
                gap: 10px;
            }

            .buttons button {
                flex: 1;
            }
        }
    </style>
</head>
<body>

    <nav>
            <div class="logo">
                <img src="./logoW01.png" alt="Logo" style =" width:80px;  height:70px;">
                <h1>Lumen</h1>
            </div>
            <div class="nav-links">
  <asp:HyperLink NavigateUrl="~/Sofyan/index.aspx" ID="HOME"   runat="server" Text="Home" class="aa" CssClass="nav-link"  ></asp:HyperLink>
  <asp:HyperLink NavigateUrl="~/Abdullah/BorrowBooks.aspx"  runat ="server" Text ="BOOK" class="aa" CssClass="nav-link"></asp:HyperLink>
  <asp:HyperLink NavigateUrl="~/saja/ReserveRoom.aspx" ID="Book" runat ="server" Text="Room" class="aa" CssClass="nav-link"></asp:HyperLink>
  <asp:HyperLink NavigateUrl="~/Sofyan/AboutUs.aspx" ID="ABOUT" runat="server" Text="About" class="aa" CssClass="nav-link"></asp:HyperLink>
  <asp:HyperLink NavigateUrl="~/Sofyan/ContactUs.aspx" ID="CONTACT" runat="server" Text="Contact" class="aa" CssClass="nav-link"></asp:HyperLink>
  <asp:HyperLink NavigateUrl="~/AhmadAndali/Contact.aspx" ID="HyperLink1" runat="server" Text="Chat With Admin" class="aa" CssClass="nav-link"></asp:HyperLink>
  <asp:HyperLink NavigateUrl="~/Sura/profilePage.aspx" ID="HyperLink2" runat="server" Text="Profile" class="aa" CssClass="nav-link"></asp:HyperLink>

            </div>
         <%--   <div class="buttons">
                <asp:Button Text="Logout" CssClass="button" runat="server" />
                <asp:Button Text="Profile" CssClass="button" runat="server" />
            </div>--%>
        </nav>
    <form id="form1" runat="server">
        <div class="container">
            <h2 class="text-center">Contact Us</h2>

            <div class="form-group">
                <label>Email:</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Message:</label>
                <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
            </div>

            <asp:Button ID="btnSendMessage" runat="server" Text="Send Message" CssClass="btn-submit" OnClick="btnSendMessage_Click" />
            <asp:Label ID="lblStatus" runat="server" CssClass="text-success mt-2"></asp:Label>

            <!-- عرض الردود من الأدمن -->
            <asp:Repeater ID="rptReplies" runat="server">
                <ItemTemplate>
                    <div class="reply-container">
                        <h5>📩 Admin Reply:</h5>
                        <p><strong>Date:</strong> <%# Eval("ReplyDate") %></p>
                        <p><strong>Message:</strong> <%# Eval("Reply") %></p>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </form>
</body>
</html>