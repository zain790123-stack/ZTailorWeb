<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tailor Affiliation Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #1b1b1b;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: black;
        }

        form {
            max-width: 600px;
            margin: auto;
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        label {
            display: block;
            margin-top: 15px;
            color: #333;
            font-weight: bold;
        }

        input[type="text"],
        input[type="number"],
        input[type="email"],
        input[type="password"],
        input[type="file"],
        textarea,
        select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        textarea {
            resize: none; 
        }

        input[type="submit"] {
            background-color: #4a90e2;
            color: black;
            padding: 12px 20px;
            margin-top: 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
             font-weight:bolder;
        }

        input[type="submit"]:hover {
            background-color: #357ab7;
        }

        .otp-button {
            background-color: #4a90e2;
            color: black;
            padding: 12px 20px;
            margin-top: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 15px;
            font-weight:bolder;
        }

        .otp-button:hover {
            background-color: #357ab7;
        }
        .redirect {
    text-align: center;
    font-size: 14px;
    margin-top: 15px;
}

.redirect a {
    color: #4a90e2;
    text-decoration: none;
}

.redirect a:hover {
    text-decoration: underline;
}
        

    </style>
</head>
<body>

   

    <form action="${pageContext.request.contextPath}/TailorHandler?action=TailorRegistrationServlet"  method="post" enctype="multipart/form-data">

         <h2>Tailor Affiliation Form</h2>
        <label for="tailorName">Tailor Name:</label>
        <input type="text" name="tailorName" required>

        <label for="tailorPhone">Phone:</label>
        <input type="text" name="tailorPhone" required>

        <label for="tailorAddress">Address:</label>
        <textarea name="tailorAddress" rows="3" required></textarea>

        <label for="tailorPicture">Upload Tailor Picture:</label>
        <input type="file" name="tailorPicture" accept="image/*" required>

        
        <label for="specialty">Specialty:</label>
        <input type="text" name="specialty" required placeholder="e.g., Shalwar Kameez Specialist">

        <label for="experience">Experience (in years):</label>
        <input type="number" name="experience" required min="1" placeholder="e.g., 10">

        <!-- Login Info -->
        <label for="username">Create Username:</label>
        <input type="text" name="username" required>

        <label for="email">Email (For OTP verification):</label>
        <input type="email" name="email" id="email" required>

        <label for="password">Create Password:</label>
        <input type="password" name="password" required>

        <label for="otp">Enter OTP (Check your email):</label>
        <input type="text" name="otp" id="otp" required>
        
       <button type="button" class="otp-button" onclick="generateOtp()">Generate OTP</button>

        <input type="submit" value="Register Tailor">
        <p class="redirect">Back to home page? <a href="index.jsp">Home</a></p>
        
     <%
    String error = (String) session.getAttribute("errorMessage");
    String success = (String) session.getAttribute("successMessage");
    if (error != null || success != null) {
%>
    <% if (error != null) { %>
        <div style="color: red; text-align: center;"><%= error %></div>
    <% } else if (success != null) { %>
        <div style="color: green; text-align: center;"><%= success %></div>
    <% } %>
<%
        session.removeAttribute("errorMessage");
        session.removeAttribute("successMessage");
    }
%>
        
    </form>

    <script>
    function generateOtp() {
        var email = document.getElementById("email").value;
        
        if (!email || !email.match(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/)) {
            alert("Please enter a valid email address.");
            return;
        }

        var xhr = new XMLHttpRequest();
  
        xhr.open("POST", "${pageContext.request.contextPath}/TailorHandler?action=sendOTP", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4) {
                if (xhr.status == 200) {
                    alert("OTP sent to your email!");
                } else {
                    alert(xhr.status + " Error: " + xhr.responseText);
                }
            }
        };

        xhr.send("email=" + encodeURIComponent(email));
    }

    </script>

</body>
</html>
