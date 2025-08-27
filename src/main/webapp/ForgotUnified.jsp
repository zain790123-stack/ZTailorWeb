<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Recover Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .auth-container {
            max-width: 400px;
            width: 100%;
        }
        .auth-box {
            background: #fff;
            padding: 2em;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            border-radius: 12px;
        }
        .auth-box h2 {
            text-align: center;
            margin-bottom: 1em;
        }
        .input-group {
            margin-bottom: 1em;
        }
        .input-group label {
            display: block;
            margin-bottom: 0.5em;
        }
        .input-group input,
        .input-group select {
            width: 100%;
            padding: 0.75em;
            border: 1px solid #ccc;
            border-radius: 8px;
        }
        .btn {
            width: 100%;
            padding: 0.75em;
            border: none;
            background: #007bff;
            color: white;
            border-radius: 8px;
            cursor: pointer;
        }
        .btn:hover {
            background: #0056b3;
        }
        .redirect {
    text-align: center;
    margin-top: 1.5em;
    font-size: 0.95rem;
    color: #555;
}

.redirect a {
    color: #007bff;
    text-decoration: none;
    font-weight: 500;
    transition: color 0.3s ease;
}

.redirect a:hover {
    color: #0056b3;
    text-decoration: underline;
}

        .message {
            text-align: center;
            margin-top: 1em;
        }
    </style>
</head>
<body>
<div class="auth-container">
    <div class="auth-box">
        <h2>Password Recovery</h2>
        <form action="RecoverServlet" method="POST">
            <%
                String step = (String) request.getAttribute("step");
                if (step == null) step = "email";
            %>

            <% if ("email".equals(step)) { %>
                <div class="input-group">
                    <label>Enter your registered email:</label>
                    <input type="email" name="email" required>
                </div>
                <button type="submit" name="action" value="send_otp" class="btn">Send OTP</button>

            <% } else if ("select_user_type".equals(step)) {
            	@SuppressWarnings("unchecked")
                List<String[]> types = (List<String[]>) request.getAttribute("userTypes");
            %>
                <div class="input-group">
                    <label>Select account type:</label>
                    <select name="userTable" required>
                        <% for (String[] type : types) { %>
                            <option value="<%= type[0] %>"><%= type[1] %></option>
                        <% } %>
                    </select>
                </div>
                <button type="submit" name="action" value="send_otp_selected" class="btn">Send OTP</button>

            <% } else if ("otp".equals(step)) { %>
                <div class="input-group">
                    <label>Enter OTP sent to your email:</label>
                    <input type="text" name="otp" required>
                </div>
                <button type="submit" name="action" value="verify_otp" class="btn">Verify OTP</button>

            <% } else if ("reset".equals(step)) { %>
                <div class="input-group">
                    <label>Enter new password:</label>
                    <input type="password" name="password" required>
                </div>
                <button type="submit" name="action" value="reset_password" class="btn">Reset Password</button>
            <% } %>
        </form>

        <div class="message">
            <% 
                String message = (String) request.getAttribute("message");
                String error = (String) request.getAttribute("error");
                if (message != null) { 
            %>
                <p style="color: green;"><%= message %></p>
            <% } else if (error != null) { %>
                <p style="color: red;"><%= error %></p>
            <% } %>
        </div>

        <p class="redirect"><a href="unifiedLogin.jsp">Back to Login</a></p>
    </div>
</div>
</body>
</html>
