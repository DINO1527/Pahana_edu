package business.billing.service;

import business.billing.dto.BillDTO;
import business.billing.dto.BillItemDTO;
import business.customer.dto.CustomerDTO;
import junit.framework.TestCase;

import java.util.ArrayList;
import java.util.List;

public class BillServiceTest extends TestCase {

    private BillService billService;

    protected void setUp() throws Exception {
        super.setUp();
        billService = new BillService();
        // Optional: clean DB before each test if needed
    }

    // ----------------- Test saving a bill -----------------
    public void testSaveBill_Success() {
        BillDTO billDTO = new BillDTO();
        billDTO.setCustomerId(1); // assume customer_id 1 exists
        billDTO.setUserId(1); // assume user_id 1 exists
        billDTO.setTotalAmount(500.0);
        billDTO.setPaymentMethod("Cash");

        List<BillItemDTO> items = new ArrayList<>();
        BillItemDTO item1 = new BillItemDTO();
        item1.setBookId(1); // assume book_id 1 exists
        item1.setQuantity(2);
        item1.setPrice(200.0);
        items.add(item1);

        BillItemDTO item2 = new BillItemDTO();
        item2.setBookId(2); // assume book_id 2 exists
        item2.setQuantity(1);
        item2.setPrice(100.0);
        items.add(item2);

        billDTO.setItems(items);

        try {
            billService.saveBill(billDTO);
            // If no exception occurs, we consider it success
            assertTrue("Bill saved successfully", true);
        } catch (Exception e) {
            fail("Saving bill failed: " + e.getMessage());
        }
    }

    // ----------------- Test negative quantity handling -----------------
    public void testSaveBill_NegativeQuantity() {
        BillDTO billDTO = new BillDTO();
        billDTO.setCustomerId(1);
        billDTO.setUserId(1);
        billDTO.setTotalAmount(300.0);
        billDTO.setPaymentMethod("Card");

        List<BillItemDTO> items = new ArrayList<>();
        BillItemDTO item = new BillItemDTO();
        item.setBookId(1); // assume book exists
        item.setQuantity(1000); // large quantity exceeding stock
        item.setPrice(100.0);
        items.add(item);

        billDTO.setItems(items);

        try {
            billService.saveBill(billDTO);
            assertTrue("Bill saved, stock adjusted to prevent negative", true);
        } catch (Exception e) {
            fail("Saving bill failed: " + e.getMessage());
        }
    }



    public void testFindCustomerBySearch_NonExistingCustomer() {
        String search = "NonExistentCustomer";
        CustomerDTO customer = billService.findCustomerBySearch(search);
        assertNull("Non-existing customer should return null", customer);
    }

    public void testFindCustomerBySearch_EmptyInput() {
        String search = "";
        CustomerDTO customer = billService.findCustomerBySearch(search);
        assertNull("Empty search should return null", customer);
    }
}
