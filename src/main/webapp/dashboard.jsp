<%--
  Created by IntelliJ IDEA.
  User: Dino_E
  Date: 21/07/2025
  Time: 20:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>PahanaEdu Dashboard</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<div class="container">
    <nav class="sidebar">
        <h2>PahanaEdu</h2>
        <ul>
            <li><a href="pages/addCustomer.jsp" target="mainFrame">Add Customer</a></li>
            <li><a href="pages/editCustomer.jsp" target="mainFrame">Edit Customer</a></li>
            <li><a href="pages/manageItems.jsp" target="mainFrame">Manage Items</a></li>
            <li><a href="pages/accountDetails.jsp" target="mainFrame">Account Details</a></li>
            <li><a href="pages/billing.jsp" target="mainFrame">Billing</a></li>
            <li><a href="pages/help.jsp" target="mainFrame">Help</a></li>
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </nav>

    <main class="main-content">
        <iframe name="mainFrame" src="pages/accountDetails.jsp"></iframe>
    </main>
</div>
</body>
</html>
