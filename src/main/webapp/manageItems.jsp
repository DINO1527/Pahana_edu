<%--
  Created by IntelliJ IDEA.
  User: Dino_E
  Date: 21/07/2025
  Time: 20:58
  To change this template use File | Settings | File Templates.
--%>
<script>
    window.addEventListener("load", function () {
        const urlParams = new URLSearchParams(window.location.search);
        if (!urlParams.has("search")) {
            document.querySelector(".search-bar").submit();
        }
    });
</script>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="business.book.dto.BookDTO" %>
<%
    List<BookDTO> books = (List<BookDTO>) request.getAttribute("books");
%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">

    <title>Manage Items</title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">


    <!-- Additional CSS Files -->
    <link rel="stylesheet" href="assets/css/fontawesome.css">
    <link rel="stylesheet" href="assets/css/templatemo-lugx-gaming.css">
    <link rel="stylesheet" href="assets/css/owl.css">
    <link rel="stylesheet" href="assets/css/animate.css">
    <link rel="stylesheet"href="https://unpkg.com/swiper@7/swiper-bundle.min.css"/>
    <!--

    TemplateMo 589 lugx gaming

    https://templatemo.com/tm-589-lugx-gaming

    -->
</head>

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
        background: #1976d2;
        color: #fff;
    }
</style>
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
<jsp:include page="navigation.jsp" />
<!-- ***** Header Area End ***** -->

<div class="main-banner"  with="100%" height="50%">
    <div class="container">
        <div class="row">
            <div class="col-lg-6 align-self-center">
                <div class="caption header-text">
                    <h6>Welcome to lugx</h6>
                    <div class="search-input">
                        <form method="get" action="bookInventory" class="search-bar">
                            <input type="text" name="search"
                                   placeholder="Search by ID or Name"
                                   value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                            <button type="submit">Search</button>
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
            <div>
                <div class="item">
                        <table>
                            <tr>
                                <th>Book ID</th>
                                <th>Image</th>
                                <th>Book Name</th>
                                <th>Stock</th>
                                <th>Sold Count</th>
                            </tr>
                            <%
                                if (books != null) {
                                    for (BookDTO book : books) {
                                        String base64Image = book.getBookImage() != null
                                                ? java.util.Base64.getEncoder().encodeToString(book.getBookImage())
                                                : null;
                            %>
                            <tr onclick="editBook(<%= book.getBookId() %>)" style="cursor:pointer;">                            <td><%= book.getBookId() %></td>
                                <td>
                                    <% if (base64Image != null) { %>
                                    <img src="data:image/jpeg;base64,<%= base64Image %>" width="60" height="80"/>
                                    <% } else { %>
                                    No Image
                                    <% } %>
                                </td>
                                <td><%= book.getBookName() %></td>
                                <td><%= book.getStock() %></td>
                                <td><%= book.getSoldCount() %></td>


                            </tr>
                            <%      }
                            }
                            %>
                        </table>

                    </div>
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
<script>function editBook(bookId) {
    window.location.href = 'editBook?bookId=' + bookId;
}</script>
<!-- Bootstrap core JavaScript -->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="assets/js/isotope.min.js"></script>
<script src="assets/js/owl-carousel.js"></script>
<script src="assets/js/counter.js"></script>
<script src="assets/js/custom.js"></script>

</body>
</html>
