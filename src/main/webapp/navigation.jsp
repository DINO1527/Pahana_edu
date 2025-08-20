<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession session1 = request.getSession(false);
    Integer userId = (session1 != null) ? (Integer) session1.getAttribute("userId") : null;
    String username = (session1 != null) ? (String) session1.getAttribute("username") : null;
%>

<header class="header-area header-sticky">
    <div class="container" style="color: #fc7e38;">
        <div class="row">
            <div class="col-12">
                <nav class="main-nav">
                    <!-- ***** Logo Start ***** -->
                    <a href="index.html" class="logo">
                        <img src="assets/images/logo.png" alt="" style="width: 80px;">

                    </a>
                    <a>Pahana edu </a>
                    <!-- ***** Logo End ***** -->
                    <!-- ***** Menu Start ***** -->
                    <ul class="nav">
                        <li><a href="dashboard.jsp" class="active">Home</a></li>
                        <li><a href="calculateBill.jsp">Bill</a></li>
                        <li><a href="manageCustomer">Customer</a></li>
                        <li><a href="manageItems.jsp">inventory</a></li>
                        <li><% if (userId != null) { %>
                            <span>Welcome, <%= userId %>!</span>
                            <a href="logout.jsp" >Logout</a>
                            <% } else { %>
                            <a href="login.jsp" >Login</a>
                            <% } %></li>
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