package business.user.service;

import business.user.dto.UserDTO;
import business.user.mapper.UserMapper;
import business.user.model.User;
import persistence.staff.UserDAO;

import java.security.MessageDigest;

public class UserService {
    private UserDAO userDAO = new UserDAO();

    // Returns DTO to Controller (clean!)
    public UserDTO login(UserDTO dto) {
        // Convert DTO → Model
        User inputUser = UserMapper.toModel(dto);

        User dbUser = userDAO.findByUsername(inputUser.getUsername());
        if (dbUser != null) {
            String hashedInput = hashPassword(inputUser.getPassword());
            if (hashedInput.equals(dbUser.getPassword())) {
                // Convert back to DTO (hides hashed password)
                return UserMapper.toDTO(dbUser);
            }
        }
        return null;
    }

    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for (byte b : hash) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
