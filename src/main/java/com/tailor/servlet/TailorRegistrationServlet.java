package com.tailor.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.nio.file.Paths;
import java.security.*;
import java.sql.*;
import java.time.Instant;
import java.util.Base64;

@WebServlet("/TailorHandler")
@MultipartConfig
public class TailorRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/tailor_db";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "12345";
    private static final int OTP_LENGTH = 6;
    private static final long OTP_VALIDITY_DURATION = 5 * 60 * 1000;

    @Override
    public void init() throws ServletException {
        try {
            DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
        } catch (SQLException e) {
            throw new ServletException("Failed to register MySQL driver", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "sendOTP":
                handleOtpRequest(request, response);
                break;
            case "TailorRegistrationServlet":
                handleRegistration(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void handleOtpRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        HttpSession session = request.getSession();

        if (email == null || !email.matches("^[\\w-.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid email format");
            return;
        }

        String otp = generateOtp();
        long otpTime = Instant.now().toEpochMilli();

        session.setAttribute("otp", otp);
        session.setAttribute("otpCreationTime", otpTime);

        System.out.println("OTP for " + email + ": " + otp);
        response.setStatus(HttpServletResponse.SC_OK);
    }

    private void handleRegistration(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String name = request.getParameter("tailorName");
        String phone = request.getParameter("tailorPhone");
        String address = request.getParameter("tailorAddress");
        String specialty = request.getParameter("specialty");
        int experience = Integer.parseInt(request.getParameter("experience"));
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String otpInput = request.getParameter("otp");

        Part picture = request.getPart("tailorPicture");
        String pictureFileName = Paths.get(picture.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        new File(uploadPath).mkdirs();
        picture.write(uploadPath + File.separator + pictureFileName);

        HttpSession session = request.getSession();
        String otpStored = (String) session.getAttribute("otp");
        Long otpTime = (Long) session.getAttribute("otpCreationTime");

        if (otpStored == null || otpTime == null || !otpStored.equals(otpInput)
                || Instant.now().toEpochMilli() - otpTime > OTP_VALIDITY_DURATION) {
            request.setAttribute("errorMessage", "Invalid or expired OTP.");
            request.getRequestDispatcher("affilate tailors.jsp").forward(request, response);
            return;
        }

        session.removeAttribute("otp");
        session.removeAttribute("otpCreationTime");

        String hashedPassword = hashPassword(password);

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            if (isDuplicate(conn, "email", email)) {
            	request.getSession().setAttribute("errorMessage", "Email already exists.");
            	response.sendRedirect("affilate tailors.jsp");
            	return;
            }
            if (isDuplicate(conn, "username", username)) {
            	request.getSession().setAttribute("errorMessage", "Username already exists.");
            	response.sendRedirect("affilate tailors.jsp");
            	return;
            }
            if (isDuplicate(conn, "phone", phone)) {
            	request.getSession().setAttribute("errorMessage", "phone already exists.");
            	response.sendRedirect("affilate tailors.jsp");
            	return;
            }
            if (isDuplicate(conn, "name", name)) {
            	request.getSession().setAttribute("errorMessage", "Tailor Name already exists.");
            	response.sendRedirect("affilate tailors.jsp");
            	return;
            }

            String sql = "INSERT INTO Tailors (name, phone, address, picture_path, specialty, experience, username, email, password, verified) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setString(3, address);
            ps.setString(4, "uploads/" + pictureFileName);
            ps.setString(5, specialty);
            ps.setInt(6, experience);
            ps.setString(7, username);
            ps.setString(8, email);
            ps.setString(9, hashedPassword);
            ps.setBoolean(10, true);
            ps.executeUpdate();

            request.getSession().setAttribute("successMessage", "Registration successful! Please log in.");
            response.sendRedirect("affilate tailors.jsp");
            return;

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database Error: " + e.getMessage());
            request.getRequestDispatcher("affilate tailors.jsp").forward(request, response);
        }
    }

    private String generateOtp() {
        SecureRandom random = new SecureRandom();
        StringBuilder otp = new StringBuilder(OTP_LENGTH);
        for (int i = 0; i < OTP_LENGTH; i++) {
            otp.append(random.nextInt(10));
        }
        return otp.toString();
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

    private boolean isDuplicate(Connection conn, String field, String value) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Tailors WHERE " + field + " = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, value);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }
}
