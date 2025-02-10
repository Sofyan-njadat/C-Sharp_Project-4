<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="library.Sofyan.AboutUs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="./style.css" rel="stylesheet" type="text/css" />
    <link href="./styleContactUs.css" rel="stylesheet" type="text/css" />
    <style>
        .heading {
            font-size: 8rem;
            margin-bottom: 20px;
            top: 126px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>


            <!-- NAVBAR -->
            <header class="header">
                <div id="menu-btn" class="fas fa-bars"></div>
            <img class="logo" style="width: 13%" src="./image/logoW01.png" />
                <nav class="navbar">
                    <asp:LinkButton ID="lnkHome" runat="server" OnClick="lnkHome_Click">Home</asp:LinkButton>
                    <asp:LinkButton ID="lnkAbout" runat="server" OnClick="lnkAbout_Click1">Menu</asp:LinkButton>

                    <!-- Dropdown for Booking -->
                    <div class="dropdown">
                        <asp:LinkButton ID="lnkBooking" runat="server" CssClass="dropbtn" Style="font-weight: normal;">Booking ▼</asp:LinkButton>
                        <div class="dropdown-content">
                            <asp:LinkButton ID="lnkBookRoom" runat="server" OnClick="lnkBookRoom_Click">Book a Room</asp:LinkButton>
                            <asp:LinkButton ID="lnkBorrowBook" runat="server" OnClick="lnkBorrowBook_Click">Borrow a Book</asp:LinkButton>
                        </div>
                    </div>
                    <asp:LinkButton ID="lnkAboutUs" runat="server" OnClick="lnkAboutUs_Click">About</asp:LinkButton>
                    <asp:LinkButton ID="lnkContact" runat="server" OnClick="lnkContact_Click">Contact</asp:LinkButton>
                </nav>
                <div>
                    <%--    <asp:LinkButton ID="lnkLogin" runat="server" CssClass="btn btn-success btnLogin" OnClick="lnkLogin_Click">
                     <i class='fas fa-sign-in-alt'></i> Login
                 </asp:LinkButton>
                 <asp:LinkButton ID="lnkRegister" runat="server" CssClass="btn btn-info btnRgstr" OnClick="lnkRegister_Click1">
                     <i class='fas fa-user-plus'></i> Register
                 </asp:LinkButton>--%>

                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-success" Visible="false" OnClick="btnLogin_Click" />
                    <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-success" Visible="false" OnClick="btnRegister_Click" />
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-success" Visible="true" OnClick="btnLogout_Click1" />
                    <asp:Button ID="profile" runat="server" Text="Profile" CssClass="btn btn-success" Visible="true" OnClick="profile_Click" />





                </div>
            </header>




            <!-- ABOUT -->
            <section class="about" id="about">
                <h1 class="heading">About Us <span>Why Choose Us</span></h1>
                <div class="row">
                    <div class="image">
                        <asp:Image ID="Image5" runat="server" ImageUrl="./image/about-img.png" AlternateText="About Us Image" />
                    </div>
                    <div class="content">
                        <h3 class="title">What Makes us Special!</h3>
                        <p>
                            Our project offers quiet and beautiful spaces ideal for studying and meetings. In our branches, you'll find libraries with over 3000 books available for borrowing. We serve the finest fresh coffee, cold drinks, and delightful desserts to complement your visit.
                        </p>
                        <div class="icons-container">
                            <div class="icons">
                                <asp:Image ID="Image6" runat="server" ImageUrl="./image/about-icon-1.png" AlternateText="Quality Coffee" />
                                <h3>Fresh Coffee</h3>
                            </div>
                            <div class="icons">
                                <asp:Image ID="Image7" runat="server" ImageUrl="./image/private_company.png" AlternateText="Our Branches" />
                                <h3>Private Areas</h3>
                            </div>
                            <div class="icons">
                                <asp:Image ID="Image8" runat="server" ImageUrl="./image/library.png" AlternateText="Free Delivery" />
                                <h3>3000+ book Library</h3>
                            </div>
                        </div>
                    </div>
                </div>
            </section>









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
                    <img class="logo" style="width: 100%" src="./image/logo-removebg-preview.png" />

                    </div>
                </div>
                <div class="credit">created by <span>Lumen Web Design Group</span> | © all Copyrights reserved</div>
            </section>



        </div>

        <!-- Swiper JS -->
        <script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
        <script>
            // Initialize Swiper
            var swiper = new Swiper('.swiper', {
                loop: true,
                autoplay: {
                    delay: 3000, // 3 seconds per image
                    disableOnInteraction: false
                },
                pagination: {
                    el: '.swiper-pagination',
                    clickable: true
                },
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev'
                }
            });
        </script>

    </form>

</body>
</html>
