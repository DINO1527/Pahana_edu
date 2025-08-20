<%--
  Created by IntelliJ IDEA.
  User: Dino_E
  Date: 21/07/2025
  Time: 20:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String status = request.getParameter("status");
    String message = request.getParameter("message");
%>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">

    <title>Lugx Gaming Template - Contact Page</title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">


    <!-- Additional CSS Files -->
    <link rel="stylesheet" href="assets/css/fontawesome.css">
    <link rel="stylesheet" href="assets/css/templatemo-lugx-gaming.css">
    <link rel="stylesheet" href="assets/css/owl.css">
    <link rel="stylesheet" href="assets/css/animate.css">
    <link rel="stylesheet"href="https://unpkg.com/swiper@7/swiper-bundle.min.css"/>

        <title>Ad New Customer</title>
    </head>
    <body>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- ***** Preloader Start ***** -->
    <div id="js-preloader" class="js-preloader">
        <div class="preloader-inner">
            <span class="dot"></span>
            <div class="dots">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>
    </div>
    <!-- ***** Preloader End ***** -->


    <script>
        const status = "<%= status %>";
        const message="<%=message%>%"

        if (status === "success") {
            Swal.fire({
                icon: 'success',
                title: 'Customer Added!',
                text: 'The customer has been added successfully.',
                confirmButtonColor: '#3085d6'
            });
        } else if (status === "error") {
            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: message,
                confirmButtonColor: '#d33'
            });
        } else if (status === "exception") {
            Swal.fire({
                icon: 'warning',
                title: 'Exception!',
                text: 'Unexpected error occurred. Check the logs.',
                confirmButtonColor: '#f1c40f'
            });
        }
    </script>



    <header class="header-area header-sticky" style="background-color: aqua;top: 0;">
        <div class="container" >
            <div class="row">
                <div class="col-12">
                    <nav class="main-nav">
                        <!-- ***** Logo Start ***** -->
                        <a href="index.html" class="logo">
                            <img src="assets/images/logo.png" alt="" style="width: 158px;">
                        </a>
                        <!-- ***** Logo End ***** -->
                        <!-- ***** Menu Start ***** -->
                        <ul class="nav">
                            <li><a href="#">❌</a></li>
                        </ul>
                        <a class='menu-trigger'>
                            <span>Menu</span>
                        </a>
                        <!-- ***** Menu End ***** -->
                    </nav>
                </div>
            </div>
        </div>
    </header>


    <div class="contact-page section">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 align-self-center">
                    <div class="left-text">
                        <div class="section-heading">
                            <h6>Welcome to Pahana Edu Book Shop</h6>
                            <h2>Register new customer</h2>
                        </div>
                        <p>Pahana Edu Book Shop is your trusted source for educational books and materials. Use the form below to register a new customer in our system.</p>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="right-content">
                        <div class="row">

                            <div class="col-lg-12">
                                <form id="contact-form" action="AddCustomerServlet" method="post">

                                <div class="row">
                                        <div class="col-lg-6">
                                            <div class="input-container">
                                                <input type="text" name="accountNumber" required pattern="\d{5}" title="Account Number must be exactly 5 digits" placeholder=" "/>
                                                <label>Account Number</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="input-container">
                                                <input type="text" name="name" required placeholder=" "  />
                                                <label>Customer Name</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="input-container">
                                                <input type="text" name="phone" required pattern="\d{10}" maxlength="10"
                                                       title="Phone number must be exactly 10 digits"
                                                       placeholder=" " />
                                                <label>Phone Number</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="input-container">
                                                <input type="email" name="email" required placeholder=" " />
                                                <label>Email</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="input-container">
                                                <input type="text" name="address" required placeholder=" "/>
                                                <label>Address</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <fieldset>
                                                <button type="submit" class="orange-button">Register Customer</button>
                                            </fieldset>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



  <!-- Scripts -->

    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/js/isotope.min.js"></script>
    <script src="assets/js/owl-carousel.js"></script>
    <script src="assets/js/counter.js"></script>
    <script src="assets/js/custom.js"></script>

    </body>
    </html>
