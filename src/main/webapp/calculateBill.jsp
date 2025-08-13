<%--
  Created by IntelliJ IDEA.
  User: Dino_E
  Date: 21/07/2025
  Time: 20:58
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="business.customer.dto.CustomerDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create Bill</title>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">


    <!-- Additional CSS Files -->
    <link rel="stylesheet" href="assets/css/fontawesome.css">
    <link rel="stylesheet" href="assets/css/templatemo-lugx-gaming.css">
    <link rel="stylesheet" href="assets/css/owl.css">
    <link rel="stylesheet" href="assets/css/animate.css">
    <link rel="stylesheet"href="https://unpkg.com/swiper@7/swiper-bundle.min.css"/>

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
<header class="header-area header-sticky">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <nav class="main-nav">
                    <!-- ***** Logo Start ***** -->
                    <a href="index.html" class="logo">
                        <img src="assets/images/logo.jpg" alt="" style="width: 158px;">
                    </a>
                    <!-- ***** Logo End ***** -->
                    <!-- ***** Menu Start ***** -->
                    <ul class="nav">
                        <li><a href="index.html" class="active">Home</a></li>
                        <li><a href="shop.html">Our Shop</a></li>
                        <li><a href="product-details.html">Product Details</a></li>
                        <li><a href="contact.html">Contact Us</a></li>
                        <li><a href="#">Sign In</a></li>
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
<!-- ***** Header Area End ***** -->
<div class="section">
<h2>Create Bill</h2>
<form action="BillServlet" method="post">
    <input type="hidden" name="action" value="fetchCustomer">
    <input type="text" name="search" placeholder="Phone or Account No">
    <button type="submit">Search</button>
</form>

<%
    CustomerDTO c = (CustomerDTO)request.getAttribute("customer");
    if(c==null && request.getParameter("search")!=null){
%>
<script>swal("User Not Found","Please Register the Customer","error");</script>
<% } else if(c!=null){ %>
<form action="BillServlet" method="post">
    <input type="hidden" name="action" value="saveBill">
    <input type="hidden" name="customerId" value="<%=c.getCustomerId()%>">

    <p>Customer: <%=c.getName()%> | Phone: <%=c.getPhone()%></p>

    <table border="1">
        <thead>
        <tr>
            <th>Book ID</th>
            <th>Book Name</th>
            <th>Price</th>
            <th>Qty</th>
            <th>Total</th>
            <th> </th>
        </tr>
        </thead>
        <tbody id="billTableBody"></tbody>
    </table>

    <button type="button" id="addRow">➕ Add Row</button>
    <h3>Grand Total: Rs. <span id="grandTotal">0.00</span></h3>

    <select name="payment" required>
        <option value="">Select Payment</option>
        <option value="cash">Cash</option>
        <option value="card">Card</option>
    </select>
    <button type="submit">Save Bill</button>
</form>
</div>
<% } %>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const tableBody = document.getElementById("billTableBody");
        const addRowBtn = document.getElementById("addRow");

        // Add row
        addRowBtn.addEventListener("click", function () {
            const row = document.createElement("tr");
            row.innerHTML = `
            <td><input type="number"  name="bookId"   class="bookSelect" required> </td>
            <td><input type="text"    name="bookName" class="bookName"   readonly></td>
            <td><input type="number"  name="price"    class="price"      readonly></td>
            <td><input type="number"  name="qty"      class="qty"        min="1" value="1"></td>
            <td><input type="number"  name="total"    class="total"      readonly></td>
            <td><button type="button" class="removeRow">❌</button></td>  `;
            tableBody.appendChild(row);
        });

        // Event delegation for remove and change events
        tableBody.addEventListener("click", function (e) {
            if (e.target.classList.contains("removeRow")) {
                e.target.closest("tr").remove();
                calculateGrandTotal();
            }
        });

        tableBody.addEventListener("change", function (e) {
            if (e.target.classList.contains("bookSelect")) {
                let bookId = e.target.value;
                let row = e.target.closest("tr");

                if (bookId) {
                    fetch(`GetPriceServlet?action=getBookDetails&bookId=${bookId}`)
                        .then(res => res.json())
                        .then(data => {
                            row.querySelector(".bookName").value = data.name || "";
                            row.querySelector(".price").value = data.price || 0;
                            updateRowTotal(row);
                        });
                }
            }

            if (e.target.classList.contains("qty")) {
                updateRowTotal(e.target.closest("tr"));
            }
        });

        function updateRowTotal(row) {
            let price = parseFloat(row.querySelector(".price").value) || 0;
            let qty = parseInt(row.querySelector(".qty").value) || 0;
            let total = price * qty;
            row.querySelector(".total").value = total.toFixed(2);
            calculateGrandTotal();
        }

        function calculateGrandTotal() {
            let grandTotal = 0;
            document.querySelectorAll(".total").forEach(t => {
                grandTotal += parseFloat(t.value) || 0;
            });
            document.getElementById("grandTotal").textContent = grandTotal.toFixed(2);
        }
    });
</script>

<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="assets/js/isotope.min.js"></script>
<script src="assets/js/owl-carousel.js"></script>
<script src="assets/js/counter.js"></script>
<script src="assets/js/custom.js"></script>
</body>
</html>
