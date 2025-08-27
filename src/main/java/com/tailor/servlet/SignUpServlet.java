package com.tailor.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.RequestDispatcher;

@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final String DB_URL = "jdbc:mysql://localhost:3306/tailor_db";
    private final String DB_USER = "root";
    private final String DB_PASSWORD = "12345";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {

                String checkEmailQuery = "SELECT id FROM signup_login WHERE email = ?";
                PreparedStatement emailStmt = conn.prepareStatement(checkEmailQuery);
                emailStmt.setString(1, email);
                ResultSet emailRs = emailStmt.executeQuery();

                if (emailRs.next()) {
                    request.setAttribute("message", "Email is already registered!");
                    request.setAttribute("messageType", "error");

                } else {
                    String checkUsernameQuery = "SELECT id FROM signup_login WHERE username = ?";
                    PreparedStatement usernameStmt = conn.prepareStatement(checkUsernameQuery);
                    usernameStmt.setString(1, username);
                    ResultSet usernameRs = usernameStmt.executeQuery();

                    if (usernameRs.next()) {
                        request.setAttribute("message", "Username is already taken!");
                        request.setAttribute("messageType", "error");

                    } else {
                       
                        String insertQuery = "INSERT INTO signup_login (username, email, password) VALUES (?, ?, ?)";
                        PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                        insertStmt.setString(1, username);
                        insertStmt.setString(2, email);
                        insertStmt.setString(3, password); 

                        int rows = insertStmt.executeUpdate();
                        if (rows > 0) {
                            request.setAttribute("message", "Registration successful! Please log in.");
                            request.setAttribute("messageType", "success");
                        } else {
                            request.setAttribute("message", "Registration failed. Please try again.");
                            request.setAttribute("messageType", "error");
                        }
                    }
                }

            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("message", "JDBC Driver not found: " + e.getMessage());
            request.setAttribute("messageType", "error");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "Server error: " + e.getMessage());
            request.setAttribute("messageType", "error");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("signup.jsp");
        dispatcher.forward(request, response);
    }
}
