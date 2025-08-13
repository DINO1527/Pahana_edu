package business.book.service;


import business.book.dto.BookDTO;
import business.book.mapper.BookMapper;
import business.book.model.Book;
import persistence.book.BookDAO;

import java.sql.SQLException;
import java.util.List;


public class BookService {
    private final BookDAO dao = new BookDAO();
    public byte[] getBookImageById(int bookId) {
        return dao.getBookImageById(bookId);
    }

    public List<BookDTO> getBooks(String search) throws SQLException {
        return dao.getBooks(search);
    }


    //add book
    public boolean saveBook(BookDTO dto) throws Exception {
        Book book = BookMapper.toModel(dto);
        return dao.addBook(book);
    }

    //editbook
    public BookDTO getBookById(int bookId) throws Exception {
        return dao.getBookById(bookId);
    }

    public boolean updateBook(BookDTO dto) throws Exception {
        Book book = BookMapper.toModel(dto);
        book.setBookId(dto.getBookId());
        return dao.updateBook(book);
    }

}
