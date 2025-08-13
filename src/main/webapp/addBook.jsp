<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="business.book.dto.BookDTO" %>
<%
    BookDTO book = (BookDTO) request.getAttribute("book");
    boolean editMode = request.getAttribute("editMode") != null && (boolean) request.getAttribute("editMode");
%>
<html>
<head>
    <title><%= editMode ? "Edit Book" : "Add Book" %></title>
</head>
<body>
<h2><%= editMode ? "Edit Book" : "Add New Book" %></h2>

<form action="<%= editMode ? "editBook" : "addBook" %>" method="post" enctype="multipart/form-data">

    <%-- Hidden field for Book ID in edit mode --%>
    <% if (editMode && book != null) { %>
    <input type="hidden" name="bookId" value="<%= book.getBookId() %>">
    <% } %>

    <label>Book Name:</label><br>
    <input type="text" name="bookName" value="<%= (book != null) ? book.getBookName() : "" %>" required><br><br>

    <label>Price:</label><br>
    <input type="number" step="0.01" name="price" value="<%= (book != null && book.getPrice() != null) ? book.getPrice() : "" %>" required><br><br>

    <label>Stock:</label><br>
    <input type="number" name="stock" value="<%= (book != null) ? book.getStock() : "" %>" required><br><br>

    <label>Book Image:</label><br>
    <% if (editMode && book != null && book.getBookImage() != null) { %>
    <%
        String base64Image = java.util.Base64.getEncoder().encodeToString(book.getBookImage());
    %>
    <img src="data:image/jpeg;base64,<%= base64Image %>" width="60" height="80"><br>
    <small>Leave blank to keep existing image</small><br>
    <% } %>
    <input type="file" name="bookImage" accept="image/*" <%= editMode ? "" : "required" %>><br><br>

    <button type="submit"><%= editMode ? "Update Book" : "Add Book" %></button>
</form>

</body>
</html>
