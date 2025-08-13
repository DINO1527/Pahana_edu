package controler;

import business.customer.dto.CustomerDTO;
import business.customer.service.CustomerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UpdateCustomerServlet")
public class UpdateCustomerServlet extends HttpServlet {

    private CustomerService service = new CustomerService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Get customerId from request
        String customerIdStr = request.getParameter("customerId");
        int customerId = 0;
        try {
            customerId = Integer.parseInt(customerIdStr);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("errorPage.jsp");
            return;
        }

        // ✅ Populate DTO
        CustomerDTO dto = new CustomerDTO();
        dto.setCustomerId(customerId); // <-- This is crucial!
        dto.setAccountNumber(request.getParameter("accountNumber"));
        dto.setName(request.getParameter("Customer_Name"));
        dto.setAddress(request.getParameter("address"));
        dto.setPhone(request.getParameter("Phone_no"));
        dto.setEmail(request.getParameter("email"));

        // ✅ Update and redirect
        boolean result = service.updateCustomer(dto);
        response.sendRedirect("EditCustomerServlet?customerId=" + customerId + "&status=" + (result ? "success" : "error"));
    }
}