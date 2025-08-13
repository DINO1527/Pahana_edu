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

@WebServlet("/addBook")
@MultipartConfig(maxFileSize = 16177215) // 16MB
public class AddBookServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BookDTO dto = new BookDTO();
        dto.setBookName(request.getParameter("bookName"));
        dto.setPrice(new BigDecimal(request.getParameter("price")));
        dto.setStock(Integer.parseInt(request.getParameter("stock")));

        Part filePart = request.getPart("bookImage");
        if (filePart != null) {
            try (InputStream inputStream = filePart.getInputStream()) {
                dto.setBookImage(inputStream.readAllBytes());
            }
        }


            BookService service = new BookService();
        try {
            if (service.saveBook(dto)) {
                response.sendRedirect("success.jsp");
            } else {
                response.sendRedirect("error.jsp");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }
}
