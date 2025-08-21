<%--
  Created by IntelliJ IDEA.
  User: Dino_E
  Date: 21/07/2025
  Time: 20:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("userId") == null) {
        if (session1 != null) {
            session1.invalidate();
        }
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        response.sendRedirect("login.jsp?error=Please+login+first");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">

    <title>Lugx Gaming Shop HTML5 Template</title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">


    <!-- Additional CSS Files -->
    <link rel="stylesheet" href="assets/css/fontawesome.css">
    <link rel="stylesheet" href="assets/css/templatemo-lugx-gaming.css">
    <link rel="stylesheet" href="assets/css/owl.css">
    <link rel="stylesheet" href="assets/css/animate.css">
    <link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css"/>
    <!--

    -->
</head>

<body>


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



<!-- ***** Header Area Start ***** -->

<!-- ***** Header Area End ***** -->

<jsp:include page="navigation.jsp" />


<div class="main-banner">
    <div class="container" style="margin-top: -5%;">
        <div class="row">
            <div class="col-lg-6 align-self-center">
                <div class="caption header-text">
                    <h2>Welcome to<span style="color: #fc7e38; "> PAHANA <span style=" font-size: 10px;">edu</span></span></h2>
                    <h4>Bookshop Management System</h4>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="features">
    <div class="container " >
        <div class="row">

            <div class="col-lg-3 col-md-6">
                <a href="calculateBill.jsp">
                    <div class="item cap" >
                        <div class="image">
                            <img src="assets/images/calculator.png" alt="" style="max-width: 44px;">
                        </div>
                        <h4>Calculate
                            Bill</h4>
                    </div>
                </a>
            </div>

            <div class="col-lg-3 col-md-6">
                <a href="manageCustomer">
                    <div class="item cap">
                        <div class="image">
                            <img src="assets/images/user.png" alt="" style="max-width: 44px;">
                        </div>
                        <h4>Customer Management System</h4>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-6">
                <a href="manageItems.jsp">
                    <div class="item cap">
                        <div class="image">
                            <img src="assets/images/inventory.png" alt="" style="max-width: 44px;">
                        </div>
                        <h4>Inventory Management System</h4>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-6">
                <a href="help.jsp">
                    <div class="item cap">
                        <div class="image">
                            <img src="assets/images/help.png" alt="" style="max-width: 44px;">
                        </div>
                        <h4>Need
                            Help?</h4>
                    </div>
                </a>
            </div>
        </div>
    </div>
</div>

<footer>
    <div class="container">
        <div class="col-lg-12">
            <p>Copyright © 2048 LUGX Gaming Company. All rights reserved. &nbsp;&nbsp; <a rel="nofollow" href="https://templatemo.com" target="_blank">Design: TemplateMo</a></p>
        </div>
    </div>
</footer>

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