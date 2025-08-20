package business.billing.mapper;


import business.billing.dto.BookDTO;
import business.billing.model.Book;

public class BookMapper {

    public static BookDTO toDTO(Book book) {
        BookDTO dto = new BookDTO();
        dto.setBookId(book.getBookId());
        dto.setBookName(book.getBookName());
        dto.setPrice(book.getPrice());
        dto.setStockQty(book.getStockQty());
        return dto;
    }

    public static Book toEntity(BookDTO dto) {
        Book book = new Book();
        book.setBookId(dto.getBookId());
        book.setBookName(dto.getBookName());
        book.setPrice(dto.getPrice());
        return book;
    }
}
