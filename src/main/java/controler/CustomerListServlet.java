package controler;



import business.customer.dto.CustomerDTO;
import business.customer.service.CustomerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/manageCustomer")
public class CustomerListServlet extends HttpServlet {

    private final CustomerService customerService = new CustomerService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<CustomerDTO> customers = customerService.getAllCustomers();
        req.setAttribute("customers", customers);

        req.getRequestDispatcher("/manageCustomer.jsp").forward(req, resp);
    }

}
