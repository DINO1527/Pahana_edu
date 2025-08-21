<%--
  Created by IntelliJ IDEA.
  User: Dino_E
  Date: 21/07/2025
  Time: 20:58
  To change this template use File | Settings | File Templates.
--%>
<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("userId") == null) {
        if (session1 != null) {
            session1.invalidate();
        }
        response.sendRedirect("login.jsp?error=Please+login+first");
        return;
    }
%>
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
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
    #billTableBody td input {
    max-width: 100px;          /* take full cell width */
    padding: 4px 6px;     /* comfortable padding */
    box-sizing: border-box; /* prevent overflow */
    border: 1px solid #ccc;
    border-radius: 4px;
    text-align: center;   /* numbers look aligned */
}
    #billTableBody td input.bookName{
        max-width: 200px;
    }
</style>
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
<jsp:include page="navigation.jsp" />
<!-- ***** Header Area End ***** -->


<%
    String error = request.getParameter("error");
    if (error != null) {
%>
<script>
    Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: '<%= error %>'
    });
</script>
<%
    }
%>

<%
    String success = request.getParameter("success");
    if (success != null) {
%>
<script>
    Swal.fire({
        icon: 'success',
        title: 'done',
        text: '<%= success %>'
    });
</script>
<%
    }
%>



<div class="main-banner" with="100%" height="50%">
    <div class="container">
        <div class="row">
            <div class="col-lg-6 align-self-center">
                <div class="caption header-text"><h6>Billing Section</h6>
                    <div class="search-input">
                        <form action="BillServlet" method="post">
                            <input type="hidden" name="action" value="fetchCustomer">
                            <input type="text" name="search" placeholder="Phone or Account No">
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
        <div class="row justify-content-center">
            <div class="item col-md-10">
                <%
                    CustomerDTO c = (CustomerDTO)request.getAttribute("customer");
                    if(c==null && request.getParameter("search")!=null){
                %>
                <script>swal("User Not Found","Please Register the Customer","error");</script>
                <% } else if(c!=null){ %>
                <form action="BillServlet" method="post" class="mt-3">
                    <input type="hidden" name="action" value="saveBill">
                    <input type="hidden" name="customerId" value="<%=c.getCustomerId()%>">

                    <p class="fw-bold text-center mb-3">
                        Customer: <%=c.getName()%> | Phone: <%=c.getPhone()%>
                    </p>

                    <!-- Table -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped text-center align-middle">
                            <thead class="table-dark">
                            <tr>
                                <th style="width:10%">Book ID</th>
                                <th style="width:35%">Book Name</th>
                                <th style="width:15%">Price</th>
                                <th style="width:10%">Qty</th>
                                <th style="width:20%">Total</th>
                                <th style="width:10%">Action</th>
                            </tr>
                            </thead>
                            <tbody id="billTableBody"></tbody>
                        </table>
                    </div>

                    <!-- Add Row Button -->
                    <div class="d-flex justify-content-end mb-3">
                        <button type="button" id="addRow" class="btn btn-success">
                            ➕ Add Row
                        </button>
                    </div>

                    <!-- Grand Total -->
                    <h3 class="text-end mb-4">
                        Grand Total: Rs. <span id="grandTotal">0.00</span>
                    </h3>

                    <!-- Payment and Save -->
                    <div class="d-flex justify-content-between align-items-center">
                        <select name="payment" required class="form-select w-auto me-3">
                            <option value="">Select Payment</option>
                            <option value="cash">Cash</option>
                            <option value="card">Card</option>
                        </select>
                        <button type="submit" class="btn btn-primary">
                            Save Bill
                        </button>
                    </div>
                </form>
                <% } %>
            </div>
        </div>
    </div>
</div>




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
                let row = e.target.closest("tr");
                let bookId = row.querySelector(".bookSelect").value;
                let qty = e.target.value;

                if (bookId && qty) {
                    fetch(`CheckStockServlet?bookId=${bookId}&qty=${qty}`)
                        .then(res => res.json())
                        .then(data => {
                            if (data.status === "error") {
                                Swal.fire({
                                    icon: "error",
                                    title: "Stock Error",
                                    text: `Only ${data.stock || 0} items available!`
                                }).then(() => {
                                    e.target.value = "";              // clear qty
                                    row.querySelector(".total").value = "1"; // clear total
                                    calculateGrandTotal();
                                });
                            } else {
                                updateRowTotal(row); // qty is valid → recalc
                            }
                        });
                }
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
