<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="business.book.dto.BookDTO" %>

<%
    BookDTO book = (BookDTO) request.getAttribute("book");
    boolean editMode = request.getAttribute("editMode") != null && (boolean) request.getAttribute("editMode");

%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap"
          rel="stylesheet">

    <title>Lugx Gaming Template - Contact Page</title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">


    <!-- Additional CSS Files -->
    <link rel="stylesheet" href="assets/css/fontawesome.css">
    <link rel="stylesheet" href="assets/css/templatemo-lugx-gaming.css">
    <link rel="stylesheet" href="assets/css/owl.css">
    <link rel="stylesheet" href="assets/css/animate.css">
    <link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css"/>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


    <title><%= editMode ? "Edit Book" : "Add Book" %>
    </title>

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
<%
    String success = (String) request.getAttribute("success");
    String error = (String) request.getAttribute("error");
    if (success != null) {
%>
<script>
    Swal.fire({
        icon: 'success',
        title: 'Success!',
        text: '<%= success %>',
        timer: 2000,               // auto close after 2s
        showConfirmButton: false
    }).then(() => {
        window.location.href = "bookInventory"; // redirect after alert closes
    });
</script>
<%
} else if (error != null) {
%>
<script>
    Swal.fire({
        icon: 'error',
        title: 'Error!',
        text: '<%= error %>'
    });
</script>
<%
    }
%>


<header class="header-area header-sticky" style="background-color: aqua;top: 0;">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <nav class="main-nav">
                    <!-- ***** Logo Start ***** -->
                    <a href="index.html" class="logo">
                        <img src="assets/images/logo.png" alt="" style="width: 158px;">
                    </a>
                    <!-- ***** Logo End ***** -->
                    <!-- ***** Menu Start ***** -->
                    <ul class="nav active">
                        <li><%= editMode ? "Edit Book" : "Add New Book" %>
                        </li>
                    </ul>
                    <ul class="nav">
                        <li><a href="manageItems.jsp">❌</a></li>
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
                <div class="left-text">
                    <div class="section-heading">
                        <h6>Welcome to Pahana Edu Book Shop</h6>
                        <h2>Register new customer</h2>
                    </div>
                    <p>Pahana Edu Book Shop is your trusted source for educational books and materials. Use the form
                        below to register a new customer in our system.</p>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="right-content">
                    <div class="row">

                        <div class="col-lg-12">
                            <form action="<%= editMode ? "editBook" : "addBook" %>" method="post"
                                  enctype="multipart/form-data">

                                <div class="row">

                                    <%-- Hidden field for Book ID in edit mode --%>
                                    <% if (editMode && book != null) { %>
                                    <input type="hidden" name="bookId" value="<%= book.getBookId() %>">
                                    <% } %>

                                    <div class="col-lg-6">
                                        <div class="input-container">
                                            <input type="text" name="bookName"
                                                   value="<%= (book != null) ? book.getBookName() : "" %>" required
                                                   placeholder=" ">
                                            <label>Book Name</label>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="input-container">
                                            <input type="number" step="0.01" name="price"
                                                   value="<%= (book != null && book.getPrice() != null) ? book.getPrice() : "" %>"
                                                   required placeholder=" "/>
                                            <label>Price</label>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="input-container">
                                            <input type="number" name="stock"
                                                   value="<%= (book != null) ? book.getStock() : "" %>" required
                                                   placeholder=" "/>
                                            <label>Stock Availability</label>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="input-container">
                                            <%
                                                boolean hasImage = editMode && book != null && book.getBookImage() != null;
                                                String base64Image = hasImage ? java.util.Base64.getEncoder().encodeToString(book.getBookImage()) : "";
                                            %>

                                            <label id="chooseLabel"
                                                   style="<%= hasImage ? "display:none;" : "" %>; cursor:pointer;"
                                                   onclick="document.getElementById('bookImageInput').click()">Choose Image</label>

                                            <img
                                                    id="previewImage"
                                                    src="<%= hasImage ? "data:image/jpeg;base64," + base64Image : "#" %>"
                                                    alt="Preview"
                                                    style="width:60px; height:80px; <%= hasImage ? "" : "display:none;" %>; cursor:pointer;"
                                                    onclick="document.getElementById('bookImageInput').click()"
                                            >

                                            <input
                                                    type="file"
                                                    id="bookImageInput"
                                                    name="bookImage"
                                                    accept="image/*"
                                                <%= editMode ? "" : "required" %>
                                                    style="display:none;"
                                            >
                                        </div>

                                    </div>

                                    <div class="col-lg-12">
                                        <fieldset>
                                            <button type="submit"><%= editMode ? "Update Book" : "Add Book" %>
                                            </button>
                                        </fieldset>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById('bookImageInput').addEventListener('change', function(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const preview = document.getElementById('previewImage');
                preview.src = e.target.result;
                preview.style.display = 'inline';

                const label = document.getElementById('chooseLabel');
                label.style.display = 'none';
            };
            reader.readAsDataURL(file);
        }
    });
</script>

<!-- Bootstrap core JavaScript -->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="assets/js/isotope.min.js"></script>
<script src="assets/js/owl-carousel.js"></script>
<script src="assets/js/counter.js"></script>
<script src="assets/js/custom.js"></script>
</body>
</html>
