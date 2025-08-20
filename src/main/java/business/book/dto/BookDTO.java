package business.book.dto;



import java.math.BigDecimal;

public class BookDTO {
    private int bookId;
    private String bookName;
    private String author;
    private BigDecimal price;
    private int stock;
    private int soldCount;
    private byte[] bookImage;



    public BookDTO(int bookId, String bookName, BigDecimal price,
                   int stock, int soldCount) {
        this.bookId = bookId;
        this.bookName = bookName;
        this.price = price;
        this.stock = stock;
        this.soldCount = soldCount;

    }

    public BookDTO() {

    }


    public byte[] getBookImage() {
        return bookImage;
    }

    public void setBookImage(byte[] bookImage) {
        this.bookImage = bookImage;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getSoldCount() {
        return soldCount;
    }

    public void setSoldCount(int soldCount) {
        this.soldCount = soldCount;
    }


}
