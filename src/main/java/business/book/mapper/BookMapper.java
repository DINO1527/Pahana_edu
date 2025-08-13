package business.book.mapper;


import business.book.dto.BookDTO;
import business.book.model.Book;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;

public class BookMapper {
    public static BookDTO map(ResultSet rs) throws SQLException {
        int id = rs.getInt("book_id");
        String name = rs.getString("book_name");
        byte[] image = rs.getBytes("book_image"); // <-- Added

        BigDecimal price = rs.getBigDecimal("price");
        int stock = rs.getInt("stock");
        int sold = rs.getInt("sold_count");

        BookDTO dto = new BookDTO(id, name, price, stock, sold);
        dto.setBookImage(image); // <-- Added
        return dto;
    }

    public static Book toModel(BookDTO dto) {
        Book book = new Book();
        book.setBookName(dto.getBookName());
        book.setBookImage(dto.getBookImage());
        book.setPrice(dto.getPrice());
        book.setStock(dto.getStock());
        return book;
    }
}
