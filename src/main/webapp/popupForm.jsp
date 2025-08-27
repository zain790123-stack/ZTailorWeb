<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Order Form</title>
  <style>
  
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: Arial, sans-serif;
  background-color: #f5f5f5;
  padding: 20px;
}

h1 {
  text-align: center;
  margin-bottom: 20px;
  color: #333;
}

form {
  background-color: #fff;
  max-width: 500px;
  margin: 0 auto;
  padding: 30px;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

label {
  display: block;
  margin-bottom: 5px;
  font-weight: bold;
  color: #555;
}

input[type="text"],
input[type="tel"],
textarea,
select {
  width: 100%;
  padding: 10px;
  margin-bottom: 20px;
  border: 1px solid #ddd;
  border-radius: 5px;
  font-size: 16px;
}

textarea {
  resize: vertical;
}

button[type="submit"] {
  background-color: #4CAF50;
  color: white;
  border: none;
  padding: 12px 20px;
  border-radius: 5px;
  font-size: 16px;
  cursor: pointer;
  width: 100%;
  transition: background-color 0.3s ease;
}

button[type="submit"]:hover {
  background-color: #45a049;
}

@media (max-width: 600px) {
  form {
    padding: 20px;
  }
}
  
  </style>
</head>
<script>
  window.onload = function () {
    const params = new URLSearchParams(window.location.search);
    const product = params.get("product");
    const price = params.get("price");

    if (product && price) {
      document.getElementById("product").value = product;
      document.getElementById("price").value = price;
    }
  };
</script>


<body>
  <h1>Order Form</h1>
  <form action="submitOrder" method="POST">
  <label for="name">Name:</label>
  <input type="text" id="name" name="name" required><br><br>
  
  <label for="phone">Phone Number:</label>
  <input type="tel" id="phone" name="phone" required><br><br>

  <label for="address">Address:</label>
  <textarea id="address" name="address" required></textarea><br><br>
  
   <label for="product">Product Name:</label>
  <input type="text" id="product" name="product" required><br><br>
  
   <label for="price">Price:</label>
  <input type="text" id="price" name="price" required><br><br>

  <label for="payment">Payment Method:</label>
  <select id="payment" name="payment" required>
    <option value="Credit Card">Credit/Debit Card</option>
    <option value="JazzCash">JazzCash</option>
    <option value="Bank Transfer">Bank Transfer</option>
    <option value="Cash on Delivery">Cash on Delivery</option>
  </select><br><br>

  <button type="submit">Buy Product</button>
</form>

</body>
</html>
