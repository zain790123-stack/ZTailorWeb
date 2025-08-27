<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    
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
.btn-signup {
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

.btn-signup:hover {
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
p[style*="color: red"],
p[style*="color: green"] {
    text-align: center;
    margin-top: 10px;
    font-weight: bold;
}

</style>
 
</head>
<body>
    <div class="auth-container">
        <div class="auth-box">
            <h2>Sign Up</h2>
            <form action="SignUpServlet" method="POST">
                <div class="input-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="input-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <div class="input-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>
                 <button type="submit" class="btn btn-signup">Sign Up</button>
            </form>
            <p class="redirect">Already have an account? <a href="unifiedLogin.jsp">Login</a></p>
            <p class="redirect">Back to home page? <a href="index.jsp">Home</a></p>
                   <%
                    String message = (String) request.getAttribute("message");
                    String type = (String) request.getAttribute("messageType");
                    if (message != null && type != null) {
                   %>
                   <p style="color: <%= "success".equals(type) ? "green" : "red" %>;">
                   <%= message %>
                   </p>
                   <%
                    }
                    %>
        </div>
    </div>

</body>
</html>
