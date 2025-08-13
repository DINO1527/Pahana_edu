package persistence.billing;

import business.billing.model.Bill;
import business.billing.model.BillItem;
import persistence.util.DBConnection;

import java.sql.*;
import java.util.List;

public class BillDAO {

    public int saveBill(Bill bill) {
        String sql = "INSERT INTO bills (customer_id, user_id, total_amount, payment_method) VALUES (?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, bill.getCustomerId());
            ps.setInt(2, bill.getUserId());
            ps.setDouble(3, bill.getTotalAmount());
            ps.setString(4, bill.getPaymentMethod());
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int billId = rs.getInt(1);
                saveBillItems(billId, bill.getItems(), con);
                return billId;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    private void saveBillItems(int billId, List<BillItem> items, Connection con) throws SQLException {
        String sql = "INSERT INTO bill_items (bill_id, book_id, quantity, price) VALUES (?,?,?,?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            for (BillItem item : items) {
                ps.setInt(1, billId);
                ps.setInt(2, item.getBookId());
                ps.setInt(3, item.getQuantity());
                ps.setDouble(4, item.getPrice());
                ps.addBatch();
            }
            ps.executeBatch();
        }
    }



}
