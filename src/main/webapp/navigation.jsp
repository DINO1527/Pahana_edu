<%@ page import="javax.servlet.http.HttpSession" %>
<%
    // Disable caching (so user cannot go back after logout using browser back button)

    HttpSession session1 = request.getSession(false);

    if (session1 == null || session1.getAttribute("userId") == null) {
        if (session1 != null) {
            session1.invalidate(); // Clear session if exists
        }
        response.sendRedirect("logout.jsp");
        return; // Stop further execution
    }

    Integer userId = (Integer) session1.getAttribute("userId");
    String username = (String) session1.getAttribute("username");
%>


<header class="header-area header-sticky">
    <div class="container" style="color: #fc7e38;">
        <div class="row">
            <div class="col-12">
                <nav class="main-nav">
                    <!-- ***** Logo Start ***** -->
                    <a href="index.jsp" class="logo">
                        <img src="assets/images/logo.png" alt="" style="width: 80px;">
                    </a>
                    <a>Pahana Edu</a>
                    <!-- ***** Logo End ***** -->

                    <!-- ***** Menu Start ***** -->
                    <ul class="nav">
                        <li><a href="dashboard.jsp" class="active">Home</a></li>
                        <li><a href="calculateBill.jsp">Bill</a></li>
                        <li><a href="manageCustomer">Customer</a></li>
                        <li><a href="manageItems.jsp">Inventory</a></li>

                        <li>
                            <span>Welcome, <%= (username != null ? username : userId) %>!</span>
                        </li>
                        <li>
                            <a href="logout.jsp">Logout</a>
                        </li>
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
