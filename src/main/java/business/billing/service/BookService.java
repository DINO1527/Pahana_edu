package business.billing.service;


import business.billing.dto.BookDTO;
import business.billing.mapper.BookMapper;
import business.billing.model.Book;
import persistence.billing.BookDAO;

public class BookService {
    private BookDAO bookDAO = new BookDAO();

    public BookDTO getBookDetails(int bookId) {
        Book book = bookDAO.getBookDetails(bookId);
        if (book != null) {
            return BookMapper.toDTO(book);
        }
        return null;
    }
}
