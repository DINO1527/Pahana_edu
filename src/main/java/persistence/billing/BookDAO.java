package persistence.billing;

import business.billing.model.Book;
import persistence.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BookDAO {

    public Book getBookDetails(int bookId) {
        String sql = "SELECT book_id, book_name, price FROM books WHERE book_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bookId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("book_id"));
                book.setBookName(rs.getString("book_name"));
                book.setPrice(rs.getDouble("price"));
                return book;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
