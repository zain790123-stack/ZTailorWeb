<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Approved Tailors</title>
    <style>
        table {
            border-collapse: collapse;
            width: 80%;
            margin: 20px auto;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px 12px;
            text-align: center;
        }
        th {
            background-color: #f4f4f4;
        }
        h2 {
            text-align: center;
        }
    </style>
</head>
<body>
    <h2>Approved Tailors</h2>

    <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/tailor_db", "root", "12345");

            String sql = "SELECT id, name, phone, email, specialty, approval_time FROM tailors WHERE status = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "approve");  
            rs = pstmt.executeQuery();
    %>

    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Phone</th>
            <th>Email</th>
            <th>Specialty</th>
            <th>Approval Time</th>
        </tr>

        <%
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("phone") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("specialty") %></td>
            <td><%= rs.getTimestamp("approval_time") %></td>
        </tr>
        <%
            }
        %>
    </table>

    <%
        } catch (Exception e) {
            out.println("<p style='color:red; text-align:center;'>Error: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    %>
</body>
</html>
