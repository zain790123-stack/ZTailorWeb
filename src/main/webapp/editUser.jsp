<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/tailor_db", "root", "12345");

        ps = conn.prepareStatement("SELECT * FROM signup_login WHERE id=?");
        ps.setInt(1, id);
        rs = ps.executeQuery();

        if (rs.next()) {
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        input[type="text"],
        input[type="email"] {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            width: 100%;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 12px 20px;
            text-align: center;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        label {
            font-size: 16px;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit User (ID: <%= id %>)</h2>
        <form action="UpdateUserServlet" method="post">
            <input type="hidden" name="id" value="<%= id %>">
            <label for="username">Username:</label>
            <input type="text" name="username" id="username" value="<%= rs.getString("username") %>" required><br>

            <label for="password">Password:</label>
            <input type="text" name="password" id="password" value="<%= rs.getString("password") %>" required><br>

            <label for="email">Email:</label>
            <input type="email" name="email" id="email" value="<%= rs.getString("email") %>" required><br>

            <input type="submit" value="Update User">
        </form>
    </div>
</body>
</html>
<%
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>
