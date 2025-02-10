<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Notifications.aspx.cs" Inherits="library.Notifications" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Notifications</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f4f4;
        }
       .sidebar {
      width: 250px;
      background: #000000;
      color: #E4E4E4;
      position: fixed;
      height: 100vh;
      padding-top: 20px;
      text-align: center;
      transition: transform 0.3s ease;
      z-index: 1000;
  }

      .sidebar.hidden {
          transform: translateX(-100%);
      }

      .sidebar h2 {
          color: #CCE0C5;
          margin-bottom: 20px;
      }

      .sidebar .menu-button {
          display: block;
          width: 90%;
          background: #464646;
          color: #CCE0C5;
          border: none;
          border-radius: 5px;
          padding: 10px;
          margin: 10px auto;
          font-size: 16px;
          text-align: left;
          cursor: pointer;
          transition: background 0.3s;
      }

          .sidebar .menu-button:hover {
              background: #CCE0C5;
              color: #000000;
          }
        .content {
            margin-left: 260px;
            padding: 20px;
        }
        .notification-card {
            background: white;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 15px;
        }
        .reply-section {
            margin-top: 15px;
        }
        .reply {
            background: #e9f7ef;
            padding: 10px;
            border-left: 4px solid #28a745;
            margin-top: 10px;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Sidebar -->
        <div class="sidebar">
     <h2>Library Admin</h2>
     <asp:Button CssClass="menu-button" runat="server" Text="Home" PostBackUrl="AdminDashboard.aspx" />
     <asp:Button CssClass="menu-button" runat="server" Text="Manage Books" PostBackUrl="ManageBooks.aspx" />
     <asp:Button CssClass="menu-button" runat="server" Text="Manage Rooms" PostBackUrl="ManageRooms.aspx" />
     <asp:Button CssClass="menu-button" runat="server" Text="Notifications" PostBackUrl="Notifications.aspx" />
     <asp:Button CssClass="menu-button" runat="server" Text="Pending Requests Books" PostBackUrl="PendingRequestsBooks.aspx" />
     <asp:Button CssClass="menu-button" runat="server" Text="Pending Requests Rooms" PostBackUrl="PesndingRequestsRooms.aspx" />
     <asp:Button CssClass="menu-button" runat="server" Text="Manage Users" PostBackUrl="ManageUsers.aspx" />
     <asp:Button CssClass="menu-button" runat="server" Text="Logout" PostBackUrl="loginadmin.aspx" />
 </div>

        <!-- Main Content -->
        <div class="content">
            <h2>Notifications</h2>
            <asp:Repeater ID="rptNotifications" runat="server">
                <ItemTemplate>
                    <div class="notification-card">
                        <h5>  From: (<%# Eval("UserEmail") %>)</h5>
                        <p><b>Message:</b> <%# Eval("Message") %></p>
                        <p><small><b>Sent:</b> <%# Eval("DateSent") %></small></p>

                        <!-- Admin Reply Section -->
                        <asp:Panel ID="pnlReply" runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("Reply").ToString()) %>'>
                            <div class="reply">
                                <b>Admin Reply:</b> <%# Eval("Reply") %>
                                <br />
                                <small><b>Reply Date:</b> <%# Eval("ReplyDate") %></small>
                            </div>
                        </asp:Panel>

                        <!-- Reply Input Section -->
                        <div class="reply-section" id="replySection_<%# Eval("ID") %>">
                            <asp:TextBox ID="txtReply" runat="server" CssClass="form-control" Placeholder="Write your reply..."></asp:TextBox>
                            <br />
                            <asp:Button ID="btnSendReply" runat="server" CssClass="btn btn-success btn-sm" Text="Send Reply"
                                CommandArgument='<%# Eval("ID") %>' OnClick="SendReply_Click" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </form>
</body>
</html>
