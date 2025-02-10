<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageRooms.aspx.cs" Inherits="library.ManageRooms" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Rooms</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #E4E4E4;
            margin: 0;
            padding: 0;
        }
              body {
          font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
          background-color: #f9f9f9;
          margin: 0;
          padding: 0;
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
      .main-content {
          margin-left: 260px;
          padding: 20px;
      }
      h2 {
          color: #2c3e50;
          margin-bottom: 20px;
      }
      .form-group {
          margin-bottom: 15px;
      }
      .form-group label {
          display: block;
          margin-bottom: 5px;
          font-weight: bold;
          color: #34495e;
      }
      .form-group input,
      .form-group .form-control {
          width: 100%;
          padding: 10px;
          border: 1px solid #ccc;
          border-radius: 5px;
      }
      .btn {
          padding: 10px 20px;
          background-color: #34495e;
          color: #CCE0C5;
          border: none;
          border-radius: 5px;
          cursor: pointer;
      }
      .btn:hover {
          background-color: #CCE0C5;
          color: black;
      }
      table {
          width: 100%;
          border-collapse: collapse;
          margin-top: 20px;
          background: white;
          border-radius: 8px;
          overflow: hidden;
          box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
      }
      table, th, td {
          border: 1px solid #ccc;
      }
      th {
          background-color: #34495e;
          color: white;
          padding: 10px;
      }
      td {
          padding: 10px;
          text-align: center;
      }
      .filter {
          display: flex;
          flex-wrap: wrap;
          gap: 10px;
          margin-bottom: 20px;
      }
      .filter input,
      .filter select {
          padding: 8px;
          border: 1px solid #ccc;
          border-radius: 5px;
          flex: 1;
      }
      @media (max-width: 768px) {
          .sidebar {
              width: 100%;
              height: auto;
              position: relative;
          }
          .main-content {
              margin-left: 0;
              padding: 10px;
          }
          table {
              font-size: 12px;
          }
      }
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }
        .btn {
            padding: 10px 20px;
            background-color:  #2c3e50;
            color: #CCE0C5;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease-in-out;
        }
        .btn:hover {
            background-color: #CCE0C5;
            color: #000;
        }
        /* تحسين زر الحذف */
        .btn-delete {
            background-color:  #2c3e50;
            color: white;
        }
        .btn-delete:hover {
            background-color: #CCE0C5;
        }
        /* تحسين زر التعديل */
        .btn-edit {
            background-color:  ;
            color: white;
        }
        .btn-edit:hover {
            background-color: #CCE0C5;
        }
        /* تحسين الجدول */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #464646;
            color: #CCE0C5;
        }
        /* تحسين النافذة المنبثقة */
        .popup, .overlay {
            display: none;
            position: fixed;
            z-index: 1000;
        }
        .overlay {
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.5);
        }
        .popup {
            top: 50%; left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
            width: 300px;
            text-align: center;
        }
        .popup h3 {
            margin-bottom: 15px;
        }
        .popup input, .popup select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
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

        <div class="main-content">
            <h2>Manage Rooms</h2>

            <!-- إضافة غرفة جديدة -->
            <div class="form-group">
                <label>Room Name:</label>
                <asp:TextBox ID="txtRoomName" runat="server"></asp:TextBox>
            </div>
            <asp:Button ID="btnAddRoom" runat="server" Text="Add Room" CssClass="btn" OnClick="btnAddRoom_Click" />

            <!-- خيارات التصفية والبحث -->
            <div class="filter">
                <asp:DropDownList ID="ddlRoomFilter" runat="server">
                    <asp:ListItem Text="All Rooms" Value="all" />
                    <asp:ListItem Text="Available Rooms" Value="available" />
                    <asp:ListItem Text="Reserved Rooms" Value="reserved" />
                </asp:DropDownList>
                <asp:TextBox ID="txtRoomSearch" runat="server" Placeholder="Search by Name or ID"></asp:TextBox>
                <asp:Button ID="btnSearchRoom" runat="server" Text="Search" CssClass="btn" OnClick="btnSearchRoom_Click" />
                <asp:Button ID="btnRoomFilter" runat="server" Text="Apply Filter" CssClass="btn" OnClick="btnRoomFilter_Click" />
            </div>

            <!-- جدول الغرف مع أزرار التعديل والحذف -->
            <asp:GridView ID="gvRooms" runat="server" AutoGenerateColumns="False" OnRowCommand="gvRooms_RowCommand">
                <Columns>
                    <asp:BoundField DataField="RoomID" HeaderText="Room ID" />
                    <asp:BoundField DataField="Name" HeaderText="Room Name" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button runat="server" Text="Edit" CssClass="btn btn-edit" CommandName="EditRoom" CommandArgument='<%# Eval("RoomID") %>' />
                           <asp:Button runat="server" Text="Delete" CssClass="btn btn-delete" 
            CommandName="DeleteRoom" CommandArgument='<%# Eval("RoomID") %>' />

                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <!-- نافذة تعديل الغرفة -->
            <div id="overlay" class="overlay" runat="server"></div>
            <div id="popupEdit" class="popup" runat="server">
                <h3>Edit Room</h3>
                <asp:HiddenField ID="hfRoomID" runat="server" />
                <label>Room Name:</label>
                <asp:TextBox ID="txtEditRoomName" runat="server"></asp:TextBox>
                <label>Status:</label>
                <asp:DropDownList ID="ddlEditRoomStatus" runat="server">
                    <asp:ListItem Text="Available" Value="available" />
                    <asp:ListItem Text="Reserved" Value="reserved" />
                </asp:DropDownList>
                <asp:Button ID="btnSaveChanges" runat="server" Text="Save Changes" CssClass="btn btn-edit" OnClick="btnSaveChanges_Click" />
                <asp:Button ID="btnClosePopup" runat="server" Text="Cancel" CssClass="btn btn-delete" 
                            OnClientClick="document.getElementById('popupEdit').style.display='none'; document.getElementById('overlay').style.display='none'; return false;" />
            </div>
        </div>
    </form>
</body>
</html>
