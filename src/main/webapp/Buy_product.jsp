<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Shalwar Kameez Designs</title>
  <link rel="stylesheet" href="css/y.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
  <style>
  * {
  box-sizing: border-box;
}

body {
  margin: 0;
  padding: 0;
  font-family: Arial, sans-serif;
  background-color: #f9f9f9;
  color: #333;
}
.header {
  text-align: center;
  background-color: #18191a;
  color: white;
  padding: 20px 0;
}

.header h1 {
  margin: 0;
  font-size: 2.5rem;
  font-weight: 700;
}

.header p {
  margin: 10px 0 0;
  font-size: 1.25rem;
  font-weight: 400;
  color: #ccc;
}
.products-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(30px, 1fr));
    gap: 20px;
    padding: 20px;
    max-width: 1200px;
    margin: 0 auto;
  }
  .product-card {
    background: #fff;
    border: 1px solid #ddd;
    border-radius: 10px;
    overflow: hidden;
    height: 500px;
    text-align: center;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    transition: transform 0.2s ease;
  }
  
  .product-card img {
    width: 100%;
    height: 200px;
  }

.product-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 16px rgba(0,0,0,0.15);
}

.product-card h3 {
  font-size: 1.3rem;
  margin: 15px 10px 5px;
  color: #222;
}

.product-card .price {
  font-size: 1.15rem;
  font-weight: 700;
  color: #007bff;
  margin: 0 10px 10px;
}

.product-card p {
  flex-grow: 1;
  padding: 0 10px 15px;
  font-size: 1rem;
  color: #555;
}

.product-card .btn {
  display: inline-block;
  margin: 0 10px 20px;
  padding: 12px 25px;
  background-color: #ff4500;
  color: #fff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-size: 1rem;
  text-align: center;
  text-decoration: none;
  transition: background-color 0.3s ease;
}

.product-card .btn:hover {
  background-color: #e03e00;
}
.payment-methods {
  background-color: #f1f1f1;
  padding: 30px 20px;
  text-align: center;
  max-width: 1200px;
  margin: 0 auto 30px;
  border-radius: 10px;
}

.payment-methods h2 {
  margin-bottom: 20px;
  font-weight: 700;
  font-size: 1.5rem;
  color: #333;
}

.payment-methods ul {
  list-style: none;
  padding: 0;
  display: flex;
  justify-content: center;
  gap: 30px;
  flex-wrap: wrap;
}

.payment-methods ul li {
  font-size: 1.2rem;
  display: flex;
  align-items: center;
  gap: 12px;
  color: #444;
  font-weight: 500;
}

.payment-methods ul li i {
  font-size: 1.8rem;
  color: #ff4500;
}
.footer p {
  text-align: center;
  background-color: #302e2e;
  color: white;
  margin: 0;
  padding: 15px 0;
  font-size: 1rem;
}
@media (max-width: 480px) {
  .header h1 {
    font-size: 1.8rem;
  }

  .header p {
    font-size: 1rem;
  }

  .payment-methods ul {
    gap: 15px;
  }

  .payment-methods ul li {
    font-size: 1rem;
  }

  .product-card .btn {
    padding: 10px 18px;
    font-size: 0.9rem;
  }
}
.redirect {
    text-align: center;
    font-size: 14px;
    margin-top: 15px;
  
}

.redirect a {
     color:orange;
    text-decoration: none;
}

.redirect a:hover {
    text-decoration: underline;
}
  
  </style>
  
</head>
<body>
  <header class="header">
    <h1>Buy Our Tailoring Products</h1>
    <p>Explore our latest and new tailoring items!</p>
  </header>

  <main class="products-container">
    <div class="product-card">
      <img src="images/shirt.jpg" alt="Shalwar Kameez Design">
      <h3>Elegant Pent Shirt</h3>
      <p class="price">Rs 2500.00</p>
      <p>A stylish and comfortable outfit for any occasion.</p>
      <a class="btn add-to-cart" href="popupForm.jsp?product=Elegant Pent Shirt&price=2500">Add to Cart</a>
    </div>

    <div class="product-card">
      <img src="images/trouser.jpg" alt="Shalwar Kameez Design">
      <h3>Classic Kurta Pajama</h3>
      <p class="price">Rs 1800.00</p>
      <p>Perfect for formal events and traditional gatherings.</p>
      <a class="btn add-to-cart" href="popupForm.jsp?product=Classic Kurta Pajama&price=1800">Add to Cart</a>
    </div>

    <div class="product-card">
      <img src="images/shalwarkameez.jpg" alt="Shalwar Kameez Design">
      <h3 >Casual  Shalwar Kameez</h3>
      <p class="price">Rs 1600.00</p>
      <p>Designed for comfort and style in everyday wear.</p>
      <a class="btn add-to-cart" href="popupForm.jsp?product=Casual  Shalwar Kameez&price=1600">Add to Cart</a>
    </div>

    <div class="product-card">
      <img src="images/sw1.jpg" alt="Sewing Machine">
      <h3>Compact Sewing Machine</h3>
      <p class="price">Rs 35600.00</p>
      <p>Lightweight and easy-to-use sewing machine for beginners.</p>
      <a class="btn add-to-cart" href="popupForm.jsp?product=Compact Sewing Machine&price=356000">Add to Cart</a>
    </div>
  
    <div class="product-card">
      <img src="images/sw2.jpg" alt="Sewing Machine">
      <h3>Professional juki Sewing Machine</h3>
      <p class="price">Rs 40000.00</p>
      <p>Advanced features for professional and home use.</p>
      <a class="btn add-to-cart" href="popupForm.jsp?product=Professional juki Sewing Machine&price=40000">Add to Cart</a>
    </div>
  
    <div class="product-card">
      <img src="images/sw3.jpg" alt="Sewing Machine">
      <h3>Singer Sewing Machine</h3>
      <p class="price">Rs 12000.00</p>
      <p>Ideal for sewing thick fabrics like denim .</p>
      <a class="btn add-to-cart" href="popupForm.jsp?product=Singer Sewing Machine&price=12000">Add to Cart</a>
    </div>
  </main>

  <footer class="footer">
    <div class="payment-methods">
      <h2>Payment Methods:</h2>
      <ul>
        <li><i class="fas fa-credit-card"></i> Credit/Debit Cards</li>
        <li>JazzCash</li>
        <li><i class="fas fa-university"></i> Bank Transfer</li>
        <li><i class="fas fa-money-bill-wave"></i> Cash on Delivery</li>
      </ul>
    </div>
    <p class="redirect">Back to home page? <a href="loginIndex.jsp">Home</a></p>
    <p>&copy; 2025 ZTailor Craft. All rights reserved.</p>
  </footer>

</body>
</html>
