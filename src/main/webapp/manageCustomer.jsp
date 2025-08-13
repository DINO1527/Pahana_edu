<%@ page import="java.util.List" %>
<%@ page import="business.customer.dto.CustomerDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%!
    String safe(Object o) {
        return (o == null) ? "" : o.toString();
    }
%>

<%
    List<CustomerDTO> customers = (List<CustomerDTO>) request.getAttribute("customers");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Customer List</title>
    <meta charset="UTF-8"/>
    <style>
        body { font-family: Arial, sans-serif; }
        table { border-collapse: collapse; width: 100%; margin-top: 10px; }
        th, td { border: 1px solid #ddd; padding: 8px; vertical-align: top; }
        th { background: #f5f5f5; text-align: left; }
        .actions a { display: inline-block; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
        .btn-edit { background: #1976d2; color: #fff; }
    </style>
</head>
<body>
<h2>All Customers</h2>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Account #</th>
        <th>Name</th>
        <th>Address</th>
        <th>Phone</th>
        <th>Email</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        if (customers != null && !customers.isEmpty()) {
            for (CustomerDTO c : customers) {
    %>
    <tr>
        <td><%= c.getCustomerId() %></td>
        <td><%= safe(c.getAccountNumber()) %></td>
        <td><%= safe(c.getName()) %></td>
        <td><%= safe(c.getAddress()) %></td>
        <td><%= safe(c.getPhone()) %></td>
        <td><%= safe(c.getEmail()) %></td>
        <td class="actions">
            <a class="btn-edit" href="<%= request.getContextPath() %>/EditCustomerServlet?customerId=<%= c.getCustomerId() %>">Edit</a>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr><td colspan="8">No customers found.</td></tr>
    <%
        }
    %>
    </tbody>
</table>
</body>
</html>
