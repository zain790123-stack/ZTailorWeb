package com.tailor.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Timestamp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateTailorStatus")
public class TailorDBStatusUpdate extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");
        String type = request.getParameter("type"); 

        String tableName;
        if ("suit".equalsIgnoreCase(type)) {
            tableName = "suit_requests";
        } else if ("alteration".equalsIgnoreCase(type)) {
            tableName = "alteration_requests";
        } else {
            response.getWriter().write("invalid_type");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/tailor_db", "root", "12345");

            String sql = "UPDATE " + tableName + " SET status=?, approval_date=? WHERE id=?";
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, status);
            if ("approve".equalsIgnoreCase(status)) {
                pstmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            } else {
                pstmt.setNull(2, java.sql.Types.TIMESTAMP);
            }
            pstmt.setInt(3, id);

            int rowsUpdated = pstmt.executeUpdate();

            if (rowsUpdated > 0) {
                response.getWriter().write("success");
                System.out.println("SUCCESS: Updated status for ID " + id + " in table '" + tableName + "' to '" + status + "'");
            } else {
                response.getWriter().write("fail");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
