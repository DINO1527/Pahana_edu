package controler;


import business.book.dto.BookDTO;
import business.book.service.BookService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/bookInventory")
public class BookInventoryServlet extends HttpServlet {
    private final BookService service = new BookService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String search = req.getParameter("search");

        try {
            List<BookDTO> books = service.getBooks(search);
            req.setAttribute("books", books);
            req.getRequestDispatcher("/manageItems.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}

