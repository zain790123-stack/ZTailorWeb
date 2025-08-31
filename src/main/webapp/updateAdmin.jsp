<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String id = request.getParameter("id");
    String name = "";
    String email = "";
    String adminKey = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/tailor_db", "root", "12345");
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM admin_users WHERE id=?");
        ps.setInt(1, Integer.parseInt(id));
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            name = rs.getString("name");
            email = rs.getString("email");
            adminKey = rs.getString("admin_key");
            
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
<title>Edit Admin</title>
<style>
body { font-family: Arial, sans-serif; background: #f8f9fa; }
form {
    width: 300px; margin: 50px auto; background: white;
    padding: 20px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1);
}
input, button { width: 100%; padding: 8px; margin: 5px 0; }
button { background: #4a90e2; color: white; border: none; border-radius: 5px; }
</style>
</head>
<body>
<h2 style="text-align:center;">Update Admin</h2>
<form action="AdminManagementServlet" method="post">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="id" value="<%= id %>">
    <input type="text" name="name" value="<%= name %>" required>
    <input type="email" name="email" value="<%= email %>" required>
    <input type="password" name="password" placeholder="New Password">
    <input type="text" name="adminKey" value="<%= adminKey %>" required>
    <button type="submit">Update Admin</button>
</form>
</body>
</html>
