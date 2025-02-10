<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PendingRequestsRooms.aspx.cs" Inherits="library.PendingRequestsRooms" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin - Manage Reservations</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <style>
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
        .menu-button {
            display: block;
            width: 90%;
            margin: 10px auto;
            padding: 10px;
            background: #495057;
            color: white;
            border: none;
            text-align: center;
            cursor: pointer;
        }
        .menu-button:hover {
            background: #6c757d;
        }
        .container {
            margin-left: 270px;
            padding-top: 20px;
        }
        .table {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .table thead {
            background: #343a40;
            color: white;
            font-weight: bold;
            text-align: center;
        }
        .table tbody tr:hover {
            background: #f8f9fa;
        }
        .btn-approve {
            background: #34495e;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
        }
        .btn-approve:hover {
            background: #218838;
        }
        .btn-reject {
            background: #34495e;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
        }
        .btn-reject:hover {
            background: #c82333;
        }
        .alert {
            margin-top: 15px;
            font-size: 16px;
            font-weight: bold;
            text-align: center;
        }
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

        <div class="container">
            <h2 class="mb-4">Pending Reservation Requests</h2>
            <asp:GridView ID="gvPendingRequests" runat="server" AutoGenerateColumns="False" CssClass="table table-hover table-bordered text-center" OnRowCommand="gvPendingRequests_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Room" HeaderText="Room" SortExpression="Room" />
                    <asp:BoundField DataField="FullName" HeaderText="Name" SortExpression="FullName" />
                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                    <asp:BoundField DataField="ReservationDate" HeaderText="Date" SortExpression="ReservationDate" />
                    <asp:BoundField DataField="ReservationTime" HeaderText="Time" SortExpression="ReservationTime" />
                    <asp:BoundField DataField="SnackAndPrice" HeaderText="Snack" SortExpression="SnackAndPrice" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button CssClass="btn btn-approve" runat="server" Text="Approve" CommandName="Approve" CommandArgument='<%# Container.DataItemIndex %>' />
                            <asp:Button CssClass="btn btn-reject ml-2" runat="server" Text="Reject" CommandName="Reject" CommandArgument='<%# Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <hr />

            <h2 class="mb-4">Approved Reservation Requests</h2>
            <asp:GridView ID="gvApprovedRequests" runat="server" AutoGenerateColumns="False" CssClass="table table-hover table-bordered text-center">
                <Columns>
                    <asp:BoundField DataField="Room" HeaderText="Room" />
                    <asp:BoundField DataField="FullName" HeaderText="Name" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="ReservationDate" HeaderText="Date" />
                    <asp:BoundField DataField="ReservationTime" HeaderText="Time" />
                    <asp:BoundField DataField="SnackAndPrice" HeaderText="Snack" />
                </Columns>
            </asp:GridView>

            <asp:Label ID="lblAdminMessage" runat="server" CssClass="alert alert-info d-block"></asp:Label>
        </div>
    </form>
</body>
</html>
