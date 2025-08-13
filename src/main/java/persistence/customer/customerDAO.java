package persistence.customer;

import business.customer.model.Customer;
import persistence.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;



public class customerDAO {
        public boolean addCustomer(Customer customer) {
            String sql = "INSERT INTO customers (account_number, name, address, phone_number, email) VALUES (?, ?, ?, ?, ?)";
            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, customer.getAccountNumber());
                ps.setString(2, customer.getName());
                ps.setString(3, customer.getAddress());
                ps.setString(4, customer.getPhone());
                ps.setString(5, customer.getEmail());

                return ps.executeUpdate() > 0;

            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        }

        public boolean isAccountNumberExists(String accountNumber) {
            String sql = "SELECT account_number FROM customers WHERE account_number = ?";
            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, accountNumber);
                ResultSet rs = ps.executeQuery();
                return rs.next();

            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        }

        public boolean isPhoneNumberExists(String phone) {
            String sql = "SELECT phone_number FROM customers WHERE phone_number = ?";
            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, phone);
                ResultSet rs = ps.executeQuery();
                return rs.next();

            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        }


        // Get all customers
        public List<Customer> getAllCustomers() {
            List<Customer> list = new ArrayList<>();
            String sql = "SELECT * FROM customers ORDER BY created_at DESC";
            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Customer c = new Customer();
                    c.setCustomerId(rs.getInt("customer_id"));
                    c.setAccountNumber(rs.getString("account_number"));
                    c.setName(rs.getString("name"));
                    c.setAddress(rs.getString("address"));
                    c.setPhone(rs.getString("phone_number"));
                    c.setEmail(rs.getString("email"));
                    c.setCreatedAt(rs.getTimestamp("created_at"));
                    list.add(c);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return list;
        }

        // Get single customer by ID
        public Customer getCustomerById(int id) {
            String sql = "SELECT * FROM customers WHERE customer_id=?";
            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    Customer c = new Customer();
                    c.setCustomerId(rs.getInt("customer_id"));
                    c.setAccountNumber(rs.getString("account_number"));
                    c.setName(rs.getString("name"));
                    c.setAddress(rs.getString("address"));
                    c.setPhone(rs.getString("phone_number"));
                    c.setEmail(rs.getString("email"));
                    c.setCreatedAt(rs.getTimestamp("created_at"));
                    return c;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

        // Update customer
        public boolean updateCustomer(Customer customer) {
            String sql = "UPDATE customers SET account_number=?, name=?, address=?, phone_number=?, email=? WHERE customer_id=?";
            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, customer.getAccountNumber());
                ps.setString(2, customer.getName());
                ps.setString(3, customer.getAddress());
                ps.setString(4, customer.getPhone());
                ps.setString(5, customer.getEmail());
                ps.setInt(6, customer.getCustomerId());
                return ps.executeUpdate() > 0;
            } catch (Exception e) {
                e.printStackTrace();
            }
            return false;
        }

        // Delete customer
        public boolean deleteCustomer(int id) {
            String sql = "DELETE FROM customers WHERE customer_id=?";
            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, id);
                return ps.executeUpdate() > 0;
            } catch (Exception e) {
                e.printStackTrace();
            }
            return false;
        }

        // Get purchase history of a customer
        public List<Map<String, Object>> getCustomerHistory(int customerId) {
            List<Map<String, Object>> history = new ArrayList<>();
            String sql = "SELECT b.bill_date, b.bill_time, u.username AS seller_name, b.total_amount " +
                    "FROM bills b JOIN users u ON b.user_id = u.user_id " +
                    "WHERE b.customer_id = ? ORDER BY b.bill_date DESC";
            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, customerId);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("date", rs.getDate("bill_date"));
                    row.put("time", rs.getTime("bill_time"));
                    row.put("seller", rs.getString("seller_name"));
                    row.put("total", rs.getBigDecimal("total_amount"));
                    history.add(row);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return history;
        }

        // bill jsp functions
        public Customer findCustomer(String input) {
            String sql = "SELECT * FROM customers WHERE phone_number=? OR account_number=?";
            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, input);
                ps.setString(2, input);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    Customer c = new Customer();
                    c.setCustomerId(rs.getInt("customer_id"));
                    c.setAccountNumber(rs.getString("account_number"));
                    c.setName(rs.getString("name"));
                    c.setAddress(rs.getString("address"));
                    c.setPhone(rs.getString("phone_number"));
                    c.setEmail(rs.getString("email"));
                    return c;
                }
            } catch (Exception e) { e.printStackTrace(); }
            return null;
        }
    }
