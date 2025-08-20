package controler;

import persistence.util.DBConnection;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/CheckStockServlet")
public class CheckStockServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        int qty = Integer.parseInt(request.getParameter("qty"));

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT stock FROM books WHERE book_id=?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, bookId);
                ResultSet rs = ps.executeQuery();

                response.setContentType("application/json");
                PrintWriter out = response.getWriter();

                if (rs.next()) {
                    int stock = rs.getInt("stock");
                    if (qty <= stock) {
                        out.print("{\"status\":\"ok\"}");
                    } else {
                        out.print("{\"status\":\"error\",\"stock\":" + stock + "}");
                    }
                } else {
                    out.print("{\"status\":\"error\",\"msg\":\"Book not found\"}");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
