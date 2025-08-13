package business.customer.model;

import java.sql.Timestamp;

public class Customer {
    private String accountNumber;
    private String name;
    private String address;
    private String phone;
    private String email;
    private int customerId;
    private Timestamp createdAt;

    public Customer(int customerId, String accountNumber, String name, String address, String phone, String email) {
        this.customerId = customerId;
        this.accountNumber = accountNumber;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.email = email;
    }

    public Customer() {

    }

    // Getters and Setters
    public String getAccountNumber() {

        return accountNumber;
    }
    public void setAccountNumber(String accountNumber) {

        this.accountNumber = accountNumber;
    }
    public String getName() {

        return name;
    }
    public void setName(String name) {

        this.name = name;
    }
    public String getAddress() {

        return address;
    }
    public void setAddress(String address) {

        this.address = address;
    }
    public String getPhone() {

        return phone;
    }
    public void setPhone(String phone) {

        this.phone = phone;
    }
    public String getEmail() {

        return email;
    }
    public void setEmail(String email) {

        this.email = email;
    }

    public int getCustomerId() {

        return customerId;
    }

    public void setCustomerId(int customerId) {

        this.customerId = customerId;
    }

    public void setCreatedAt(Timestamp createdAt) {

        this.createdAt = createdAt;
    }
    public Timestamp getCreatedAt() {

        return createdAt;
    }
}