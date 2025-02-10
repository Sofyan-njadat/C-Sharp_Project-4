<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContactUs.aspx.cs" Inherits="library.Sofyan.ContactUs" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Lumen - Contact Us</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- SWIPER -->
    <link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <!-- CSS file link -->
    <link href="./style.css" rel="stylesheet" type="text/css" />
    <link href="./styleContactUs.css" rel="stylesheet" type="text/css" />


</head>
<body>
    <form id="form1" runat="server">
        <!-- NAVBAR -->
        <header class="header">
            <div id="menu-btn" class="fas fa-bars"></div>
            <img class="logo" style="width: 13%" src="./image/logoW01.png" />
            <nav class="navbar">
                <asp:LinkButton ID="lnkHome" runat="server" OnClick="lnkHome_Click"> Home </asp:LinkButton>
                <asp:LinkButton ID="lnkMenu" runat="server" OnClick="lnkMenu_Click"> Menu </asp:LinkButton>

                <div class="dropdown">
                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="dropbtn" Style="font-weight: normal;">Booking ▼</asp:LinkButton>
                    <div class="dropdown-content">
                        <asp:LinkButton ID="lnkBooking" runat="server" OnClick="lnkBooking_Click">Book a Room </asp:LinkButton>
                        <asp:LinkButton ID="lnkBorrowBook" runat="server" OnClick="lnkBorrowBook_Click">Borrow a Book </asp:LinkButton>
                    </div>
                </div>

                <asp:LinkButton ID="lnkAbout" runat="server" OnClick="lnkAbout_Click"> About </asp:LinkButton>
                <asp:LinkButton ID="lnkContact" runat="server" OnClick="lnkContact_Click"> Contact </asp:LinkButton>
            </nav>
            <div>
                <!--<asp:LinkButton ID="lnkLogin" runat="server" CssClass="btn btn-success btnLogin" OnClick="lnkLogin_Click">
                    <i class='fas fa-sign-in-alt'></i> Login 
                </asp:LinkButton>
                <asp:LinkButton ID="lnkRegister" runat="server" CssClass="btn btn-info btnRgstr" OnClick="lnkRegister_Click">
                    <i class='fas fa-user-plus'></i> Register 
                </asp:LinkButton>-->


                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-success" Visible="false" OnClick="btnLogin_Click" />
                <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-info" Visible="false" OnClick="btnRegister_Click" />
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-success" Visible="true" OnClick="btnLogout_Click" />
                <asp:Button ID="profile" runat="server" Text="Profile" CssClass="btn btn-success" Visible="true" OnClick="profile_Click" />

            </div>
        </header>

        <!-- CONTACT & MAP -->
        <section class="contact-map" id="contact-map">
            <h1 class="heading">Contact Us <span>Get in Touch</span></h1>
            <div class="container">
                <div class="contact-section">
                    <div class="quick-contact">
                        <h3>Quick Contact</h3>
                        <div class="info">
                            <p><strong>Address:</strong> Amman - Jordan / Mecca St.</p>
                            <p><strong>Mail Us:</strong> lumenjo@gmail.com</p>
                            <p><strong>Telephone:</strong> +962 797-777-999, +962 776-666-777</p>
                        </div>
                    </div>

                    <div class="lets-connect">
                        <h3>Let’s Connect</h3>
                        <div class="form-group">
                            <asp:TextBox ID="txtName" runat="server" placeholder="Your Name" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtEmail" runat="server" placeholder="Your Email" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="5" placeholder="Your Message" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Button ID="btnSubmit" runat="server" Text="Send Message" CssClass="btn btn-primary" OnClick="btnSubmit_Click" />
                        </div>
                    </div>
                </div>

                <div class="map-section">
                    <iframe
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3384.48148981805!2d35.86065707616816!3d31.97496062454111!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x151ca1a8acd4b789%3A0x61c0d2ea74952aef!2sMecca%20St.%2C%20Amman!5e0!3m2!1sen!2sjo!4v1738482098549!5m2!1sen!2sjo"
                        width="100%" height="450" style="border: 0;" allowfullscreen="" loading="lazy"></iframe>
                </div>
            </div>
        </section>

        <!-- FOOTER -->
        <section class="footer" style="background: #d3d0d07a">
            <div class="box-container">
                <div class="box">
                    <h3>Our Branches</h3>
                    <a href="#"><i class="fas fa-arrow-right"></i>Ajloun</a>
                    <a href="#"><i class="fas fa-arrow-right"></i>Amman</a>
                    <a href="#"><i class="fas fa-arrow-right"></i>Irbid</a>
                    <a href="#"><i class="fas fa-arrow-right"></i>Aqaba</a>
                    <a href="#"><i class="fas fa-arrow-right"></i>Jerash</a>
                </div>
                <div class="box">
                    <h3>Quick Links</h3>
                    <a href="#"><i class="fas fa-arrow-right"></i>Home</a>
                    <a href="#"><i class="fas fa-arrow-right"></i>Menu</a>
                    <a href="#"><i class="fas fa-arrow-right"></i>Booking</a>
                    <a href="#"><i class="fas fa-arrow-right"></i>About</a>
                    <a href="#"><i class="fas fa-arrow-right"></i>Contact</a>
                </div>
                <div class="box">
                    <h3>Contact Info</h3>
                    <a href="#"><i class="fas fa-phone"></i>+962 797-777-999</a>
                    <a href="#"><i class="fas fa-envelope"></i>lumenjo@gmail.com</a>
                    <a href="#"><i class="fas fa-directions"></i>Amman - Mecca St.</a>
                </div>
            </div>
            <div class="credit">Created by <span>Lumen Web Design Group</span> | © All rights reserved</div>
        </section>

        <!-- SWIPER -->
        <script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
        <!-- JS file -->
        <script src="<%= ResolveUrl("~/script.js") %>"></script>
    </form>
</body>
</html>
