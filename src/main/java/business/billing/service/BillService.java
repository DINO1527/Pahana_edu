package business.billing.service;

import business.billing.dto.BillDTO;
import business.billing.dto.BillItemDTO;
import business.billing.dto.BookDTO;
import business.billing.mapper.BillMapper;
import business.billing.model.Bill;
import business.customer.dto.CustomerDTO;
import business.customer.mapper.CustomerMapper;
import business.customer.model.Customer;
import persistence.billing.BillDAO;
import persistence.billing.BookDAO;
import persistence.customer.customerDAO;

public class BillService {

    private BillDAO billDAO = new BillDAO();
    private BookDAO bookDAO = new BookDAO();
    public void saveBill(BillDTO billDTO) {
        Bill bill = BillMapper.toEntity(billDTO);
        billDAO.saveBill(bill);
        // after saving bill, update stock
        for (BillItemDTO item : billDTO.getItems()) {
            BookDTO book = bookDAO.findBookById(item.getBookId());
            if (book != null) {
                int remaining = book.getStockQty() - item.getQuantity();
                if (remaining < 0) {
                    remaining = 0; // prevent negative
                }
                bookDAO.updateBookQuantity(item.getBookId(), remaining);
            }
        }

    }

    public CustomerDTO findCustomerBySearch(String search) {
        customerDAO customerDAO = new customerDAO();
        Customer customer = customerDAO.findCustomer(search);
        if (customer == null) {
            return null;
        }
        return CustomerMapper.toDTO(customer);
    }

 

}
