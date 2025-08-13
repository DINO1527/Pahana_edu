package business.billing.dto;

public class BillItemDTO {
    private int bookId;
    private int quantity;
    private double price;


    public double getSubtotal() {
        return quantity * price;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getQuantity() {
        return quantity;
    }

    public double getPrice() {
        return price;
    }

    // Getters and Setters
}

