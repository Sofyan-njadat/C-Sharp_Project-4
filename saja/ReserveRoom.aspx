<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReserveRoom.aspx.cs" Inherits="library.ReserveRoom" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Room Reservation</title>

    <!-- SWIPER -->
    <link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css" />

    <!-- Font Awesome CDN Link  -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <!-- CSS file link -->
    <link href="./style.css" rel="stylesheet" type="text/css" />
    <link href="./styleContactUs.css" rel="stylesheet" type="text/css" />

    <style>
           * {
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #FFFFFF;
            color: #fff;
            width: 100%
        }

        section {
            padding: 2rem 9%;
        }

        .heading {
            font-size: 9rem;
            text-transform: uppercase;
            color: transparent;
            -webkit-text-stroke: .05rem var(--main-color);
            letter-spacing: .2rem;
            text-align: center;
            pointer-events: none;
            position: relative;
        }

        {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
        }






        .auth-buttons {
            display: flex;
            gap: 10px;
        }

            .auth-buttons button {
                padding: 5px 10px;
                border: 1px solid #444;
                border-radius: 5px;
                background-color: transparent;
                color: #444;
                font-size: 1rem;
                cursor: pointer;
                transition: all 0.3s;
            }

                .auth-buttons button:hover {
                    background-color: #007bff;
                    color: #fff;
                    border-color: #007bff;
                }


        @media (max-width: 425px) {
            .nav-links {
                display: none;
            }

            .auth-buttons {
                flex-direction: column;
            }

                .auth-buttons button {
                    width: 100px;
                    text-align: center;
                }
        }


        .heading span {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 100%;
            color: var(--main-color);
            font-size: 3rem;
        }

        .btn {
            display: inline-block;
            padding: .9rem 1.5rem;
            border: var(--border);
            border-radius: var(--border-radius);
            color: var(--main-color);
            background: none;
            cursor: pointer;
            margin-top: 1rem;
            font-size: 1.7rem;
        }

            .btn:hover {
                border-radius: var(--border-radius-hover);
                border: var(--border-hover);
            }



        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 1rem;
        }

        .textcolor {
            color: black;
        }

        .maze {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 15px;
            perspective: 1000px;
            margin-top: 90px;
        }

        .room {
            padding: 20px;
            text-align: center;
            cursor: pointer;
            height: 120px;
            font-weight: bold;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s, box-shadow 0.3s;
        }

            .room:hover {
                transform: translateY(-5px) rotateY(5deg);
                box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.4);
            }

        .available {
            background: linear-gradient(120deg, #2ECC71, #27AE60);
            color: white;
        }

        .booked {
            background: linear-gradient(120deg, #E74C3C, #C0392B);
            color: white;
            cursor: not-allowed;
        }

        .booking-form {
            background: #353344;
            padding: 2rem;
            border-radius: 15px;
            margin-top: 2rem;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s;
        }

            .booking-form:hover {
                transform: scale(1.02);
            }

        input, select {
            width: 100%;
            padding: 0.8rem;
            margin: 0.5rem 0;
            border-radius: 10px;
            border: none;
            background: rgba(255, 255, 255, 0.3);
            color: #fff;
        }

        .Submitbtn1 {
            background: #4CAF50;
        }

        button {
            background: linear-gradient(120deg, #2980B9, #2471A3);
            color: white;
            border: none;
            padding: 1rem;
            cursor: pointer;
            width: 100%;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s;
        }

            button:hover {
                transform: translateY(-3px);
                box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.4);
            }

        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 1rem;
        }

        .modern-table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.4);
            background: rgba(255, 255, 255, 0.15);
            color: #fff;
            margin-top: 2rem;
            transition: transform 0.3s, box-shadow 0.3s;
        }

            .modern-table:hover {
                transform: scale(1.02);
                box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.5);
            }

            .modern-table th, .modern-table td {
                padding: 1rem;
                text-align: center;
                border-bottom: 1px solid rgba(255, 255, 255, 0.3);
                transition: background 0.3s, color 0.3s;
            }

            .modern-table th {
                background: #353344;
                font-weight: bold;
                text-transform: uppercase;
                font-size: 12px;
            }

            .modern-table tr:hover {
                background: rgba(255, 255, 255, 0.25);
                transform: scale(1.01);
                transition: transform 0.3s, background 0.3s;
            }

            .modern-table td {
                background: #749585;
                font-size: 20px;
            }

            .modern-table button {
                background: linear-gradient(120deg, #e74c3c, #c0392b);
                color: white;
                border: none;
                padding: 0.5rem 1rem;
                cursor: pointer;
                border-radius: 8px;
                transition: transform 0.3s, background 0.3s;
            }

                .modern-table button:hover {
                    transform: scale(1.1);
                    background: linear-gradient(120deg, #c0392b, #a93226);
                }

        footer {
            background: linear-gradient(120deg, #34495E, #2C3E50);
            color: white;
            text-align: center;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0px -4px 10px rgba(0, 0, 0, 0.3);
        }



        /* تنسيق القائمة المنسدلة */
        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropbtn {
            background: none;
            border: none;
            color: white;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            padding: 10px;
            transition: 0.3s;
        }

            .dropbtn:hover {
                color: #ff9800;
            }

        .dropdown-content {
            display: none;
            position: absolute;
            background: white;
            min-width: 200px;
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
            border-radius: 5px;
            z-index: 100;
        }

            .dropdown-content a, .dropdown-content .aspNetLink {
                color: #333;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
                transition: 0.3s;
            }

                .dropdown-content a:hover, .dropdown-content .aspNetLink:hover {
                    background: #f1f1f1;
                }

        /* عرض القائمة عند تمرير الماوس */
        .dropdown:hover .dropdown-content {
            display: block;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">

        <!-- NAVBAR -->
        <header class="header">
            <div id="menu-btn" class="fas fa-bars"></div>

            <img class="logo" style="width: 13%" src="./logoW01.png" />
            <nav class="navbar">
                <asp:LinkButton ID="lnkHome" runat="server" OnClick="lnkHome_Click">Home</asp:LinkButton>
                <asp:LinkButton ID="lnkAbout" runat="server" OnClick="lnkAbout_Click">Menu</asp:LinkButton>

                <!-- Dropdown for Booking -->
                <div class="dropdown">
                    <asp:LinkButton ID="lnkBooking" runat="server" CssClass="dropbtn" Style="font-weight: normal;">Booking ▼</asp:LinkButton>
                    <div class="dropdown-content">
                        <asp:LinkButton ID="lnkBookRoom" runat="server" OnClick="lnkBookRoom_Click">Book a Room </asp:LinkButton>
                        <asp:LinkButton ID="lnkBorrowBook" runat="server" OnClick="lnkBorrowBook_Click">Borrow a Book </asp:LinkButton>
                    </div>
                </div>

                <asp:LinkButton ID="lnkAboutUs" runat="server" OnClick="lnkAboutUs_Click">About</asp:LinkButton>
                <asp:LinkButton ID="lnkContact" runat="server" OnClick="lnkContact_Click">Contact</asp:LinkButton>
            </nav>
            <div>
                <asp:LinkButton ID="lnkLogin" runat="server" CssClass="btn btn-success btnLogin" OnClick="lnkLogin_Click">
<i class='fas fa-sign-in-alt'></i> Logout
                </asp:LinkButton>
                <asp:LinkButton ID="lnkRegister" runat="server" CssClass="btn btn-info btnRgstr" OnClick="lnkRegister_Click">
<i class='fas fa-user-plus'></i> Profile
                </asp:LinkButton>
            </div>
        </header>






        <div class="container">
            <h2 class="textcolor">Room Layout</h2>
            <div class="maze" id="roomContainer" runat="server">
                <!-- الغرف سيتم تحميلها ديناميكيًا من الكود الخلفي -->
            </div>
            <div class="booking-form">
                <h2>Booking Form</h2>
                <asp:Label ID="lblRoomDetails" runat="server" Text="Selected Room: None"></asp:Label>
                <asp:HiddenField ID="hiddenSelectedRoom" runat="server" />
                <asp:TextBox ID="txtFullName" runat="server" placeholder="Full Name" required="true"></asp:TextBox>
                <asp:TextBox ID="txtDate" runat="server" TextMode="Date" required="true"></asp:TextBox>
                <asp:TextBox ID="txtTime" runat="server" TextMode="Time" required="true"></asp:TextBox>
                <asp:DropDownList ID="ddlSnack" runat="server">
                    <asp:ListItem   style="color:black !important;" Text="None" Value="0"></asp:ListItem>
 <asp:ListItem Text="Chips - 10 JD" Value="10" style="color:black !important;"></asp:ListItem>
 <asp:ListItem Text="Cookies - 5 JD" Value="5" style="color:black !important;"></asp:ListItem>
 <asp:ListItem Text="Soda - 7 JD" Value="7" style="color:black !important;"></asp:ListItem>
 <asp:ListItem Text="Chocolate - 8 JD" Value="8" style="color:black !important;"></asp:ListItem>
                </asp:DropDownList>
                <asp:Button ID="btnSubmit" runat="server" class="Submitbtn1" Text="Confirm Reservation" OnClick="btnSubmit_Click" />
                <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Visible="false"></asp:Label>
            </div>

            <div class="container">
<p class="textcolor" style="font-size:30px; text-align:center; font-weight:bold; padding:10px;" >Pending Room Requests</p>                <asp:GridView ID="gvPendingRequests" runat="server" CssClass="modern-table" AutoGenerateColumns="False" OnRowCommand="gvPendingRequests_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="ID" />
                        <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                        <asp:BoundField DataField="Room" HeaderText="Room" />
                        <asp:BoundField DataField="Date" HeaderText="Date" />
                        <asp:BoundField DataField="Time" HeaderText="Time" />
                        <asp:BoundField DataField="Snack" HeaderText="Snack" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:ButtonField ButtonType="Button" CommandName="Delete" Text="Delete" />
                    </Columns>
                </asp:GridView>

<p class="textcolor"  style="font-size:30px; text-align:center; font-weight:bold; padding:10px;" >Approved Room Requests</p>                <asp:GridView ID="gvApprovedRequests" runat="server" CssClass="modern-table" AutoGenerateColumns="False" OnRowCommand="gvApprovedRequests_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="ID" />
                        <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                        <asp:BoundField DataField="Room" HeaderText="Room" />
                        <asp:BoundField DataField="Date" HeaderText="Date" />
                        <asp:BoundField DataField="Time" HeaderText="Time" />
                        <asp:BoundField DataField="Snack" HeaderText="Snack" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:ButtonField ButtonType="Button" CommandName="Complete" Text="Complete" />
                    </Columns>
                </asp:GridView>

<p style="font-size:30px; text-align:center; font-weight:bold; padding:10px;"  class="textcolor">Rejected Room Requests</p>                <asp:GridView ID="gvRejectedRequests" runat="server" CssClass="modern-table" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="ID" />
                        <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                        <asp:BoundField DataField="Room" HeaderText="Room" />
                        <asp:BoundField DataField="Date" HeaderText="Date" />
                        <asp:BoundField DataField="Time" HeaderText="Time" />
                        <asp:BoundField DataField="Snack" HeaderText="Snack" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                    </Columns>
                </asp:GridView>
            </div>

        </div>
        <%--        </div>
        </div>--%>




        <!-- FOOTER -->
        <section class="footer" style="background: #d3d0d07a">
            <div class="box-container">
                <div class="box">
                    <h3>our branches</h3>
                    <a href="#"><i class="fas fa-arrow-right"></i>Ajloun</a>
                    <a href="#"><i class="fas fa-arrow-right"></i>Amman</a>
                    <a href="#"><i class="fas fa-arrow-right"></i>Irbid</a>
                    <a href="#"><i class="fas fa-arrow-right"></i>Aqaba</a>
                    <a href="#"><i class="fas fa-arrow-right"></i>Jerash</a>
                </div>
                <div class="box">
                    <h3>quick links</h3>
                    <a href="#home"><i class="fas fa-arrow-right"></i>Home</a>
                    <a href="#about"><i class="fas fa-arrow-right"></i>Menu</a>
                    <a href="#menu"><i class="fas fa-arrow-right"></i>Book a Room</a>
                    <a href="#menu"><i class="fas fa-arrow-right"></i>Borrow a Book</a>
                    <a href="#review"><i class="fas fa-arrow-right"></i>About</a>
                    <a href="#book"><i class="fas fa-arrow-right"></i>Contact</a>
                </div>
                <div class="box">
                    <h3>contact info</h3>
                    <a href="#"><i class="fas fa-phone"></i>+962 797-777-999</a>
                    <a href="#"><i class="fas fa-phone"></i>+962 776-666-777</a>
                    <a href="#"><i class="fas fa-envelope"></i>lumenjo@gmail.com</a>
                    <a href="#"><i class="fas fa-directions"></i>Jordan, Amman - Mecca St.</a>
                </div>
                <div class="box">
                    <h3></h3>
                    <img class="logo" style="width: 100%" src="./logoW01.png" />

                </div>
            </div>
            <div class="credit">created by <span>Lumen Web Design Group</span> | © all Copyrights reserved</div>
        </section>


        <!-- SWIPER -->
        <script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>

        <!-- JS file link  -->
        <script src="./script.js"></script>

        <script type="text/javascript">
            function setSelectedRoom(room, elem) {
                document.getElementById('<%= hiddenSelectedRoom.ClientID %>').value = room;
                document.getElementById('<%= lblRoomDetails.ClientID %>').innerText = "Selected Room: " + room;
                var rooms = document.getElementsByClassName('room');
                for (var i = 0; i < rooms.length; i++) {
                    rooms[i].classList.remove('selected');
                }
                elem.classList.add('selected');
            }
        </script>

    </form>
</body>
</html>
