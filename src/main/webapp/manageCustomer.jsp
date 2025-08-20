<%@ page import="java.util.List" %>
<%@ page import="business.customer.dto.CustomerDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%! String safe(Object o) {
    return (o == null) ? "" : o.toString();
} %> <% List<CustomerDTO> customers = (List<CustomerDTO>) request.getAttribute("customers"); %> <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap"
            rel="stylesheet">
    <title>Lugx Gaming Shop HTML5 Template</title> <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"> <!-- Additional CSS Files -->
    <link rel="stylesheet" href="assets/css/fontawesome.css">
    <link rel="stylesheet" href="assets/css/templatemo-lugx-gaming.css">
    <link rel="stylesheet" href="assets/css/owl.css">
    <link rel="stylesheet" href="assets/css/animate.css">
    <link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css"/>
    <!-- TemplateMo 589 lugx gaming https://templatemo.com/tm-589-lugx-gaming --> </head>
<body>
<style>
    table {
    border-collapse: collapse;
    width: 100%;
    margin-top: 10px;
}

th, td {
    border: 1px solid #ddd;
    padding: 8px;
    vertical-align: top;
}

th {
    background: #f5f5f5;
    text-align: left;
}

.actions a {
    display: inline-block;
    padding: 4px 10px;
    border-radius: 4px;
    text-decoration: none;
}

.btn-edit {
    background: #fc7e38;
    color: #fff;
}
</style>

<!-- ***** Preloader Start ***** -->
<div id="js-preloader" class="js-preloader">
    <div class="preloader-inner"><span class="dot"></span>
        <div class="dots"><span></span> <span></span> <span></span></div>
    </div>
</div> <!-- ***** Preloader End ***** --> <!-- ***** Header Area Start ***** -->
<jsp:include page="navigation.jsp" />
<!-- ***** Header Area End ***** -->
<div class="main-banner" with="100%" height="50%">
    <div class="container">
        <div class="row">
            <div class="col-lg-6 align-self-center">
                <div class="caption header-text"><h6>Welcome to lugx</h6>
                    <div class="search-input">
                        <form id="search" action="manageCustomer" method="get">
                            <input type="text"
                                   placeholder="Search by id or name or acc no"
                                   id='searchText'
                                   name="searchKeyword"/>
                            <button role="button" type="submit">Search Now</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="features">
    <div class="container">
        <div class="row">
            <div class="item">
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Account #</th>
                        <th>Name</th>
                        <th>Address</th>
                        <th>Phone</th>
                        <th>Email</th>

                    </tr>
                    </thead>
                    <tbody><% if (customers != null && !customers.isEmpty()) {
                        for (CustomerDTO c : customers) { %>
                    <tr onclick="window.location='<%= request.getContextPath() %>/EditCustomerServlet?customerId=<%= c.getCustomerId() %>'" style="cursor:pointer;">
                        <td><%= c.getCustomerId() %>
                        </td>
                        <td><%= safe(c.getAccountNumber()) %>
                        </td>
                        <td><%= safe(c.getName()) %>
                        </td>
                        <td><%= safe(c.getAddress()) %>
                        </td>
                        <td><%= safe(c.getPhone()) %>
                        </td>
                        <td><%= safe(c.getEmail()) %>
                        </td>
                    </tr>
                    <% }
                    } else { %>
                    <tr>
                        <td colspan="8">No customers found.</td>
                    </tr>
                    <% } %></tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<footer>
    <div class="container">
        <div class="col-lg-12"><p>Copyright © 2048 LUGX Gaming Company. All rights reserved. &nbsp;&nbsp; <a
                rel="nofollow" href="https://templatemo.com" target="_blank">Design: TemplateMo</a></p></div>
    </div>
</footer> <!-- Scripts --> <!-- Bootstrap core JavaScript -->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="assets/js/isotope.min.js"></script>
<script src="assets/js/owl-carousel.js"></script>
<script src="assets/js/counter.js"></script>
<script src="assets/js/custom.js"></script>
</body>
</html>

