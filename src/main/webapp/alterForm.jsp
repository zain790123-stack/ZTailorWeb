
<%@page import="java.util.Iterator"%>
<%@ 
page import="java.util.List"
 language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alteration Services</title>
    <link rel="stylesheet" href="css/Alteration.css">
</head>
<body>
    <div class="container">
        <h1>Patch Work Request</h1>
        <form action="AlterServlet" method="POST" enctype="multipart/form-data">
            <label for="garment">Select Garment Type:</label>
            <select id="garment" name="garment" required>
                <option value="">-- Please choose --</option>
                <option value="pant">Pant</option>
                <option value="trouser">Trouser</option>
                <option value="shalwar-kameez">Shalwar Kameez</option>
                <option value="shirt">Shirt</option>
            </select>
            
            <label for="tailor">Select Tailor:</label>
           <select id="tailor" name="tailor" required>
           <option value="">-- Please choose --</option>
           <option value="Mohsin">Mohsin</option>
           <option value="Raza">Raza</option>
           <option value="yasir">Yasir</option>
           <option value="chand">Chand</option>
           <option value="azher">Azher</option>
           </select>
            

            <label for="alteration-type">Select Alteration Type:</label>
            <select id="alteration-type" name="alteration-type" required onchange="calculatePrice()">
                <option value="">-- Please choose --</option>
                <option value="short">Decrease Length</option>
                <option value="long">Increase Length</option>
                <option value="patch">Patch work</option>
                <option value="complete-redesign">Complete Redesign</option>
            </select>

            <label for="date">Deadline :</label>
            <input type="date" id="date" name="date" required onchange="calculatePrice()">

             <div id="price-display" class="price-display">Estimated Price: Rs 0</div>

            <label for="face-picture">Upload cloth Picture:</label>
            <input type="file" id="face-picture" name="face-picture" accept="image/*" required>

            <label for="customer-name">Your Name:</label>
            <input type="text" id="customer-name" name="customer-name" placeholder="Enter your name" required>

            <label for="customer-phone">Your Phone Number:</label>
            <input type="text" id="customer-phone" name="customer-phone" placeholder="Enter your phone number" required>

            <label for="customer-whatsapp">Your WhatsApp Number:</label>
            <input type="text" id="customer-whatsapp" name="customer-whatsapp" placeholder="Enter your WhatsApp number" >

            <label for="customer-address">Your Address:</label>
            <textarea id="customer-address" name="customer-address" rows="3" placeholder="Enter your address" required></textarea>

            <label for="notes">Additional Notes:</label>
            <textarea id="notes" name="notes" class="notes" rows="4" placeholder="Provide specific details about your alteration request..."></textarea>

            <input type="submit" value="Submit Request">
        </form>
<%
    String success = (String) session.getAttribute("success");
    if (success != null) {
%>
    <p style="color: green; font-weight: bold; text-align: center;"><%= success %></p>
<%
    }
    session.removeAttribute("success");
    Object errObj = request.getAttribute("errlist");
    if (errObj instanceof java.util.List<?>) {
        java.util.List<?> rawList = (java.util.List<?>) errObj;
        for (Object err : rawList) {
            if (err instanceof String) {
%>
    <p style="color: red; font-weight: bold;"><%= (String) err %></p>
<%
            }
        }
    }
%>

        <p class="redirect">Back to home page? <a href="loginIndex.jsp">Home</a></p>
    </div>
    <script src="javascript/alterform.js"></script>
</body>
</html>

