<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="library.AdminDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #E4E4E4;
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
            margin-left: 250px;
            padding: 20px;
            transition: margin-left 0.3s ease;
        }

            .main-content.expanded {
                margin-left: 0;
            }

        .toggle-button {
            position: fixed;
            top: 10px;
            left: 10px;
            background: #464646;
            color: #CCE0C5;
            border: none;
            border-radius: 5px;
            padding: 10px 15px;
            font-size: 16px;
            cursor: pointer;
            z-index: 1100;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background 0.3s;
        }

            .toggle-button:hover {
                background: #CCE0C5;
                color: #000000;
            }

        .dashboard-cards {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            justify-content: center;
        }

        .card {
            background: #CCE0C5;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            flex: 1;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
            max-width: 300px;
            width: 100%;
        }

            .card h3 {
                margin: 0;
                color: #000000;
                font-size: 18px;
            }

            .card .value {
                font-size: 32px;
                font-weight: bold;
                color: #000000;
                margin: 10px 0;
            }

            .card .description {
                font-size: 14px;
                color: #464646;
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
            <h2>Admin Dashboard</h2>
            <div class="dashboard-cards">
                <div class="card">
                    <h3> Books</h3>
                    <div class="value">
                        <asp:Label ID="lblTotalBooks" runat="server" Text="0"></asp:Label>
                    </div>
                    <div class="description">Number of books available in the library</div>
                </div>
                <div class="card">
                    <h3>Available Rooms</h3>
                    <div class="value">
                        <asp:Label ID="lblAvailableRooms" runat="server" Text="0"></asp:Label>
                    </div>
                    <div class="description">Rooms available for reservation</div>
                </div>
                <div class="card">
                    <h3>Pending Reservations Books</h3>
                    <div class="value">
                        <asp:Label ID="lblPendingReservations" runat="server" Text="0"></asp:Label>
                    </div>
                    <div class="description">Reservations awaiting Books confirmation</div>
                </div>

                 <div class="card">
     <h3>Pending Reservations Rooms</h3>
     <div class="value">
         <asp:Label ID="lblPendingReservationsRooms" runat="server" Text="0"></asp:Label>
     </div>
     <div class="description">Reservations awaiting Rooms confirmation</div>
 </div>
            </div>
        </div>
    </form>
</body>
</html>