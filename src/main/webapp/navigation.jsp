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
    <div class="container" style="color: rgba(252,126,56,0.63);">
        <div class="row">
            <div class="col-12">
                <nav class="main-nav">
                    <!-- ***** Logo Start ***** -->
                    <a href="dashboard.jsp" class="logo">
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
                                <i class="fas fa-question-circle" style="color: #fc7e38;font-size: 28px;margin-top: 6px;"></i>
                            </a>
                        </li>

                        <li >
                            <a href="javascript:void(0)" class="nav-link user-info-btn" onclick="openUserSidebar()">
                                <i class="fas fa-user-circle" style="color: #fc7e38;font-size: 28px;"></i>
                            </a>
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
<style>
    /* Sidebar base */
    .user-sidebar {
        position: fixed;
        top: 0;
        right: -400px; /* hidden initially */
        width: 350px;
        height: 100%;
        background: #fff;
        box-shadow: -2px 0 15px rgba(0,0,0,0.2);
        transition: right 0.4s ease;
        z-index: 9999;
        border-left: 5px solid rgba(252, 126, 56, 0.63);
        display: flex;
        flex-direction: column;
    }

    /* Show when active */
    .user-sidebar.active {
        right: 0;
    }

    .sidebar-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 15px;
        border-bottom: 1px solid #ddd;
    }
    .sidebar-header h3 {
        margin: 0;
        color: #fc7e38;
    }
    .close-btn {
        font-size: 20px;
        cursor: pointer;
        color: #fc7e38;
    }

    .sidebar-content {
        padding: 20px;
        flex: 1;
        overflow-y: auto;
    }

    .profile-pic {
        width: 90px; height: 90px;
        border-radius: 50%;
        border: 3px solid rgba(252, 126, 56, 0.63);
        margin-bottom: 10px;
    }
    .user-header {
        text-align: center;
        margin-bottom: 20px;
    }

    .form-group { margin-bottom: 15px; }
    .form-group input {
        width: 100%; padding: 10px;
        border: 1px solid #ccc;
        border-radius: 8px;
        background: #f8f8f8;
    }
    .form-group input[readonly],
    .form-group input[disabled] {
        background: #eee;
        color: #666;
    }


    .btn-save {
        background: #fc7e38;
        border: none;
        padding: 10px 15px;
        border-radius: 8px;
        color: white;
        font-weight: bold;
        width: 100%;
        cursor: pointer;
    }
    .btn-save:hover {
        background: rgba(252, 126, 56, 0.63);
    }

</style>
<!-- User Dashboard Popup -->
<!-- User Sidebar (Hidden by default) -->
<!-- User Sidebar -->
<div id="userSidebar" class="user-sidebar">
    <div class="sidebar-header">
        <span class="close-btn" onclick="closeUserSidebar()">&times;</span>
        <h3>User Profile</h3>
    </div>

    <div class="sidebar-content">
        <div class="user-header">
            <img src="assets/images/user.png" alt="Profile" class="profile-pic">
        </div>

        <!-- Non-editable user info -->
        <div class="form-group">
            <label>Staff ID</label>
            <input type="text" value="<%= userId %>" readonly>
        </div>

        <div class="form-group">
            <label>Username</label>
            <input type="text" value="<%= username %>" readonly>
        </div>

        <div class="form-group">
            <label>Role</label>
            <input type="text" value="Staff" readonly>
        </div>

        <button class="btn-save" onclick="showPasswordForm()">Update Password</button>

        <!-- Password Update Form (hidden initially) -->
        <form id="updateUserForm" method="post" action="UserController" style="display:none;">
            <input type="hidden" name="action" value="updatePassword">

            <div class="form-group">
                <label>Current Password</label>
                <input type="password" name="current_password" required>
            </div>

            <div class="form-group">
                <label>New Password</label>
                <input type="password" id="new_password" name="new_password" required>
            </div>

            <div class="form-group">
                <label>Confirm Password</label>
                <input type="password" name="confirm_password" required>
            </div>

            <small>Password must be at least 5 characters, contain 1 number and 1 symbol.</small>
            <button type="submit" class="btn-save">Save Changes</button>
        </form>
    </div>
</div>


<script>
    function openUserSidebar() {
        document.getElementById("userSidebar").classList.add("active");
    }
    function closeUserSidebar() {
        document.getElementById("userSidebar").classList.remove("active");

    }
    function showPasswordForm() {
        document.getElementById("updateUserForm").style.display = "block";
    }

    function enablePasswordEdit() {
        const pwdInput = document.getElementById("password");
        const saveBtn = document.getElementById("saveBtn");
        pwdInput.disabled = false;
        pwdInput.focus();
        saveBtn.style.display = "block";
    }

    // Password validation before submit
    document.getElementById("updateUserForm").addEventListener("submit", function(e) {
        const pwd = document.getElementById("password").value;
        const regex = /^(?=.*[0-9])(?=.*[!@#$%^&*])[A-Za-z0-9!@#$%^&*]{5,}$/;
        if (!regex.test(pwd)) {
            alert("Password must be at least 5 characters long, include one number and one symbol.");
            e.preventDefault();
        }
    });
</script>

