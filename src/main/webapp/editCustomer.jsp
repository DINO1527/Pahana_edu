<%@ page import="business.customer.model.Customer" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="business.customer.dto.CustomerDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    CustomerDTO c = (CustomerDTO) request.getAttribute("customer");
    List<Map<String,Object>> history = (List<Map<String,Object>>) request.getAttribute("history");

    if (c == null) {
%>
<p style="color:red;">❌ Customer not found.</p>
<%
        return;
    }
%>
<html>
<head>
    <title>Customer Details</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">



    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">


    <!-- Additional CSS Files -->
    <link rel="stylesheet" href="assets/css/fontawesome.css">
    <link rel="stylesheet" href="assets/css/templatemo-lugx-gaming.css">
    <link rel="stylesheet" href="assets/css/owl.css">
    <link rel="stylesheet" href="assets/css/animate.css">
    <link rel="stylesheet"href="https://unpkg.com/swiper@7/swiper-bundle.min.css"/>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>





<header class="header-area header-sticky" style="background-color: aqua;top: 0;">
    <div class="container" >
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
                <div class="col-lg-12">

                    <!-- Close Button (Top Right) -->
                    <span class="close-btn" onclick="closePopup()">&times;</span>


                    <h2>Customer Details</h2>
                    <form id="customerForm" method="post" action="UpdateCustomerServlet">
                        <input type="hidden" name="customerId" value="<%=c.getCustomerId()%>"/>

                        <label>Account Number:</label>
                        <div class="input-container">
                            <input type="text" id="accountNumber" name="accountNumber" value="<%=c.getAccountNumber()%>"  readonly>

                        </div>
                        <label>Customer Name:</label>
                        <div class="input-container">
                            <input type="text" id="Customer_Name" name="Customer_Name" value="<%=c.getName()%>" required readonly>
                            <i class="fas fa-edit edit-icon" onclick="enableEdit('Customer_Name')"></i>
                        </div>
                        <label>Phone Number</label>
                        <div class="input-container">
                            <input type="text" id="Phone_no" name="Phone_no" value="<%=c.getPhone()%>" required pattern="\d{10}" readonly>
                            <i class="fas fa-edit edit-icon" onclick="enableEdit('Phone_no')"></i>
                        </div>
                        <label>Email</label>
                        <div class="input-container">
                            <input type="email" id="email" name="email" value="<%=c.getEmail()%>" required  readonly>
                            <i class="fas fa-edit edit-icon" onclick="enableEdit('email')"></i>
                        </div>
                        <label>Address</label>
                        <div class="input-container">
                            <input type="text" id="address" name="address" value="<%=c.getAddress()%>" required readonly>
                            <i class="fas fa-edit edit-icon" onclick="enableEdit('address')"></i>
                        </div>



                        <div class="button-container">
                            <button type="submit" class="update-btn">Update</button>

                            <form method="post" action="DeleteCustomerServlet">
                                <input type="hidden" name="customer_id" value="<%=c.getCustomerId()%>"/>
                                <button type="submit" class="delete-btn">Delete</button>
                            </form>
                        </div>
                    </form>


                </div>
            </div>
            <div class="col-lg-6">
                <div class="right-content">
                    <div class="row">

                        <!-- Purchase History Table -->
                        <div class="col-12">
                            <h4 style="margin-bottom: 15px;">Purchase History</h4>
                            <div class="table-container">
                                <table class="table table-bordered table-striped">
                                    <thead class="table-dark">
                                    <tr>
                                        <th>Date</th>
                                        <th>Time</th>
                                        <th>Seller Name</th>
                                        <th>Total</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <% for(Map<String,Object> row : history){ %>
                                    <tr>
                                        <td><%=row.get("date")%></td>
                                        <td><%=row.get("time")%></td>
                                        <td><%=row.get("seller")%></td>
                                        <td>Rs. <%=row.get("total")%></td>
                                    </tr>
                                    <% } %>
                                    </tbody>
                                </table>
                            </div>
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



<!-- CSS Styling -->
<style>
    .popup-overlay {
        position: fixed;
        top: 0; left: 0;
        width: 100%; height: 100%;
        background: rgba(0,0,0,0.5);
        display: none;
        justify-content: center;
        align-items: center;
    }

    .popup-content {
        position: relative;
        background: #fff;
        padding: 20px;
        width: 400px;
        border-radius: 10px;
        box-shadow: 0 0 10px #333;
    }

    .close-btn {
        position: absolute;
        top: 10px;
        right: 15px;
        font-size: 20px;
        cursor: pointer;
        color: #333;
    }

    .input-container {
        position: relative;
        margin-bottom: 12px;
    }

    input[disabled] {
        background-color: #eee;
        border: 1px solid #ccc;
        width: 100%;
        padding: 8px;
        padding-right: 35px;
        border-radius: 5px;
    }

    input {
        width: 100%;
        padding: 8px;
        padding-right: 35px;
        border-radius: 5px;
    }

    .edit-icon {
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        cursor: pointer;
        color: #555;
    }

    .button-container {
        text-align: center;
        margin-top: 15px;
    }

    .update-btn, .delete-btn, .close-btn-bottom {
        padding: 8px 12px;
        margin: 5px;
        border: none;
        cursor: pointer;
        border-radius: 5px;
        font-size: 14px;
    }

    .update-btn { background-color: #28a745; color: white; }
    .delete-btn { background-color: #dc3545; color: white; }
    .close-btn-bottom { background-color: #6c757d; color: white; }
</style>

<!-- JS Functionality -->
<script>
    function enableEdit(fieldId) {
        document.getElementById(fieldId).readOnly = false;
        document.getElementById(fieldId).focus();
    }
    function closePopup() {
        // example: redirect, hide div, etc.
        window.location.href = "somepage.jsp"; // or customize popup behavior
    }


</script>

</body>
</html>

