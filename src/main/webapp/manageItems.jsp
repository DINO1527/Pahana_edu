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

<html>
<head>
    <title>Title</title>
</head>
<body>
<h2>Book Inventory</h2>
<form method="get" action="bookInventory" class="search-bar">
    <input type="text" name="search"
           placeholder="Search by ID or Name"
           value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
    <button type="submit">Search</button>
</form>

<table>
    <tr>
        <th>Book ID</th>
        <th>Image</th>
        <th>Book Name</th>
        <th>Stock</th>
        <th>Sold Count</th>
        <th> </th>
    </tr>
    <%
        if (books != null) {
            for (BookDTO book : books) {
                String base64Image = book.getBookImage() != null
                        ? java.util.Base64.getEncoder().encodeToString(book.getBookImage())
                        : null;
    %>
    <tr>
        <td><%= book.getBookId() %></td>
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
       <td> <button onclick="editBook(<%= book.getBookId() %>)">
           <i class="fa fa-edit"></i>
       </button></td>

    </tr>
    <%      }
    }
    %>
</table>
<script>function editBook(bookId) {
    window.location.href = 'editbook?bookId=' + bookId;
}</script>
</body>
</html>
