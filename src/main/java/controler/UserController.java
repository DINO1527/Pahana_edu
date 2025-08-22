package controler;

import business.user.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/UserController")
public class UserController extends HttpServlet {
    private final UserService service = new UserService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect("logout.jsp");
            return;
        }
        int userId = (Integer) session.getAttribute("userId");

        if ("updatePassword".equals(action)) {
            String currentPassword = req.getParameter("current_password");
            String newPassword = req.getParameter("new_password");
            String confirmPassword = req.getParameter("confirm_password");

            try {
                if (!newPassword.equals(confirmPassword)) {
                    session.setAttribute("alertType", "error");
                    session.setAttribute("alertMsg", "New password and confirmation do not match!");

                    resp.sendRedirect("dashboard.jsp");
                    return;
                }

                boolean success = service.updatePassword(userId, currentPassword, newPassword);

                if (success) {
                    session.setAttribute("alertType", "success");
                    session.setAttribute("alertMsg", "Password updated successfully!");
                } else {
                    session.setAttribute("alertType", "error");
                    session.setAttribute("alertMsg", "Password update failed! Check old password or requirements.");
                }
                resp.sendRedirect("dashboard.jsp");

            } catch (Exception e) {
                throw new ServletException(e);
            }
        }
    }
}
