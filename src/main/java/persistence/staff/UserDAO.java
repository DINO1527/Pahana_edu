package persistence.staff;

import business.user.dto.StaffDTO;
import business.user.model.User;
import persistence.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    public User findByUsername(String username) {
        User user = null;
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE username=?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password")); // hashed password
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
    public StaffDTO getUserById(int userId) throws Exception {
        String sql = "SELECT user_id, password FROM users WHERE user_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new StaffDTO(
                        rs.getInt("user_id"),
                        rs.getString("password")
                );
            }
        }
        return null;
    }

    // Update password
    public boolean updatePassword(int userId, String hashedPassword) throws Exception {
        String sql = "UPDATE users SET password=? WHERE user_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, hashedPassword);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        }
    }
}
