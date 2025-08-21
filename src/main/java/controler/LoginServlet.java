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
            request.setAttribute("username", ""); // force empty
            request.setAttribute("password", ""); // force empty
            HttpSession session = request.getSession();
            session.setAttribute("userId", loggedUser.getId());
            session.setAttribute("username", loggedUser.getUsername());
            session.setAttribute("loginSuccess", true);

            response.sendRedirect("dashboard.jsp");
        } else {
            request.setAttribute("error", "Invalid username or password!");
            request.setAttribute("username", ""); // force empty
            request.setAttribute("password", ""); // force empty
            request.getRequestDispatcher("login.jsp").forward(request, response);

        }
    }
}
