package business.billing.service;

import business.billing.dto.BillDTO;
import business.billing.mapper.BillMapper;
import business.billing.model.Bill;
import business.customer.dto.CustomerDTO;
import business.customer.mapper.CustomerMapper;
import business.customer.model.Customer;
import persistence.billing.BillDAO;
import persistence.customer.customerDAO;

public class BillService {

    private BillDAO billDAO = new BillDAO();

    public void saveBill(BillDTO billDTO) {
        Bill bill = BillMapper.toEntity(billDTO);
        billDAO.saveBill(bill);
    }

    public CustomerDTO findCustomerBySearch(String search) {
        customerDAO customerDAO = new customerDAO();
        Customer customer = customerDAO.findCustomer(search);
        return CustomerMapper.toDTO(customer); // You can implement CustomerMapper similarly
    }

 

}
