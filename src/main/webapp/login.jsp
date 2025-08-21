<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <style>
        .error { color: red; font-size: 12px; }
        .input-error { border: 1px solid red; }
    </style>
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

<div class="contact-page section bgm">
    <div class="container">
        <div class="row">
            <div class="col-lg-6 align-self-left">
                <div class="left-text">
                    <div class="section-heading">
                        <h6>Welcome to Pahana Edu Book Shop</h6>
                        <h2>Inventory Customer Management System</h2>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="right-content">
                    <div class="row">
                        <div class="col-lg-12 d-flex justify-content-left">
                            <form action="login" method="post" class="w-50">
                                <div class="mb-3 text-center"><h4 style="color: #fc7e38">LOGIN</h4></div>
                                <div class="mb-3">
                                    <div class="input-container">
                                        <input type="text" name="username"
                                               class="form-control <%= request.getAttribute("error") != null ? "input-error" : "" %>"
                                               required placeholder=" " />
                                        <label>User Name</label>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <div class="input-container">
                                        <input type="password" name="password"
                                               class="form-control <%= request.getAttribute("error") != null ? "input-error" : "" %>"
                                               required placeholder=" " />
                                        <label>Password</label>
                                    </div>
                                </div>

                                <% if (request.getAttribute("error") != null) { %>
                                <div class="text-danger mb-3"><%= request.getAttribute("error") %></div>
                                <% } %>

                                <div class="text-center">
                                    <button type="submit" class="btn btn-primary px-4">Login</button>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- Bootstrap core JavaScript -->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="assets/js/isotope.min.js"></script>
<script src="assets/js/owl-carousel.js"></script>
<script src="assets/js/counter.js"></script>
<script src="assets/js/custom.js"></script>

</body>
</html>
