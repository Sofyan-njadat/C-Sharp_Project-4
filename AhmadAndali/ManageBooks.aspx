<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageBooks.aspx.cs" Inherits="library.ManageBooks" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Books</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
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
        <div class="main-content">
            <h2>Manage Books</h2>
            
            <!-- Add Book Form -->
            <div class="form-group">
                <label>Book Title:</label>
                <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <label>Author:</label>
                <asp:TextBox ID="txtAuthor" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Description:</label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
            </div>
            
            <div class="form-group">
                <label>Total Copies:</label>
                <asp:TextBox ID="txtTotalCopies" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <label>Book Image:</label>
                <asp:FileUpload ID="fuBookImage" runat="server" CssClass="form-control" />
            </div>
            <asp:Button ID="btnAddBook" runat="server" Text="Add Book" CssClass="btn" OnClick="btnAddBook_Click" />

            <!-- Filter Section -->
            <div class="filter">
                <asp:DropDownList ID="ddlFilter" runat="server" CssClass="form-control">
                    <asp:ListItem Text="All Books" Value="all" />
                    <asp:ListItem Text="Available Books" Value="available" />
                    <asp:ListItem Text="Reserved Books" Value="reserved" />
                </asp:DropDownList>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Placeholder="Search by Title or Author"></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click" />
                <asp:Button ID="btnFilter" runat="server" Text="Apply Filter" CssClass="btn" OnClick="btnFilter_Click" />
                <asp:Button ID="btnExportPDF" runat="server" Text="Export PDF" CssClass="btn" OnClick="btnExportPDF_Click" />
            </div>
            <asp:GridView ID="gvBooks" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered"
                OnRowCommand="gvBooks_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Title" HeaderText="Title" />
                    <asp:BoundField DataField="Author" HeaderText="Author" />
                    <asp:BoundField DataField="TotalCopies" HeaderText="Total Copies" />
                    <asp:BoundField DataField="AvailableCopies" HeaderText="Available Copies" />

                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <!-- زر التعديل -->
                            <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-warning btn-sm" 
                                CommandName="EditBook" CommandArgument='<%# Eval("BookID") %>' />

                            <!-- زر الحذف -->
                           <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm" 
                            CommandName="DeleteBook" CommandArgument='<%# Eval("BookID") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
