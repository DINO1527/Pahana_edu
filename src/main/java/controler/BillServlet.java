package controler;

import business.billing.dto.BillDTO;
import business.billing.dto.BillItemDTO;
import business.billing.service.BillService;
import business.customer.dto.CustomerDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/BillServlet")
public class BillServlet extends HttpServlet {

    private BillService billService = new BillService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // don't create new
        Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;

        if (userId == null) {
            // User is not logged in, redirect to login page
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("fetchCustomer".equals(action)) {
            String search = request.getParameter("search");
            CustomerDTO customer = billService.findCustomerBySearch(search);
            if (customer == null) {
                // Redirect with error message in URL
                response.sendRedirect("calculateBill.jsp?error=Customer+Not+Found");
            } else {
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("calculateBill.jsp").forward(request, response);
            }
        }


        if ("saveBill".equals(action)) {
            BillDTO billDTO = new BillDTO();
            billDTO.setCustomerId(Integer.parseInt(request.getParameter("customerId")));
            billDTO.setUserId(userId); // static user (cashier) id
            billDTO.setPaymentMethod(request.getParameter("payment"));
            String[] bookIds = request.getParameterValues("bookId");
            String[] quantities = request.getParameterValues("qty");
            String[] prices = request.getParameterValues("price");

            List<BillItemDTO> itemDTOs = new ArrayList<>();
            double total = 0;

            for (int i = 0; i < bookIds.length; i++) {
                BillItemDTO item = new BillItemDTO();
                item.setBookId(Integer.parseInt(bookIds[i]));
                item.setQuantity(Integer.parseInt(quantities[i]));
                item.setPrice(Double.parseDouble(prices[i]));
                total += item.getSubtotal();
                itemDTOs.add(item);
            }

            billDTO.setTotalAmount(total);
            billDTO.setItems(itemDTOs);

            billService.saveBill(billDTO);
            response.sendRedirect("calculateBill.jsp?success=Next+customer");
        }
    }
}
