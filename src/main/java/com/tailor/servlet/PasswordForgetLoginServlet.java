package com.tailor.servlet;

import java.io.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@WebServlet("/RecoverServlet")
public class PasswordForgetLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        String dbUrl = "jdbc:mysql://localhost:3306/tailor_db";
        String dbUser = "root";
        String dbPass = "12345";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);

            if ("send_otp".equals(action)) {
                String email = request.getParameter("email");
                List<String> matchedTables = new ArrayList<>();
                String[] tables = { "admin_users", "signup_login" };

                for (String table : tables) {
                    PreparedStatement ps = conn.prepareStatement("SELECT email FROM " + table + " WHERE email=?");
                    ps.setString(1, email);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        matchedTables.add(table);
                    }
                    rs.close();
                    ps.close();
                }

                if (matchedTables.isEmpty()) {
                    request.setAttribute("error", "Email not found.");
                    request.setAttribute("step", "email");
                } else if (matchedTables.size() == 1) {
                 
                    String otp = generateOtp();
                    session.setAttribute("otp", otp);
                    session.setAttribute("email", email);
                    session.setAttribute("userTable", matchedTables.get(0));

                    System.out.println("OTP sent to " + email + ": " + otp);
                    request.setAttribute("step", "otp");
                    request.setAttribute("message", "OTP sent to your email (mocked).");
                } else {
                    
                	session.setAttribute("email", email);

                	List<String[]> userTypes = new ArrayList<>();
                	for (String table : matchedTables) {
                	    String label;
                	    switch (table) {
                	        case "admin_users": label = "Admin"; break;
                	        case "signup_login": label = "User"; break;
                	        default: label = table;
                	    }
                	    userTypes.add(new String[]{table, label});
                	}

                	request.setAttribute("userTypes", userTypes);
                	request.setAttribute("step", "select_user_type");

                }

            } else if ("send_otp_selected".equals(action)) {
                String selectedTable = request.getParameter("userTable");
                String email = (String) session.getAttribute("email");

                if (selectedTable != null && email != null) {
                    String otp = generateOtp();
                    session.setAttribute("otp", otp);
                    session.setAttribute("userTable", selectedTable);

                    System.out.println("OTP sent to " + email + ": " + otp);
                    request.setAttribute("step", "otp");
                    request.setAttribute("message", "OTP sent to your email (mocked).");
                } else {
                    request.setAttribute("error", "Invalid selection. Please try again.");
                    request.setAttribute("step", "email");
                }

            } else if ("verify_otp".equals(action)) {
                String userOtp = request.getParameter("otp");
                String sessionOtp = (String) session.getAttribute("otp");

                if (userOtp != null && userOtp.equals(sessionOtp)) {
                    request.setAttribute("step", "reset");
                    request.setAttribute("message", "OTP verified. You can now reset your password.");
                } else {
                    request.setAttribute("error", "Invalid OTP.");
                    request.setAttribute("step", "otp");
                }

            } else if ("reset_password".equals(action)) {
                String password = request.getParameter("password");
                String email = (String) session.getAttribute("email");
                String userTable = (String) session.getAttribute("userTable");

                if (email != null && userTable != null) {
                    PreparedStatement ps = conn.prepareStatement("UPDATE " + userTable + " SET password=? WHERE email=?");
                    ps.setString(1, password);
                    ps.setString(2, email);
                    int rows = ps.executeUpdate();
                    ps.close();

                    if (rows > 0) {
                        session.invalidate();
                        System.out.println("Redirecting to login...");
                        conn.close();
                        response.sendRedirect(request.getContextPath() + "/unifiedLogin.jsp?message=reset_success");
                        return; 
                    } else {
                        request.setAttribute("error", "Failed to reset password.");
                        request.setAttribute("step", "reset");
                    }
                } else {
                    request.setAttribute("error", "Session expired or invalid state.");
                    request.setAttribute("step", "email");
                }
            }


            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong.");
            request.setAttribute("step", "email");
        }

        RequestDispatcher rd = request.getRequestDispatcher("ForgotUnified.jsp");
        rd.forward(request, response);
    }

    private String generateOtp() {
        return String.valueOf(new Random().nextInt(900000) + 100000);
    }

}
