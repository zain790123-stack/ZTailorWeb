<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Tailoring Measurements</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        h1 {
            text-align: center;
        }

        form {
            max-width: 500px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        input[type="text"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1em;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        .result {
            max-width: 500px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        .result h2 {
            margin-top: 0;
        }

        ul {
            list-style-type: none;
            padding: 0;
        }

        ul li {
            margin-bottom: 10px;
            font-size: 1em;
        }
        .redirect{
        text-align:center;
        }
        .redirect a{
        text-decoration:none;
        color:blue;
        }
        .redirect a:hover{
         text-decoration:underline;
        }
    </style>
</head>
<body>
    <h1>Tailoring Measurements</h1>
    <form method="post">
        <label for="chest_size">Chest Size (inches):</label>
        <input type="text" id="chest_size" name="chest_size" required>

        <label for="kameez_length">Kameez Length (inches):</label>
        <input type="text" id="kameez_length" name="kameez_length">

        <label for="shalwar_length">Shalwar Length (inches):</label>
        <input type="text" id="shalwar_length" name="shalwar_length">

        <button type="submit">Calculate</button>
            <p class="redirect">Back to home page? <a href="loginIndex.jsp">Home</a></p>
    </form>

    <% 
        
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String chestSizeParam = request.getParameter("chest_size");
            String kameezLengthParam = request.getParameter("kameez_length");
            String shalwarLengthParam = request.getParameter("shalwar_length");

            double chestSize = Double.parseDouble(chestSizeParam);
            Double kameezLength = (kameezLengthParam != null && !kameezLengthParam.isEmpty()) 
                                   ? Double.parseDouble(kameezLengthParam) : null;
            Double shalwarLength = (shalwarLengthParam != null && !shalwarLengthParam.isEmpty()) 
                                    ? Double.parseDouble(shalwarLengthParam) : null;

            double fullChest = chestSize;
            double halfChest = fullChest / 2;
            double kandhaNormal = fullChest / 4;
            double kandhaFitting = kandhaNormal - 1;
            double teeraNormal = (fullChest / 4) + 7;
            double teeraFitting = teeraNormal - 1;
            double gheraKhula = halfChest + 6;
            double gheraNormal = halfChest + 5;
            double gheraFitting = halfChest + 4;
            double hip = gheraNormal - 1;
            double waist = gheraNormal - 2;
            Double pancha = (shalwarLength != null) ? shalwarLength / 4 : null;
            Double sleeves = (kameezLength != null) ? (kameezLength / 2 + 4) : null;
    %>
    <div class="result">
        <h2>Calculated Measurements:</h2>
        <ul>
            <li>Kandha Normal (Armhole): <%= String.format("%.2f", kandhaNormal) %></li>
            <li>Kandha Fitting (Armhole): <%= String.format("%.2f", kandhaFitting) %></li>
            <li>Teera Normal (Waist Curve): <%= String.format("%.2f", teeraNormal) %></li>
            <li>Teera Fitting (Waist Curve): <%= String.format("%.2f", teeraFitting) %></li>
            <li>Ghera Khula: <%= String.format("%.2f", gheraKhula) %></li>
            <li>Ghera Normal: <%= String.format("%.2f", gheraNormal) %></li>
            <li>Ghera Fitting: <%= String.format("%.2f", gheraFitting) %></li>
            <li>Hip: <%= String.format("%.2f", hip) %></li>
            <li>Waist: <%= String.format("%.2f", waist) %></li>
            <% if (pancha != null) { %>
            <li>Pancha: <%= String.format("%.2f", pancha) %></li>
            <% } if (sleeves != null) { %>
            <li>Sleeves: <%= String.format("%.2f", sleeves) %></li>
            <% } %>
        </ul>
    </div>
    <% 
        } 
    %>
    
</body>
</html>
