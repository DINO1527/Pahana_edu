package controler;

import business.customer.dto.CustomerDTO;
import business.customer.service.CustomerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/EditCustomerServlet")
public class EditCustomerServlet extends HttpServlet {
    private CustomerService service = new CustomerService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("customerId"));
        CustomerDTO customer = service.getCustomerById(id);
        List<Map<String, Object>> history = service.getCustomerHistory(id);

        request.setAttribute("customer", customer);
        request.setAttribute("history", history);

        request.getRequestDispatcher("editCustomer.jsp").forward(request, response);
    }
}