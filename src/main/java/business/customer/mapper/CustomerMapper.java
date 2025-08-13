package business.customer.mapper;



import business.customer.dto.CustomerDTO;
import business.customer.model.Customer;

public class CustomerMapper {
    public static Customer toModel(CustomerDTO dto) {
        Customer customer = new Customer();
        customer.setAccountNumber(dto.getAccountNumber());
        customer.setName(dto.getName());
        customer.setAddress(dto.getAddress());
        customer.setPhone(dto.getPhone());
        customer.setEmail(dto.getEmail());
        return customer;
    }

    public static CustomerDTO toDTO(Customer customer) {
        return new CustomerDTO(
                customer.getCustomerId(),
                customer.getAccountNumber(),
                customer.getName(),
                customer.getAddress(),
                customer.getPhone(),
                customer.getEmail()
        );
    }

    public static Customer toEntity(CustomerDTO dto) {
        Customer c = new Customer();
        c.setCustomerId(dto.getCustomerId());
        c.setAccountNumber(dto.getAccountNumber());
        c.setName(dto.getName());
        c.setAddress(dto.getAddress());
        c.setPhone(dto.getPhone());
        c.setEmail(dto.getEmail());
        return c;
    }




}
