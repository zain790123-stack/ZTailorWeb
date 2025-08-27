package com.tailor.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/submitOrder")
public class submitOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	  private final String JDBC_URL = "jdbc:mysql://localhost:3306/tailor_shop";
	    private final String JDBC_USER = "root";
	    private final String JDBC_PASS = "12345";

	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        
	        String name = request.getParameter("name");
	        String phone = request.getParameter("phone");
	        String address = request.getParameter("address");
	        String payment = request.getParameter("payment");
	        String productName = request.getParameter("product");
	        String priceStr = request.getParameter("price");
	        double price = Double.parseDouble(priceStr);
	        String orderId = "ORI" + System.currentTimeMillis();


	        try {
	            Class.forName("com.mysql.cj.jdbc.Driver");
	            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);

	            String sql = "INSERT INTO orders (name, phone, address, payment_method, order_id, product_name, price) VALUES (?, ?, ?, ?, ?, ?, ?)";
	            PreparedStatement stmt = conn.prepareStatement(sql);
	            stmt.setString(1, name);
	            stmt.setString(2, phone);
	            stmt.setString(3, address);
	            stmt.setString(4, payment);
	            stmt.setString(5, orderId); 
	            stmt.setString(6, productName);
	            stmt.setDouble(7, price);

	            stmt.executeUpdate();

	            stmt.close();
	            conn.close();

	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        String jazzcashAccount = "0314-9234937";
	        String bankAccount = "PK12ABCD0001234567890001";

	        response.setContentType("text/html");
	        PrintWriter out = response.getWriter();

	        out.println("<!DOCTYPE html>");
	        out.println("<html><head><title>Order Confirmation</title>");
	        out.println("<style>");
	        out.println("body { font-family: Arial; text-align: center; background-color: #f5f5f5; padding: 50px; }");
	        out.println(".box { background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); display: inline-block; max-width: 500px; }");
	        out.println("h1 { color: #4CAF50; }");
	        out.println(".payment-info { margin-top: 20px; padding: 15px; background: #e7f3fe; border: 1px solid #2196F3; border-radius: 5px; color: #0b5394; }");
	        out.println(".btn-home { margin-top:30px; padding:12px 25px; background-color:#007bff; color:white; border:none; border-radius:5px; text-decoration:none; font-size:1rem; display:inline-block; cursor:pointer; transition:background-color 0.3s ease; } .btn-home:hover { background-color:#0056b3; }");
	        out.println("</style>");
	        out.println("</head><body>");

	        out.println("<div class='box'>");
	        out.println("<h1>Thank You, " + name + "!</h1>");
	        out.println("<p>Your order has been saved in our system.</p>");
	        out.println("<p><strong>Order ID:</strong> " + orderId + "</p>");
	        out.println("<p><strong>Product:</strong> " + productName + "</p>");
	        out.println("<p><strong>Price:</strong> Rs " + price + "</p>");
	        out.println("<p>We will contact you at <strong>" + phone + "</strong>.</p>");

	        if ("JazzCash".equals(payment)) {
	            out.println("<div class='payment-info'>");
	            out.println("<p>Please send payment to our JazzCash account:</p>");
	            out.println("<p><strong>" + jazzcashAccount + "</strong></p>");
	            out.println("</div>");
	        } else if ("Bank Transfer".equals(payment)) {
	            out.println("<div class='payment-info'>");
	            out.println("<p>Please transfer payment to our bank account:</p>");
	            out.println("<p><strong>Account No: " + bankAccount + "</strong></p>");
	            out.println("</div>");
	        } else if ("Credit Card".equals(payment)) {
	            out.println("<div class='payment-info'>");
	            out.println("<p>We will send you a credit card payment link shortly.</p>");
	            out.println("</div>");
	        } else {
	            out.println("<div class='payment-info'>");
	            out.println("<p>Please prepare cash. Our courier will collect it upon delivery (COD).</p>");
	            out.println("</div>");
	        }
	        out.println("<a href='Buy_product.jsp' class='btn-home' role='button'>Back to Home</a>");
	  
	        out.println("</div></body></html>");
	    }
	}
