<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String message = request.getParameter("message");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<style>
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}
body {
    background: linear-gradient(to bottom, #1b1b1b, #121212);
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}
.auth-container {
    width: 100%;
    max-width: 400px;
    padding: 20px;
}
.auth-box {
    background-color: #fff;
    border-radius: 15px;
    padding: 30px;
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}
.auth-box h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #333;
}
.input-group {
    margin-bottom: 15px;
}

.input-group label {
    display: block;
    font-weight: 600;
    margin-bottom: 5px;
    color: #333;
}

.input-group input,
.input-group select {
    width: 100%;
    padding: 10px;
    border-radius: 8px;
    border: 1px solid #ccc;
    transition: 0.3s border-color;
}

.input-group input:focus,
.input-group select:focus {
    border-color: #74ebd5;
    outline: none;
}
.btn-login {
    width: 100%;
    background-color: #4a90e2;
    color: white;
    padding: 12px;
    border: none;
    border-radius: 8px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s;
}

.btn-login:hover {
    background-color: #357ab7;
}
.redirect {
    text-align: center;
    margin-top: 10px;
    font-size: 14px;
}

.redirect a {
    color: #4a90e2;
    text-decoration: none;
    font-weight: 500;
}

.redirect a:hover {
    text-decoration: underline;
}

</style>
</head>
<body>
    <div class="auth-container">
        <div class="auth-box">
            <h2>Login</h2>
            <form action="UniversalLoginServlet" method="POST">
                <div class="input-group">
                    <label for="userType">Login As</label>
                    <select name="userType" id="userType" required>
                        <option value="user">User</option>
                        <option value="tailor">Tailor</option>
                        <option value="admin">Admin</option>
                    </select>
                </div>
                <div class="input-group" id="adminKeyGroup" style="display: none;">
                    <label for="adminKey">Admin Key</label>
                    <input type="password" id="adminKey" name="adminKey">
                </div>

                <div class="input-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required>
                </div>

                <div class="input-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>

                <button type="submit" class="btn btn-login">Login</button>
            </form>

            <p class="redirect">Back to home page? <a href="index.jsp">Home</a></p>
            <p class="redirect">Don't remember password? <a href="ForgotUnified.jsp">Forgot Password?</a></p>

            <% 
                String errorMessage = request.getParameter("error");
                if ("invalid".equals(errorMessage)) {
            %>
                <p style="color:red; text-align: center; margin-top: 10px; font-weight: bold;">Invalid credentials</p>
            <% } %>
            
            <% if ("reset_success".equals(message)) { %>
        <p style="color: green; text-align: center; padding-top:10px;">Password reset successfully. Please log in.</p>
    <% } %>
        </div>
    </div>

    <script>
        document.getElementById("userType").addEventListener("change", function () {
            var adminKeyGroup = document.getElementById("adminKeyGroup");
            adminKeyGroup.style.display = this.value === "admin" ? "block" : "none";
        });
    </script>
</body>
</html>
