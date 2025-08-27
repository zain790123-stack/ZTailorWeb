
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
    <title>Suit Stitching Form</title>
    <style>
    body{
     background: black;
    }
.container {
    max-width: 800px;
    margin: 0 auto;
    padding: 30px;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
    font-family: Arial, sans-serif;
}

.container h1 {
    text-align: center;
    margin-bottom: 25px;
    color: #333;
}
form label {
    display: block;
    margin-top: 15px;
    font-weight: 600;
    color: #333;
}

form input[type="text"],
form input[type="file"],
form select,
form textarea {
    width: 100%;
    padding: 8px 10px;
    margin-top: 5px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 14px;
}

.date-picker-wrapper {
    margin-top: 15px;
    cursor: pointer;
    display: flex;
    flex-direction: column;
    font-weight: 600;
    color: #333;
}

.date-picker-wrapper input[type="date"] {
    margin-top: 5px;
    padding: 8px 10px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 4px;
    cursor: pointer;
}

form input[type="submit"] {
    margin-top: 20px;
    background-color: #28a745;
    color: white;
    padding: 10px;
    font-size: 16px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

form input[type="submit"]:hover {
    background-color: #218838;
}
.price-display {
    margin-top: 15px;
    font-size: 16px;
    font-weight: bold;
    color: #007bff;
}
.redirect {
    text-align: center;
    margin-top: 20px;
    font-size: 14px;
}

.redirect a {
    color: #007bff;
    text-decoration: none;
}

.redirect a:hover {
    text-decoration: underline;
}
    
    </style>
    
</head>
<body>
    <div class="container">
        <h1>Suit Stitching Request</h1>
        <form action="suitServlet" method="POST" enctype="multipart/form-data">
            <label for="garment">Suit Stitching</label>
            <select id="garment" name="garment" required>
                <option value="">-- Please choose --</option>
                <option value="shalwar_kameez">Shalwar Kameez</option>
                <option value="kurta_pajama">Kurta Pajama</option>
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
            

            <label for="slai">Slai:</label>
            <select id="slai" name="slai" required onchange="calculatePrice()">
                <option value="">-- Please choose --</option>
                <option value="single">Single 1000</option>
                <option value="double">Double 1500</option>
                
            </select>
            <div class="date-picker-wrapper" onclick="toggleDatePicker()">
            <label for="date">Deadline:</label>
            <input type="date" id="date" name="date" required onchange="calculatePrice()">
           </div>
            

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
    
    <script>
    
    let pickerOpen = false;

    function toggleDatePicker() {
        const dateInput = document.getElementById('date');

        if (!pickerOpen) {
            if (typeof dateInput.showPicker === 'function') {
                dateInput.showPicker();
            } else {
                dateInput.focus();
            }
            pickerOpen = true;
        } else {
            // Blur will simulate closing the picker
            dateInput.blur();
            pickerOpen = false;
        }
    }

    // Reset state when user manually closes picker or clicks outside
    document.getElementById('date').addEventListener('blur', () => {
        pickerOpen = false;
    });
    // Show/Hide Measurement Section
    function toggleMeasurementSection() {
        const checkbox = document.getElementById('provideMeasurements');
        const section = document.getElementById('measurement-section');
        section.style.display = checkbox.checked ? 'block' : 'none';
    }

    // Price Calculation
    function calculatePrice() {
        const slai = document.getElementById("slai").value;
        const dateInput = document.getElementById("date").value;
        const priceDisplay = document.getElementById("price-display");

        let basePrice = 0;

        if (slai === "single") {
            basePrice = 1000;
        } else if (slai === "double") {
            basePrice = 2000;
        }

        // Deadline price logic
        if (dateInput) {
            const today = new Date();
            const deadline = new Date(dateInput);

            const diffTime = deadline - today;
            const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

            if (diffDays < 7) {
                basePrice += 500;
            }
        }

        priceDisplay.textContent = "Estimated Price: Rs " + basePrice;
    }
</script>
    

</body>
</html>

