package business.user.service;

import business.user.dto.UserDTO;
import junit.framework.TestCase;

public class UserServiceTest extends TestCase {

    private UserService userService;

    protected void setUp() throws Exception {
        super.setUp();
        userService = new UserService();
        // Optional: clean or insert test users in DB
    }

    // ------------- Successful login -------------
    public void testLogin_ValidCredentials() {
        UserDTO dto = new UserDTO();
        dto.setUsername("dinoshan");
        dto.setPassword("12345"); // plain password (will be hashed inside service)

        UserDTO result = userService.login(dto);
        assertNotNull("Login should succeed with valid credentials", result);
        assertEquals("Username should match", "dinoshan", result.getUsername());
    }

    // ------------- Invalid username -------------
    public void testLogin_InvalidUsername() {
        UserDTO dto = new UserDTO();
        dto.setUsername("nonexistent");
        dto.setPassword("anyPassword");

        UserDTO result = userService.login(dto);
        assertNull("Login should fail for invalid username", result);
    }

    // ------------- Invalid password -------------
    public void testLogin_InvalidPassword() {
        UserDTO dto = new UserDTO();
        dto.setUsername("testuser");
        dto.setPassword("WrongPassword");

        UserDTO result = userService.login(dto);
        assertNull("Login should fail for invalid password", result);
    }

    // ------------- Empty username -------------
    public void testLogin_EmptyUsername() {
        UserDTO dto = new UserDTO();
        dto.setUsername("");
        dto.setPassword("Test@123");

        UserDTO result = userService.login(dto);
        assertNull("Login should fail for empty username", result);
    }

    // ------------- Empty password -------------
    public void testLogin_EmptyPassword() {
        UserDTO dto = new UserDTO();
        dto.setUsername("testuser");
        dto.setPassword("");

        UserDTO result = userService.login(dto);
        assertNull("Login should fail for empty password", result);
    }
}
