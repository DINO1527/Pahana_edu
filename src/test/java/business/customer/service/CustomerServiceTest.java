package business.customer.service;

import business.customer.dto.CustomerDTO;
import junit.framework.TestCase;
import org.junit.Before;


public class CustomerServiceTest extends TestCase {

    private CustomerService service;

    @Before
    public void setUp() {
        service = new CustomerService(); // initialize service
    }




    // ---------------- Success Case ----------------
    public void testAddCustomer_Success() {
        CustomerDTO dto = new CustomerDTO();
        dto.setAccountNumber("78562");   // ✅ 5 digits
        dto.setName("John Doe");
        dto.setAddress("Colombo");
        dto.setPhone("0771234523");      // ✅ 10 digits
        dto.setEmail("john@example.com"); // ✅ valid email

        boolean result = service.addCustomer(dto);
        assertTrue("Customer should be added successfully", result);
    }

    // ---------------- Required Fields ----------------
    public void testAddCustomer_MissingName() {
        CustomerDTO dto = new CustomerDTO();
        dto.setAccountNumber("12346");
        dto.setName("");   // ❌ missing name
        dto.setAddress("Colombo");
        dto.setPhone("0771111111");
        dto.setEmail("abc@example.com");

        boolean result = service.addCustomer(dto);
        assertFalse("Customer with missing name should not be added", result);
    }

    public void testAddCustomer_MissingEmail() {
        CustomerDTO dto = new CustomerDTO();
        dto.setAccountNumber("12347");
        dto.setName("Jane");
        dto.setAddress("Kandy");
        dto.setPhone("0772222222");
        dto.setEmail("");   // ❌ missing email

        boolean result = service.addCustomer(dto);
        assertFalse("Customer with missing email should not be added", result);
    }

    // ---------------- Account Number Validation ----------------
    public void testAddCustomer_InvalidAccountNumber() {
        CustomerDTO dto = new CustomerDTO();
        dto.setAccountNumber("1234"); // ❌ only 4 digits
        dto.setName("Invalid");
        dto.setAddress("Galle");
        dto.setPhone("0773333333");
        dto.setEmail("valid@example.com");

        boolean result = service.addCustomer(dto);
        assertFalse("Customer with invalid account number should not be added", result);
    }

    // ---------------- Email Validation ----------------
    public void testAddCustomer_InvalidEmail() {
        CustomerDTO dto = new CustomerDTO();
        dto.setAccountNumber("12348");
        dto.setName("Invalid Email");
        dto.setAddress("Matara");
        dto.setPhone("0774444444");
        dto.setEmail("not-an-email"); // ❌ invalid email

        boolean result = service.addCustomer(dto);
        assertFalse("Customer with invalid email should not be added", result);
    }

    // ---------------- Phone Validation ----------------
    public void testAddCustomer_InvalidPhone() {
        CustomerDTO dto = new CustomerDTO();
        dto.setAccountNumber("12349");
        dto.setName("Invalid Phone");
        dto.setAddress("Jaffna");
        dto.setPhone("12345"); // ❌ too short
        dto.setEmail("valid2@example.com");

        boolean result = service.addCustomer(dto);
        assertFalse("Customer with invalid phone should not be added", result);
    }

    // ---------------- Duplicate Checks ----------------
    public void testAddCustomer_DuplicateAccountNumber() {
        CustomerDTO dto1 = new CustomerDTO();
        dto1.setAccountNumber("54321");
        dto1.setName("Jane Doe");
        dto1.setAddress("Kandy");
        dto1.setPhone("0775555555");
        dto1.setEmail("jane@example.com");

        boolean firstAdd = service.addCustomer(dto1);
        assertTrue(firstAdd);

        CustomerDTO dto2 = new CustomerDTO();
        dto2.setAccountNumber("54321"); // same acc no
        dto2.setName("Duplicate");
        dto2.setAddress("Galle");
        dto2.setPhone("0712345678");
        dto2.setEmail("dup@example.com");

        boolean secondAdd = service.addCustomer(dto2);
        assertFalse("Adding duplicate account number should fail", secondAdd);
    }

    public void testAddCustomer_DuplicatePhoneNumber() {
        CustomerDTO dto1 = new CustomerDTO();
        dto1.setAccountNumber("67890");
        dto1.setName("Peter Parker");
        dto1.setAddress("Negombo");
        dto1.setPhone("0755555555");
        dto1.setEmail("peter@example.com");

        boolean firstAdd = service.addCustomer(dto1);
        assertTrue(firstAdd);

        CustomerDTO dto2 = new CustomerDTO();
        dto2.setAccountNumber("67891");
        dto2.setName("Bruce Wayne");
        dto2.setAddress("Colombo");
        dto2.setPhone("0755555555"); // same phone
        dto2.setEmail("bruce@example.com");

        boolean secondAdd = service.addCustomer(dto2);
        assertFalse("Adding duplicate phone number should fail", secondAdd);
    }
}
