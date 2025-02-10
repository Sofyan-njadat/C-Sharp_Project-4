<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="library.Sofyan.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lumen - Home Page</title>

    <!-- SWIPER -->
    <link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css" />

    <!-- Font Awesome CDN Link  -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <!-- CSS file link -->
    <link href="./style.css" rel="stylesheet" type="text/css" />
    <link href="./styleContactUs.css" rel="stylesheet" type="text/css" />

    <style>
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

            <img class="logo" style="width: 13%" src="./image/logoW01.png" />
            <nav class="navbar">
                <asp:LinkButton ID="lnkHome" runat="server" OnClick="lnkHome_Click">Home</asp:LinkButton>
                <asp:LinkButton ID="lnkMenu" runat="server" OnClick="lnkMenu_Click">Menu</asp:LinkButton>

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

                <!--  <asp:LinkButton ID="lnkLogin" runat="server" CssClass="btn btn-success btnLogin" OnClick="lnkLogin_Click">
            <i class='fas fa-sign-in-alt'></i> Login
                </asp:LinkButton>
                <asp:LinkButton ID="lnkRegister" runat="server" CssClass="btn btn-info btnRgstr" OnClick="lnkRegister_Click">
            <i class='fas fa-user-plus'></i> Register
                </asp:LinkButton>-->

                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-success" Visible="false" OnClick="btnLogin_Click" />
                <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-success" Visible="false" OnClick="btnRegister_Click" />
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-success" Visible="true" OnClick="btnLogout_Click" />
                <asp:Button ID="profile" runat="server" Text="Profile" CssClass="btn btn-success" Visible="true" OnClick="profile_Click" />


            </div>
        </header>




        <!-- HERO -->
        <section class="home" id="home">
            <div class="row">
                <div class="content">
                    <h3>read a book whith fresh coffee in the morning</h3>

                    <asp:LinkButton ID="borrowBook" runat="server" class="btn btnClr" OnClick="borrowBook_Click1">Borrow a Book Now</asp:LinkButton>
                    <asp:LinkButton ID="LinkButton2" runat="server" class="btn btnClr" OnClick="LinkButton2_Click">Book Private Room Now</asp:LinkButton>
                </div>
                <div class="image">
                    <asp:Image ID="Image1" runat="server" ImageUrl="./image/home-img-3.png" CssClass="main-home-image" AlternateText="Coffee Image" />
                </div>
            </div>
            <div class="image-slider">
                <asp:Image ID="Image2" runat="server" ImageUrl="./image/home-img-1.png" AlternateText="Slider Image 1" />
                <asp:Image ID="Image4" runat="server" ImageUrl="./image/home-img-3.png" AlternateText="Slider Image 3" />
                <asp:Image ID="Image3" runat="server" ImageUrl="./image/home-img-2.png" AlternateText="Slider Image 2" />
            </div>
        </section>



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



        <!-- MENU -->
        <section class="menu" id="menu">
            <h1 class="heading">Our Menu <span>Popular Menu</span></h1>

            <div class="box-container">
                <!-- Hot Drinks -->
                <a href="#" class="box">
                    <img src="./image/menu-1.png" alt="">
                    <div class="content">
                        <h3>Hot Espresso</h3>
                        <p>A rich, aromatic espresso shot to kickstart your day.</p>
                        <span>JD 3.99</span>
                    </div>
                </a>

                <a href="#" class="box">
                    <img src="./image/menu-2.png" alt="">
                    <div class="content">
                        <h3>Hot Latte</h3>
                        <p>Creamy latte with perfectly steamed milk.</p>
                        <span>JD 3.99</span>
                    </div>
                </a>

                <!-- Cold Drinks -->
                <a href="#" class="box">
                    <img src="./image/iced-coffee.png" alt="">
                    <div class="content">
                        <h3>Iced Coffee</h3>
                        <p>Cool and refreshing cold brew with a smooth finish.</p>
                        <span>JD 2.99</span>
                    </div>
                </a>

                <a href="#" class="box">
                    <img src="./image/iceed-tea.png" alt="">
                    <div class="content">
                        <h3>Iced Tea</h3>
                        <p>A revitalizing blend of tea served chilled.</p>
                        <span>JD 1.99</span>
                    </div>
                </a>

                <!-- Desserts -->
                <a href="#" class="box">
                    <img src="./image/pancake.png" alt="">
                    <div class="content">
                        <h3>Pancakes</h3>
                        <p>Fluffy pancakes served with syrup and fresh berries.</p>
                        <span>JD 3.99</span>
                    </div>
                </a>

                <a href="#" class="box">
                    <img src="./image/cookiee.png" alt="">
                    <div class="content">
                        <h3>Cookies</h3>
                        <p>Delicious, freshly baked cookies to satisfy your sweet cravings.</p>
                        <span>JD 0.99</span>
                    </div>
                </a>
            </div>
        </section>



        <!-- MEMBERSHIP -->
        <section class="membership" id="membership">
            <h1 class="heading">Membership Plans <span>Choose Your Plan</span></h1>

            <div class="box-container">
                <!-- Individual Membership -->
                <div class="box">
                    <div class="card">
                        <div class="front">
                            <h3>Individual Membership</h3>
                            <p class="price">15 JOD<span>/month</span></p>
                        </div>
                        <div class="back">
                            <h3>Individual Membership</h3>
                            <ul>
                                <li>Borrow up to 5 books at a time for 2 weeks.</li>
                                <li>4 drinks of your choice.</li>
                                <li>20% discount on private rooms.</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Corporate Membership -->
                <div class="box">
                    <div class="card">
                        <div class="front">
                            <h3>Corporate Membership</h3>
                            <p class="price">50 JOD<span>/month</span></p>
                        </div>
                        <div class="back">
                            <h3>Corporate Membership</h3>
                            <ul>
                                <li>Borrow up to 10 books at a time for 2 weeks.</li>
                                <li>13 drinks of your choice.</li>
                                <li>50% discount on meeting rooms.</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Family Membership -->
                <div class="box">
                    <div class="card">
                        <div class="front">
                            <h3>Family Membership</h3>
                            <p class="price">35 JOD<span>/month</span></p>
                        </div>
                        <div class="back">
                            <h3>Family Membership</h3>
                            <ul>
                                <li>Borrow up to 7 books at a time for 2 weeks.</li>
                                <li>10 drinks of your choice.</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>



        <!-- STAFF -->
        <section class="staff" id="staff">
            <h1 class="heading">our staff <span>meet our team</span></h1>

            <div class="box-container">
                <!-- Waiter 1 -->
                <div class="box">
                    <img src="./image/man3.jpg" alt="">

                    <div class="content">
                        <h3>John Doe</h3>
                        <p>Waiter</p>
                    </div>
                </div>

                <!-- Waiter 2 -->
                <div class="box">
                    <div class="content">
                        <img src="./image/man2.jpg" alt="">
                        <h3>Jane Smith</h3>
                        <p>Waiter</p>
                    </div>
                </div>

                <!-- Pastry Chef 1 -->
                <div class="box">
                    <img src="./image/man5.jpg" alt="">
                    <div class="content">
                        <h3>Michael Brown</h3>
                        <p>Pastry Chef</p>
                    </div>
                </div>

                <!-- Pastry Chef 2 -->
                <div class="box">
                    <img src="./image/man6.jpg" alt="">
                    <div class="content">
                        <h3>Emily Davis</h3>
                        <p>Pastry Chef</p>
                    </div>
                </div>
            </div>
        </section>



        <!-- REVIEW -->
        <section class="review" id="review">
            <h1 class="heading">reviews <span>what Customers says</span></h1>

            <
            <div class="swiper review-slider">
                <div class="swiper-wrapper">
                    <!-- First Review: Quiet Study Areas -->
                    <div class="swiper-slide box">
                        <i class="fas fa-quote-left"></i>
                        <i class="fas fa-quote-right"></i>
                        <img src="./image/pic-1.png" alt="">
                        <div class="stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <p>
                            The quiet study areas provide a perfect environment for concentration and relaxation.
               
                        </p>
                        <h3>Ali Hassan</h3>
                        <span>Satisfied client</span>
                    </div>

                    <!-- Second Review: Library & Book Variety -->
                    <div class="swiper-slide box">
                        <i class="fas fa-quote-left"></i>
                        <i class="fas fa-quote-right"></i>
                        <img src="./image/pic-2.png" alt="">
                        <div class="stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <p>
                            Every branch features a library with over 3000 books, offering a diverse and inspiring collection.
               
                        </p>
                        <h3>Noor Khalid</h3>
                        <span>Satisfied client</span>
                    </div>

                    <div class="swiper-slide box">
                        <i class="fas fa-quote-left"></i>
                        <i class="fas fa-quote-right"></i>
                        <img src="./image/pic-3.png" alt="">
                        <div class="stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <p>
                            I love the cozy environment and exceptional service. It’s my go-to spot for work and relaxation.
                        </p>
                        <h3>ٍSofyan Yousef</h3>
                        <span>satisfied client</span>
                    </div>

                    <div class="swiper-slide box">
                        <i class="fas fa-quote-left"></i>
                        <i class="fas fa-quote-right"></i>
                        <img src="./image/pic-4.png" alt="">
                        <div class="stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <p>
                            The best coffee lab in town with inspiring study spaces and friendly staff. A must-visit experience!
                        </p>
                        <h3>Mona Faris</h3>
                        <span>satisfied client</span>
                    </div>
                </div>
                <div class="swiper-pagination"></div>
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





        <!-- SWIPER -->
        <script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>

        <!-- JS file link  -->
        <script src="./script.js"></script>


    </form>
</body>
</html>
