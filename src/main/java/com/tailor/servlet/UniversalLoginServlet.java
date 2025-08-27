package com.tailor.servlet;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.Base64;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UniversalLoginServlet")

public class UniversalLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userType = request.getParameter("userType");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String adminKey = request.getParameter("adminKey"); 

        String url = "jdbc:mysql://localhost:3306/tailor_db";
        String dbUser = "root"; 
        String dbPass = "12345"; 

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, dbUser, dbPass);

            PreparedStatement stmt = null;
            ResultSet rs = null;

            switch (userType) {
                case "admin":
                    stmt = conn.prepareStatement("SELECT * FROM admin_users WHERE email = ? AND password = ? AND admin_key = ?");
                    stmt.setString(1, email);
                    stmt.setString(2, password);
                    stmt.setString(3, adminKey);
                    break;
                case "tailor":
                    String hashedTailorPassword = hashPassword(password); 
                    stmt = conn.prepareStatement("SELECT * FROM tailors WHERE email = ? AND password = ?");
                    stmt.setString(1, email);
                    stmt.setString(2, hashedTailorPassword);
                    break;



                case "user":
                    stmt = conn.prepareStatement("SELECT * FROM signup_login WHERE email = ? AND password = ?");
                    stmt.setString(1, email);
                    stmt.setString(2, password);
                    break;
            }

            rs = stmt.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("userEmail", email);
                session.setAttribute("userType", userType);

                if ("tailor".equals(userType)) {
                    session.setAttribute("tailorName", rs.getString("name")); 
                    session.setAttribute("tailorEmail", rs.getString("email")); 
                }

                switch (userType) {
                    case "admin":
                        response.sendRedirect("adminDashboard.jsp");
                        break;
                    case "tailor":
                        response.sendRedirect("TailorDB.jsp");
                        break;
                    case "user":
                        response.sendRedirect("loginIndex.jsp");
                        break;
                }
            }
             else {
                response.sendRedirect("unifiedLogin.jsp?error=invalid");
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("unifiedLogin.jsp?error=invalid");
        }
    }

	private String hashPassword(String password) {
	    try {
	        MessageDigest digest = MessageDigest.getInstance("SHA-256");
	        byte[] hashBytes = digest.digest(password.getBytes());
	        return Base64.getEncoder().encodeToString(hashBytes);
	    } catch (NoSuchAlgorithmException e) {
	        e.printStackTrace();
	        return null;
	    }
	}

}
