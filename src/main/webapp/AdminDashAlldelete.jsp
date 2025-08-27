<%@ page import="java.sql.*" %>
<%
    String table = request.getParameter("table");

    if (table == null || table.trim().isEmpty()) {
        out.println("<p style='color:red;'>No table specified.</p>");
        return;
    }

    Connection conn = null;
    Statement stmt = null;
    String dbName = "tailor_db";  

    if ("orders".equalsIgnoreCase(table)) {
        dbName = "tailor_shop";
    } else if (
        !table.equalsIgnoreCase("tailors") &&
        !table.equalsIgnoreCase("suit_requests") &&
        !table.equalsIgnoreCase("signup_login") &&
        !table.equalsIgnoreCase("alteration_requests")
    ) {
        out.println("<p style='color:red;'>Invalid table name.</p>");
        return;
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + dbName, "root", "12345");
        stmt = conn.createStatement();
        
        stmt.executeUpdate("TRUNCATE TABLE " + table);

        out.println("<script>alert('All data from table \"" + table + "\" deleted successfully.'); window.location.href='adminDashboard.jsp';</script>");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p style='color:red;'>Error deleting data from table " + table + ": " + e.getMessage() + "</p>");
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
%>
