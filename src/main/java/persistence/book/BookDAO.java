package persistence.book;


import business.book.dto.BookDTO;
import business.book.mapper.BookMapper;
import business.book.model.Book;
import persistence.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class BookDAO {

    public List<BookDTO> getBooks(String searchQuery) throws SQLException {
        List<BookDTO> books = new ArrayList<>();

        String baseSql = """
       SELECT b.book_id,
           b.book_name,
           b.price,
           b.stock,
           b.book_image,
           COALESCE(SUM(bi.quantity), 0) AS sold_count
    FROM books b
    LEFT JOIN bill_items bi ON b.book_id = bi.book_id
    """;

        String where = "";
        boolean hasSearch = searchQuery != null && !searchQuery.trim().isEmpty();
        if (hasSearch) {
            where = " WHERE (b.book_name LIKE ? OR CAST(b.book_id AS CHAR) LIKE ?)";
        }

        String groupOrder = """
        GROUP BY b.book_id, b.book_name,b.book_image, b.price, b.stock
        ORDER BY b.book_id DESC
        """;

        String sql = baseSql + where + groupOrder;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (hasSearch) {
                String like = "%" + searchQuery.trim() + "%";
                ps.setString(1, like);
                ps.setString(2, like);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    books.add(BookMapper.map(rs));
                }
            }
        }
        return books;
    }

    public boolean addBook(Book book) throws SQLException {
        String sql = "INSERT INTO books (book_name, book_image, price, stock) VALUES (?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, book.getBookName());
            stmt.setBytes(2, book.getBookImage());
            stmt.setBigDecimal(3, book.getPrice());
            stmt.setInt(4, book.getStock());
            return stmt.executeUpdate() > 0;
        }
    }

    public byte[] getBookImageById(int bookId) {
        String sql = "SELECT image FROM books WHERE book_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bookId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Blob imageBlob = rs.getBlob("image");
                    return imageBlob != null ? imageBlob.getBytes(1, (int) imageBlob.length()) : null;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Consider logging this properly
        }
        return null;
    }

    public BookDTO getBookById(int bookId) throws SQLException {
        String sql = "SELECT book_id, book_name, price, stock, book_image FROM books WHERE book_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, bookId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    BookDTO dto = new BookDTO();
                    dto.setBookId(rs.getInt("book_id"));
                    dto.setBookName(rs.getString("book_name"));
                    dto.setPrice(rs.getBigDecimal("price"));
                    dto.setStock(rs.getInt("stock"));
                    dto.setBookImage(rs.getBytes("book_image"));
                    return dto;
                }
            }
        }
        return null;
    }

    public boolean updateBook(Book book) throws SQLException {
        String sql = "UPDATE books SET price=?, stock=?, book_image=? WHERE book_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setBigDecimal(1, book.getPrice());
            stmt.setInt(2, book.getStock());
            stmt.setBytes(3, book.getBookImage());
            stmt.setInt(4, book.getBookId());
            return stmt.executeUpdate() > 0;
        }
    }

}



