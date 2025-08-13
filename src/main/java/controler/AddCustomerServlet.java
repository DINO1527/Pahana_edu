package controler;

import business.customer.dto.CustomerDTO;
import business.customer.service.CustomerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/AddCustomerServlet")
public class AddCustomerServlet extends HttpServlet {
    private final CustomerService service = new CustomerService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {



        CustomerDTO dto = new CustomerDTO(
                request.getParameter("accountNumber"),
                request.getParameter("name"),
                request.getParameter("address"),
                request.getParameter("phone"),
                request.getParameter("email")
        );

        // ✅ Basic validation
        if (dto.getAccountNumber().isEmpty() || dto.getName().isEmpty() ||
                dto.getAddress().isEmpty() || !dto.getPhone().matches("\\d{10}") ||
                !dto.getEmail().matches("^[\\w.-]+@[\\w.-]+\\.\\w{2,}$")) {
            response.sendRedirect("addCustomer.jsp?status=error&message=" + URLEncoder.encode("Invalid inputs.", "UTF-8"));
            return;
        }

        boolean result = service.addCustomer(dto);
        if (result) {
            response.sendRedirect("addCustomer.jsp?status=success");
        } else {
            response.sendRedirect("addCustomer.jsp?status=error&message=" + URLEncoder.encode("Account or phone already exists.", "UTF-8"));
        }
    }
}

