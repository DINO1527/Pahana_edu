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

    // Determine current request URI to mark active nav item
    String uri = request.getRequestURI() != null ? request.getRequestURI().toLowerCase() : "";

    boolean isDashboard = uri.contains("dashboard") || uri.endsWith("/") || uri.equals(request.getContextPath() + "/");
    boolean isBill = uri.contains("calculateBill.jsp") || uri.contains("calculate")|| uri.contains("BillServlet");
    boolean isCustomer = uri.contains("managecustomer") || uri.contains("customer");
    boolean isInventory = uri.contains("manageitems") || uri.contains("inventory") || uri.contains("item");

    // Decide which help section to open (maps to help.jsp#<sectionId>)
    String helpSection = "toc";
    if (isBill) helpSection = "billing";
    else if (isCustomer) helpSection = "customer";
    else if (isInventory) helpSection = "inventory";
    else if (isDashboard) helpSection = "dashboard";
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
                        <li><a href="dashboard.jsp" class='<%= isDashboard ? "active" : "" %>'>Home</a></li>
                        <li><a href="calculateBill.jsp" class='<%= isBill ? "active" : "" %>'>Bill</a></li>
                        <li><a href="manageCustomer" class='<%= isCustomer ? "active" : "" %>'>Customer</a></li>
                        <li><a href="manageItems.jsp" class='<%= isInventory ? "active" : "" %>'>Inventory</a></li>

                        <!-- Context-sensitive Help -->
                        <li>
                            <a href="Help.jsp#<%= helpSection %>">
                                <i class="fas fa-question-circle"></i> Help
                            </a>
                        </li>

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
