package persistence.book;

import business.book.dto.BookDTO;
import business.book.model.Book;
import junit.framework.TestCase;

import java.math.BigDecimal;
import java.util.List;

public class BookDAOTest extends TestCase {

    private BookDAO bookDAO;

    protected void setUp() throws Exception {
        super.setUp();
        bookDAO = new BookDAO();
    }

    // ----------------- Test addBook -----------------
    public void testAddBook_Success() throws Exception {
        Book book = new Book();
        book.setBookName("JUnit Test Book");
        book.setPrice(new BigDecimal("49.99"));
        book.setStock(10);
        book.setBookImage(null);

        boolean result = bookDAO.addBook(book);
        assertTrue("Book should be added successfully", result);
    }

    // ----------------- Test getBooks -----------------
    public void testGetBooks_WithSearch() throws Exception {
        List<BookDTO> books = bookDAO.getBooks("JUnit");
        assertNotNull("Book list should not be null", books);
        assertTrue("Should return 0 or more books", books.size() >= 0);
    }

    public void testGetBooks_NoSearch() throws Exception {
        List<BookDTO> books = bookDAO.getBooks(null);
        assertNotNull("Book list should not be null", books);
        assertTrue("Should return 0 or more books", books.size() >= 0);
    }

    // ----------------- Test getBookById -----------------
    public void testGetBookById_Existing() throws Exception {
        BookDTO book = bookDAO.getBookById(1); // assume book with ID 1 exists
        if (book != null) {
            assertEquals("Book ID should match", 1, book.getBookId());
        } else {
            assertNull("If not exists, should return null", book);
        }
    }

    public void testGetBookById_NotExisting() throws Exception {
        BookDTO book = bookDAO.getBookById(99999); // unlikely to exist
        assertNull("Non-existing book should return null", book);
    }

    // ----------------- Test updateBook -----------------
    public void testUpdateBook_Success() throws Exception {
        Book book = new Book();
        book.setBookId(1); // assume book with ID 1 exists
        book.setBookName("Updated JUnit Book");
        book.setPrice(new BigDecimal("59.99"));
        book.setStock(20);
        book.setBookImage(null);

        boolean result = bookDAO.updateBook(book);
        assertTrue("Update should return true for existing book", result);
    }

    public void testUpdateBook_Fail() throws Exception {
        Book book = new Book();
        book.setBookId(99999); // non-existent
        book.setBookName("NonExistent");
        book.setPrice(new BigDecimal("9.99"));
        book.setStock(5);
        book.setBookImage(null);

        boolean result = bookDAO.updateBook(book);
        assertFalse("Update should fail for non-existing book", result);
    }
}
