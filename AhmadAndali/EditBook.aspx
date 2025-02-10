<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditBook.aspx.cs" Inherits="library.EditBook" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>Edit Book</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
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
            background: #2c3e50;
            color: white;
            position: fixed;
            height: 100vh;
            padding-top: 20px;
        }
        .sidebar h2 {
            text-align: center;
            color: #CCE0C5;
            margin-bottom: 30px;
        }
        .sidebar .menu-button {
            display: block;
            width: 90%;
            background: #34495e;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px;
            margin: 10px auto;
            text-align: center;
            cursor: pointer;
            transition: background 0.3s;
        }
        .sidebar .menu-button:hover {
            background: #CCE0C5;
            color: black;
        }
        .sidebar .active {
            background: #CCE0C5;
            color: black;
            font-weight: bold;
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Sidebar -->
      

        <!-- Main Content -->
        <div class="main-content">
            <h2>Edit Book</h2>

            <div class="form-group">
                <label>Book ID:</label>
                <asp:TextBox ID="txtBookID" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="form-group">
                <label>Title:</label>
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
            <asp:Button ID="btnUpdateBook" runat="server" Text="Update Book" CssClass="btn btn-primary" OnClick="btnUpdateBook_Click" />
        </div>
    </form>
</body>
</html>
