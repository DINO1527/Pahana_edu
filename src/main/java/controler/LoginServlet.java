package controler;

import business.user.dto.UserDTO;
import business.user.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserService userService = new UserService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDTO loginDTO = new UserDTO(username, password);

        // Call service → always returns DTO (never raw Model)
        UserDTO loggedUser = userService.login(loginDTO);

        if (loggedUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("userId", loggedUser.getId());
            session.setAttribute("username", loggedUser.getUsername());
            response.sendRedirect("dashboard.jsp");
        } else {
            request.setAttribute("error", "Invalid username or password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
