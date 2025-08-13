package business.customer.service;


import business.customer.dto.CustomerDTO;
import business.customer.mapper.CustomerMapper;
import business.customer.model.Customer;
import persistence.customer.customerDAO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class CustomerService {
    private final customerDAO dao = new customerDAO();

    public boolean addCustomer(CustomerDTO dto) {
        if (dao.isAccountNumberExists(dto.getAccountNumber()) || dao.isPhoneNumberExists(dto.getPhone())) {
            return false;
        }
        Customer customer = CustomerMapper.toModel(dto);
        return dao.addCustomer(customer);
    }
    public boolean deleteCustomer(int id) {
        return dao.deleteCustomer(id);
    }

    public boolean updateCustomer(CustomerDTO dto) {
        Customer customer = CustomerMapper.toEntity(dto);
        return dao.updateCustomer(customer);
    }

    public CustomerDTO getCustomerById(int id) {
        Customer customer = dao.getCustomerById(id);
        return (customer != null) ? CustomerMapper.toDTO(customer) : null;
    }


    public List<CustomerDTO> getAllCustomers() {
        List<Customer> customerModels = dao.findAll(); // now works
        List<CustomerDTO> customerDTOs = new ArrayList<>();
        for (Customer model : customerModels) {
            customerDTOs.add(CustomerMapper.toDTO(model));
        }
        return customerDTOs;
    }

    public List<Map<String, Object>> getCustomerHistory(int customerId) {
        return dao.getCustomerHistory(customerId);
    }

    public boolean isAccountExists(String accountNumber) {
        return dao.isAccountNumberExists(accountNumber);
    }

    public boolean isPhoneExists(String phone) {
        return dao.isPhoneNumberExists(phone);
    }
}

