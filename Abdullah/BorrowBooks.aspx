<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BorrowBooks.aspx.cs" Inherits="library.Abdullah.BorrowBooks" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Library Books</title>



    <!-- Font Awesome CDN Link  -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- MDBootstrap CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.0/mdb.min.css" rel="stylesheet" />
    <!-- SweetAlert CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

    <!-- SweetAlert JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>





    <style>
        /* Modern 3D Glassmorphism Design */
        body {
            font-family: 'Poppins', sans-serif;
            font-size: 20px !important;
            margin: 0;
            padding: 0;
            background: #FFFFFF;
            color: #fff;
        }



        .search-container {
            text-align: center;
            margin: 30px 0;
        }

        .search-box {
            padding: 12px;
            width: 50%;
            font-size: 18px;
            border: none;
            border-radius: 25px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            outline: none;
            transition: 0.3s;
        }

            .search-box:focus {
                transform: scale(1.05);
            }

        .search-btn {
            border: 1px solid #79bc79;
            padding: 12px 20px;
            font-size: 18px;
            background: #388e3c;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 25px;
            transition: 0.3s;
        }

            .search-btn:hover {
                background: #4caf50;
            }




        /* Hero Section */
        .hero-section {
            height: 400px;
            background-size: cover;
            background-position: center;
            border-radius: 15px;
            position: relative;
            overflow: hidden;
        }

        .hero-overlay {
            background-color: rgba(0, 0, 0, 0.6);
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .hero-content {
            text-align: center;
            color: white;
        }

        .hero-heading {
            font-size: 3rem;
            margin-bottom: 1rem;
        }

        .hero-subheading {
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .hero-button {
            padding: 10px 20px;
            background-color: transparent;
            border: 2px solid white;
            color: white;
            font-size: 1rem;
            border-radius: 25px;
            text-decoration: none;
            transition: background-color 0.3s, color 0.3s;
        }

            .hero-button:hover {
                background-color: white;
                color: black;
            }

        .books-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 25px;
            padding: 30px;
        }

    .book-card {
    display: flex;
    flex-direction: column;
    justify-content: space-between; /* يجعل الزر دائمًا في الأسفل */
    align-items: center; /* توسيط العناصر داخل الكارد */
    background: #353344;
    backdrop-filter: blur(15px);
    padding: 20px;
    border-radius: 15px;
    width: 400px;
    text-align: center;
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
    transition: transform 0.5s, box-shadow 0.5s;
    height: 704px; /* توحيد الطول لجميع الكروت */
}


            .book-card:hover {
                transform: translateY(-15px) scale(1.05);
                box-shadow: 0 15px 30px rgba(0, 0, 0, 0.5);
            }

            .book-card h3 {
                margin: 10px 0;
                font-size: 20px;
                color: #fff;
            }

        .borrow-btn {
            padding: 12px;
            font-size: 16px;
            background: #4caf50;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 10px;
            width: 100%;
            transition: background-color 0.3s ease;
            margin-top:auto;
        }

            .borrow-btn:hover {
                background-color: #388e3c;
            }

        .borrow-form {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(15px);
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
            animation: fadeIn 0.5s ease-in-out;
            max-width: 1200px;
            margin: auto;
            margin-top: 20px;
        }

            .borrow-form h2 {
                color: #fff;
            }

            .borrow-form label {
                font-size: 16px;
                color: #ddd;
            }

            .borrow-form input {
                width: 100%;
                padding: 10px;
                border-radius: 10px;
                border: none;
                outline: none;
                margin-bottom: 10px;
            }

            .borrow-form button {
                padding: 10px;
                background-color: #ff7eb3;
                border: none;
                border-radius: 10px;
                color: white;
                font-size: 16px;
                cursor: pointer;
                transition: 0.3s;
            }

                .borrow-form button:hover {
                    background-color: #ff5277;
                }

        .borrowed-books {
            background: #749585;
            backdrop-filter: blur(15px);
            padding: 20px;
            border-radius: 15px;
            text-align: center;
            margin: 30px auto;
            max-width: 1200px;
        }

            .borrowed-books h2 {
                color: #fff;
            }

            .borrowed-books ul {
                list-style: none;
                padding: 0;
            }

            .borrowed-books li {
                padding: 12px;
                background: rgba(255, 255, 255, 0.2);
                border-radius: 10px;
                margin: 5px 0;
                transition: transform 0.3s;
            }

                .borrowed-books li:hover {
                    transform: scale(1.05);
                }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>

    
    <style>

    /* this style for navbar and footer */

        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@100;300;400;500;600&display=swap');


        :root {
            --main-color: #443;
            --border-radius: 95% 4% 97% 5% / 4% 94% 3% 95%;
            --border-radius-hover: 4% 95% 6% 95% / 95% 4% 92% 5%;
            --border: .2rem solid var(--main-color);
            --border-hover: .2rem dashed var(--main-color);
        }

        * {
            text-decoration: none;
        }

        html {
            font-size: 62.5%;
            overflow-x: hidden;
            scroll-padding-top: 7rem;
            scroll-behavior: smooth;
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


        /* HEADER */
        .header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            display: flex;
            align-items: center;
            justify-content: space-between;
            z-index: 1000;
            background: #fff;
            box-shadow: 0 .5rem 1rem rgba(0, 0, 0, .1);
            padding: 0rem 9%;
        }

            .header .logo {
                color: var(--main-color);
                font-size: 2.3rem;
            }

                .header .logo i {
                    padding-left: .5rem;
                }

            .header .navbar a {
                margin: 0 1rem;
                font-size: 1.7rem;
                color: var(--main-color);
            }

            .header .btn {
                margin-top: 0;
            }

        #menu-btn {
            font-size: 3rem;
            color: var(--main-color);
            cursor: pointer;
            display: none;
        }

        .btnLogin {
            background: #79bc79;
        }

        .btnRgstr {
            background: #5BC0DE;
        }

        .btnClr {
            background: #9c7d4857;
        }






        /* //////////// Drp Down Style////////////// */
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








        .footer .box-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(23rem, 1fr));
            gap: 1.5rem;
        }

            .footer .box-container .box h3 {
                font-size: 2.5rem;
                padding: 1rem 0;
                color: var(--main-color);
            }

            .footer .box-container .box a {
                display: block;
                font-size: 1.5rem;
                padding: 1rem 0;
                color: var(--main-color);
            }

                .footer .box-container .box a i {
                    padding-right: .5rem;
                }

                .footer .box-container .box a:hover i {
                    padding-right: 2rem;
                }

        .footer .credit {
            text-align: center;
            font-size: 2rem;
            padding: 2rem 1rem;
            margin-top: 1rem;
            color: var(--main-color);
        }

            .footer .credit span {
                border-bottom: var(--border-hover);
            }
    </style>






</head>
<body>
    <form id="form1" runat="server">



        <!-- NAVBAR -->
        <header class="header">
            <div id="menu-btn" class="fas fa-bars"></div>

            <img class="logo" style="width: 13%" src="logoW01.png" />
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
                <asp:LinkButton ID="lnkLogin" runat="server" CssClass="btn btn-success " OnClick="lnkLogin_Click">
<i class='fas fa-sign-in-alt'></i> Logout
                </asp:LinkButton>
                <asp:LinkButton ID="lnkRegister" runat="server" CssClass="btn btn-info " OnClick="lnkRegister_Click">
<i class='fas fa-user-plus'></i> Profile
                </asp:LinkButton>
            </div>
        </header>





        <!-- Hero -->
        <div class="p-5 text-center bg-image rounded-3" style="background-image: url('https://mdbcdn.b-cdn.net/img/new/slides/041.webp'); height: 600px;">
            <div class="mask" style="background-color: rgba(0, 0, 0, 0.6);">
                <div class="d-flex justify-content-center align-items-center h-100">
                    <div class="text-white">
                        
                       
                    </div>
                </div>
            </div>
        </div>
        <!-- Hero -->




        <!-- Search Form -->
        <div class="search-container">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="search-box" placeholder="Search books..."></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="search-btn" OnClick="btnSearch_Click" />
        </div>
        <asp:Label ID="lblMessage" runat="server" Text="" CssClass="message-label" />




        <!-- Books Container -->
        <div class="books-container">
            <asp:Repeater ID="BooksRepeater" runat="server" OnItemCommand="BooksRepeater_ItemCommand">
                <ItemTemplate>
                    <div class="book-card">
                        <img src="<%# Eval("ImageURL") %>" style="width: 360px; height: 300px; border-radius: 10px;">
                        <h3><%# Eval("Title") %></h3>
                        <p style="opacity: 0.8;"><%# Eval("Description") %> </p>
                        <p><%# Eval("Status") %></p>
                        <!-- Borrow Button -->
                        <asp:Button ID="btnBorrow" runat="server" Text="Borrow" CommandName="Borrow" CommandArgument='<%# Eval("Title") %>' CssClass="borrow-btn" />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- Hidden Borrow Form -->
        <asp:Panel ID="borrowForm" runat="server" CssClass="borrow-form" Visible="false">
            <h2>Borrow Book</h2>
            <asp:HiddenField ID="hiddenBookTitle" runat="server" />
            <label for="txtPickupTime">Pick-up Time:</label>
            <asp:TextBox ID="txtPickupTime" runat="server" TextMode="DateTimeLocal" required="true"></asp:TextBox>
            <label for="txtDeliveryTime">Delivery Time:</label>
            <asp:TextBox ID="txtDeliveryTime" runat="server" TextMode="DateTimeLocal" required="true"></asp:TextBox>
            <asp:Button ID="btnSubmitBorrow" runat="server" Text="Submit Borrow Request" OnClick="btnSubmitBorrow_Click" />
        </asp:Panel>

        <!-- Confirmation Message -->
        <asp:Label ID="lblBorrowMessage" runat="server" Text="" CssClass="message-label" />

        <!-- Borrowed Books Section -->
        <div class="borrowed-books">
            <h2>Borrowed Books</h2>
            <asp:Repeater ID="BorrowedBooksRepeater" runat="server">
                <ItemTemplate>
                    <ul>
                        <li>
                            <strong><%# Eval("BookTitle") %></strong> - Pick-up: <%# Eval("PickupTime") %>, Delivery: <%# Eval("DeliveryTime") %>
                        </li>
                    </ul>
                </ItemTemplate>
            </asp:Repeater>
        </div>








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
                    <img class="logo" style="width: 100%" src="./logo-removebg-preview.png" />

                </div>
            </div>
            <div class="credit">created by <span>Lumen Web Design Group</span> | © all Copyrights reserved</div>
        </section>


        <!-- SWIPER -->
        <script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>

        <!-- JS file link  -->
        <script src="./script.js"></script>
        <!-- MDBootstrap JS -->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.0/mdb.min.js"></script>





    </form>
</body>
</html>
