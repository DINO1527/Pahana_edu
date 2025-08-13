package controler;

import business.billing.dto.BookDTO;
import business.billing.service.BookService; // make sure this import matches your package

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/GetPriceServlet")
public class GetPriceServlet extends HttpServlet {

    private BookService bookService = new BookService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");

        if ("getBookDetails".equals(action)) {
            try {
                int bookId = Integer.parseInt(req.getParameter("bookId"));
                BookDTO bookDTO = bookService.getBookDetails(bookId);

                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");

                if (bookDTO != null) {
                    resp.getWriter().write("{\"name\":\"" + bookDTO.getBookName() + "\",\"price\":" + bookDTO.getPrice() + "}");
                } else {
                    resp.getWriter().write("{}");
                }
            } catch (NumberFormatException e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid bookId");
            }
        }
    }
}
