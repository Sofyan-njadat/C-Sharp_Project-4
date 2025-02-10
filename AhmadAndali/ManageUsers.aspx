<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="ProjectWebforms.Ahmad.ManageUsers" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Users</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f9f9f9;
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
        .menu-button:hover { background: #CCE0C5; color: black; }
        .active { background: #CCE0C5; color: black; font-weight: bold; }
        .main-content { margin-left: 260px; padding: 20px; }
        .btn { padding: 10px 20px; background-color: #34495e; color: #CCE0C5; border: none; }
        .btn:hover { background-color: #CCE0C5; color: black; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
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

        <div class="main-content">
            <h2>Manage Users</h2>

            <div class="form-group">
                <asp:TextBox ID="txtUserSearch" runat="server" CssClass="form-control" Placeholder="Search by Name or Email"></asp:TextBox>
                <asp:Button ID="btnSearchUser" runat="server" Text="Search" CssClass="btn mt-2" OnClick="btnSearchUser_Click" />
            </div>

            <div class="table-container">
                <h4>Registered Users</h4>
                <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered">
                    <Columns>
                        <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                        <asp:BoundField DataField="LastName" HeaderText="Last Name" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:BoundField DataField="Phone" HeaderText="Phone" />
                        <asp:BoundField DataField="Bookings" HeaderText="Bookings" />
                        <asp:BoundField DataField="Delays" HeaderText="Delays" />
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:Button ID="btnWarnUser" runat="server" Text="Warn" CssClass="btn btn-warning" OnClick="btnWarnUser_Click" CommandArgument='<%# Eval("Email") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <h4>Blacklisted Users</h4>
            <asp:GridView ID="gvBlacklistedUsers" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered">
                <Columns>
                    <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                    <asp:BoundField DataField="LastName" HeaderText="Last Name" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="Phone" HeaderText="Phone" />
                    <asp:BoundField DataField="Delays" HeaderText="Delays" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnRestoreUser" runat="server" Text="Restore User" CssClass="btn btn-success" OnClick="btnRestoreUser_Click" CommandArgument='<%# Eval("Email") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <!-- زر تحميل المستخدمين بصيغة PDF -->
            <div class="mt-4">
                <asp:Button ID="btnExportUsersPDF" runat="server" Text="Download Users as PDF" CssClass="btn btn-primary" OnClick="btnExportUsersPDF_Click" />
            </div>

        </div>
    </form>
</body>
</html>
