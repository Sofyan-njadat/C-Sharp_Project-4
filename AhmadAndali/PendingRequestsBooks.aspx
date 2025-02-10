<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PendingRequestsBooks.aspx.cs" Inherits="library.Pending_Requests" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Pending Book Requests</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>

body {
          font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
          background: #f9f9f9;
          margin: 0;
          padding: 20px;
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


          @media (max-width: 768px) {
    .sidebar {
        transform: translateX(0);
    }

    .main-content {
        margin-left: 0;
    }
}

@media (max-width: 425px) {
    .toggle-button {
        padding: 8px 12px;
        font-size: 14px;
        top: 5px;
        left: 5px;
    }

    .sidebar {
        width: 200px;
        padding-top: 15px;
    }

        .sidebar h2 {
            font-size: 18px;
        }

    .card {
        max-width: 90%;
    }
}

      .container {
          max-width: 900px;
          margin: auto;
          background: white;
          padding: 20px;
          border-radius: 10px;
          box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
      }

      .btn-approve {
          background-color: #34495e;
          color: white;
          border: none;
          padding: 5px 10px;
          border-radius: 5px;
          cursor: pointer;
      }

      .btn-reject {
          background-color: #34495e;
          color: white;
          border: none;
          padding: 5px 10px;
          border-radius: 5px;
          cursor: pointer;
      }

      h2 {
          text-align: center;
          color: #2c3e50;
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
            <h2>Pending Book Requests</h2>
            
            <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-warning" Visible="false"></asp:Label>

            <asp:GridView ID="gvPendingRequests" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered"
                OnRowCommand="gvPendingRequests_RowCommand">
                <Columns>
                    <asp:BoundField DataField="BookTitle" HeaderText="Book Title" />
                    <asp:BoundField DataField="UserEmail" HeaderText="User Email" />
                    <asp:BoundField DataField="BorrowDate" HeaderText="Borrow Date" />
                    <asp:BoundField DataField="ReturnDate" HeaderText="Return Date" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnApprove" runat="server" CssClass="btn-approve" Text="Approve"
                                CommandName="Approve" CommandArgument='<%# Container.DataItemIndex %>' />
                            <asp:Button ID="btnReject" runat="server" CssClass="btn-reject" Text="Reject"
                                CommandName="Reject" CommandArgument='<%# Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <h2>Approved Requests</h2>
            <asp:GridView ID="gvApprovedRequests" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered">
                <Columns>
                    <asp:BoundField DataField="BookTitle" HeaderText="Book Title" />
                    <asp:BoundField DataField="UserEmail" HeaderText="User Email" />
                    <asp:BoundField DataField="BorrowDate" HeaderText="Borrow Date" />
                    <asp:BoundField DataField="ReturnDate" HeaderText="Return Date" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
