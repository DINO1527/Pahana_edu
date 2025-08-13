package controler;

import business.book.dto.BookDTO;
import business.book.service.BookService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;

@WebServlet("/editBook")
@MultipartConfig(maxFileSize = 16177215) // 16MB
public class EditBookServlet extends HttpServlet {
    private final BookService service = new BookService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        try {
            BookDTO book = service.getBookById(bookId);
            request.setAttribute("book", book);
            request.setAttribute("editMode", true);
            request.getRequestDispatcher("/addBook.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            BookDTO existingBook = service.getBookById(bookId); // fetch existing to keep old image

            BookDTO dto = new BookDTO();
            dto.setBookId(bookId);
            dto.setBookName(request.getParameter("bookName"));
            dto.setPrice(new BigDecimal(request.getParameter("price")));
            dto.setStock(Integer.parseInt(request.getParameter("stock")));

            Part filePart = request.getPart("bookImage");
            if (filePart != null && filePart.getSize() > 0) {
                try (InputStream inputStream = filePart.getInputStream()) {
                    dto.setBookImage(inputStream.readAllBytes());
                }
            } else {
                // Keep the old image if no new image uploaded
                dto.setBookImage(existingBook.getBookImage());
            }

            if (service.updateBook(dto)) {
                response.sendRedirect("manageCustomer");
            } else {
                response.sendRedirect("error.jsp");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
