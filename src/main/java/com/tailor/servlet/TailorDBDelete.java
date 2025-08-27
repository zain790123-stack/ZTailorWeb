package com.tailor.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/TailorDeleteServlet")
public class TailorDBDelete extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Map<String, String> TABLE_MAP = new HashMap<>();

    static {
        TABLE_MAP.put("alteration_requests", "tailor_db");
        TABLE_MAP.put("suit_requests", "tailor_db");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String table = request.getParameter("type"); 
        String idStr = request.getParameter("id");

        if (table == null || idStr == null || !TABLE_MAP.containsKey(table)) {
            response.getWriter().write("error: invalid parameters");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.getWriter().write("error: invalid id format");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String dbName = TABLE_MAP.get(table);
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + dbName, "root", "12345");

            String sql = "DELETE FROM " + table + " WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);

            int rowsDeleted = pstmt.executeUpdate();

            if (rowsDeleted > 0) {
                response.getWriter().write("success");
            } else {
                response.getWriter().write("fail: no rows deleted");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error: " + e.getMessage());
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
