package com.tailor.servlet;
import java.io.IOException;
import java.io.PrintWriter;

import com.tailor.Dao.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateUserServlet")
public class UpdateUser extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String idStr = request.getParameter("id");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        if (idStr == null || username == null || password == null || email == null) {
            out.println("<p>All fields are required!</p>");
            return;
        }

        try {
            int id = Integer.parseInt(idStr); 
            out.println("<p>Received data: ID = " + id + ", Username = " + username + ", Email = " + email + "</p>");

            User user = new User();
            user.setId(id);
            user.setUsername(username);
            user.setPassword(password);
            user.setEmail(email);

            int result = UserDao.update(user);

            if (result > 0) {
                out.println("<p>User updated successfully!</p>");
                response.sendRedirect("adminDashboard.jsp?status=success");

            } else {
                out.println("<p>Error updating user. The user may not exist or database issue.</p>");
            }

        } catch (NumberFormatException e) {
            out.println("<p>Invalid ID format: " + e.getMessage() + "</p>");
            e.printStackTrace(out);
        } catch (Exception e) {
            out.println("<p>Unexpected error: " + e.getMessage() + "</p>");
            e.printStackTrace(out);
        }
    }
}
