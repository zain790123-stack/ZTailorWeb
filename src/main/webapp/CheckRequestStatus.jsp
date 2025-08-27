<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Check Request Status</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
            padding: 20px;
        }

        h1 {
            text-align: center;
            font-size: 2rem;
            margin-bottom: 20px;
            color: #2c3e50;
        }

        .status-container {
            max-width: 600px;
            margin: 0 auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        form label {
            font-size: 1rem;
            font-weight: bold;
        }

        form input[type="text"] {
            padding: 10px;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 100%;
        }

        form button {
            padding: 10px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
        }

        form button:hover {
            background-color: #2980b9;
        }

        .error-message {
            background-color: #e74c3c;
            color: white;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            font-size: 1rem;
            display: none;
        }

        .status-message {
            background-color: #2ecc71;
            color: white;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-size: 1rem;
            display: none;
        }

        a {
            color: #3498db;
            text-decoration: none;
            font-size: 1rem;
            display: inline-block;
            margin-top: 20px;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="status-container">
    <h1>Check Your Request Status</h1>

    <div class="error-message" id="error-message"></div>
    <div class="status-message" id="status-message"></div>

    <form id="statusForm" method="post" action="checkUnifiedStatus" onsubmit="return handleSubmit(event)">
        <label for="requestId">Enter Request/Order ID:</label>
        <input type="text" id="requestId" name="requestId" required>

        <button type="submit">Check Status</button>
    </form>

    <p><a href="index.jsp">Back to Home</a></p>
</div>

<script>
    async function handleSubmit(event) {
        event.preventDefault();

        const requestId = document.getElementById("requestId").value.trim();

        document.getElementById("error-message").style.display = 'none';
        document.getElementById("status-message").style.display = 'none';

        try {
            const response = await fetch('checkUnifiedStatus', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'requestId=' + encodeURIComponent(requestId)
            });

            const data = await response.json();

            if (data.status) {
                document.getElementById("status-message").innerHTML = "Your request status: <strong>" + data.status + "</strong>";
                document.getElementById("status-message").style.display = 'block';
            } else if (data.error) {
                document.getElementById("error-message").innerHTML = data.error;
                document.getElementById("error-message").style.display = 'block';
            }

        } catch (error) {
            document.getElementById("error-message").innerHTML = "An error occurred while checking the status.";
            document.getElementById("error-message").style.display = 'block';
        }
    }
</script>
</body>
</html>
