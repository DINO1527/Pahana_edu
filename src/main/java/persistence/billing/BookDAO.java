package persistence.billing;

import business.billing.dto.BookDTO;
import business.billing.mapper.BookMapper;
import business.billing.model.Book;
import persistence.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
    public BookDTO findBookById(int bookId) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM books WHERE book_id=?")) {

            ps.setInt(1, bookId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("book_id"));
                book.setBookName(rs.getString("book_name"));
                book.setPrice(rs.getDouble("price"));
                book.setStockQty(rs.getInt("stock"));

                return BookMapper.toDTO(book); // now valid
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    public boolean updateBookQuantity(int bookId, int newQuantity) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE books SET stock=? WHERE book_id=?")) {
            ps.setInt(1, newQuantity);
            ps.setInt(2, bookId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
