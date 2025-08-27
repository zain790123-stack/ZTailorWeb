<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AdminDashboard</title>
    <link rel="stylesheet" href="css/AdminDash.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css">
    <script>
    const contextPath = '<%= request.getContextPath() %>';
    </script>
    
</head>
<body>
    <div class="admin-container">
        <h1>Admin Dashboard</h1>
        <h2>Suit Tailoring</h2>
        
            <form method="post" action="AdminDashAlldelete.jsp?table=suit_requests" onsubmit="return confirm('Are you sure you want to delete ALL tailoring requests?');">
            <button type="submit" class="delete-all-btn">🗑 Delete All Tailoring Requests</button>
            </form>
        
        <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Garment Type</th>
                        <th>Salai</th>
                        <th>Deadline</th>
                        <th>Tailor</th>
                        <th>Customer Name</th>
                        <th>Customer Phone</th>
                        <th>Customer Address</th>
                        <th>Cloth Image</th>
                        <th>Submission Date</th>
                            <th>Status</th>
                          <th>Approval Date</th>
                          <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/tailor_db", "root", "12345");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM suit_requests");
                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rs.getInt("id") + "</td>");
                            out.println("<td>" + rs.getString("garment") + "</td>");
                            out.println("<td>" + rs.getString("slai") + "</td>");
                            out.println("<td>" + rs.getString("deadline") + "</td>");
                            out.println("<td>" + rs.getString("tailor_name") + "</td>");

                            out.println("<td>" + rs.getString("customer_name") + "</td>");
                            out.println("<td>" + rs.getString("customer_phone") + "</td>");
                            out.println("<td>" + rs.getString("customer_address") + "</td>");

                            String imagePath = rs.getString("cloth_image");
                            if (imagePath != null && !imagePath.isEmpty()) {
                                out.println("<td><img src='uploads/custom_tailor/" + imagePath + "' alt='Cloth Image' width='100'></td>");
                            } else {
                                out.println("<td>No Image</td>");
                            }

                            out.println("<td>" + rs.getTimestamp("created_at") + "</td>");
                           
                            String status = rs.getString("status");
                            if (status == null || status.isEmpty()) {
                                out.println("<td></td>");
                            } else {
                                out.println("<td>" + status + "</td>");
                            }

                            Timestamp approvalDate = rs.getTimestamp("approval_date");
                            if (approvalDate != null) {
                                out.println("<td>" + approvalDate + "</td>");
                            } else {
                                out.println("<td> - </td>");
                            }

                            out.println("<td>");
                            out.println("<div class='action-buttons'>");

                            out.println("<button class='delete-btn' onclick=\"deleteRecord('" + rs.getInt("id") + "', 'suit_requests')\">Delete</button>");
                            out.println("</div>");
                            out.println("</td>");


                            out.println("</tr>");
                        }
                              

                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<tr><td colspan='23' style='color:red;'>Error retrieving data from the database.</td></tr>");
                    }
                    %>
                </tbody>
          </table>
        
      
        <div class="section">
            <h2>Alteration Requests</h2>
            <form method="post" action="AdminDashAlldelete.jsp?table=alteration_requests" onsubmit="return confirm('Are you sure you want to delete ALL alteration requests?');">
            <button type="submit" class="delete-all-btn">🗑 Delete All Alteration Requests</button>
            </form>

            
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Garment</th>
                        <th>Alteration Type</th>
                        <th>Deadline</th>
                        <th>Customer Name</th>
                        <th>Customer Phone</th>
                        <th>Customer WhatsApp</th>
                        <th>Customer Address</th>
                        <th>Cloth Image</th>
                        <th>Created At</th>
                         <th>Status</th>
                          <th>Approval Date</th>
                          <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/tailor_db", "root", "12345");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM alteration_requests");
                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rs.getInt("id") + "</td>");
                            out.println("<td>" + rs.getString("garment") + "</td>");
                            out.println("<td>" + rs.getString("alteration_type") + "</td>");
                            out.println("<td>" + rs.getString("deadline") + "</td>");
                            out.println("<td>" + rs.getString("customer_name") + "</td>");
                            out.println("<td>" + rs.getString("customer_phone") + "</td>");
                            out.println("<td>" + rs.getString("customer_whatsapp") + "</td>");
                            out.println("<td>" + rs.getString("customer_address") + "</td>");
                            
                            String imagePath = rs.getString("cloth_image");
                            if (imagePath != null && !imagePath.isEmpty()) {
                                out.println("<td><img src='uploads/alteration/" + imagePath + "' alt='Cloth Image' width='100'></td>");
                            } else {
                                out.println("<td>No Image</td>");
                            }
                            
                            out.println("<td>" + rs.getTimestamp("created_at") + "</td>");

                            String status = rs.getString("status");
                            if (status == null || status.isEmpty()) {
                                out.println("<td>Pending</td>");
                            } else {
                                out.println("<td>" + status + "</td>");
                            }

                            Timestamp approvalDate = rs.getTimestamp("approval_date");
                            if (approvalDate != null) {
                                out.println("<td>" + approvalDate + "</td>");
                            } else {
                                out.println("<td> - </td>");
                            }

                        
                            out.println("<td>");
                            out.println("<div class='action-buttons'>");

                            out.println("<button class='delete-btn' onclick=\"deleteRecord('" + rs.getInt("id") + "', 'alteration_requests')\">Delete</button>");
                            out.println("</div>");
                            out.println("</td>");

                            out.println("</tr>");
                        }
                        
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<tr><td colspan='11' style='color:red;'>Error retrieving data from the database.</td></tr>");
                    }
                    %>
                  </tbody>
                  </table>
               
         <div class="section">
                  <h2>Tailors Details</h2>
            
                    <form method="post" action="AdminDashAlldelete.jsp?table=tailors" onsubmit="return confirm('Are you sure you want to delete ALL tailor Login Data?');">
                    <button type="submit" class="delete-all-btn">🗑 Delete All Tailor Data</button> <a class="approve-tailors"href="ApproveTailors.jsp">Check Approved Tailors</a>
                    </form>
                  <table>
                   <thead>
                    <tr>
                        <th>ID</th>
                        <th>name</th>
                        <th>phone</th>
                        <th>address</th>
                        <th>picture</th>
                        <th>email</th>
                        <th>status</th>
                        <th>Approval Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                 <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/tailor_db", "root", "12345");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM tailors");
                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rs.getInt("id") + "</td>");
                            out.println("<td>" + rs.getString("name") + "</td>");
                            out.println("<td>" + rs.getString("phone") + "</td>");
                            out.println("<td>" + rs.getString("address") + "</td>");
                
                            String picturePath = rs.getString("picture_path"); 
                            out.println("<td><img src='" + request.getContextPath() + "/" + picturePath + "' width='80' height='80'/></td>");
                            out.println("<td>" + rs.getString("email") + "</td>");
                            out.println("<td>" + rs.getString("status") + "</td>");
                            Timestamp approvalDate = rs.getTimestamp("approval_time");
                            out.println("<td>" + (approvalDate != null ? approvalDate : " - ") + "</td>");
                            out.println("<td>");
                            out.println("<div class='action-buttons'>");
                            int id = rs.getInt("id");
                            out.println("<button class='approve-btn' onclick=\"TailorupdateStatus(" + id + ", 'approve')\">Approve</button>");
                            out.println("<button class='reject-btn' onclick=\"TailorupdateStatus(" + id + ", 'reject')\">Reject</button>");
                            out.println("<button class='delete-btn' onclick=\"deleteRecord('" + rs.getInt("id") + "', 'tailors')\">Delete</button>");


                            out.println("</div>");
                            out.println("</td>");

                            out.println("</tr>");
                        }
                        
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<tr><td colspan='11' style='color:red;'>Error retrieving data from the database.</td></tr>");
                    }
                    %>
                </tbody>
            </table>
        </div>
        
         <div class="section">
            <h2>Orders Requests</h2>
            <form method="post" action="AdminDashAlldelete.jsp?table=orders" onsubmit="return confirm('Are you sure you want to delete ALL tailoring requests?');">
                <button type="submit" class="delete-all-btn">🗑 Delete All Order Requests</button>
            </form>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>name</th>
                        <th>phone</th>
                        <th>Product</th>
                        <th>address</th>
                        <th>payment</th>
                        <th>order Id</th>
                        <th>price</th>
                        <th>Submission Date</th>
                        <th>Status</th>
                        <th>Approval Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/tailor_shop", "root", "12345");

                        String sql = "SELECT * FROM orders ";
                      
                        PreparedStatement ps = conn.prepareStatement(sql);
                       

                        ResultSet rs = ps.executeQuery();

                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rs.getInt("id") + "</td>");
                            out.println("<td>" + rs.getString("name") + "</td>");
                            out.println("<td>" + rs.getString("phone") + "</td>");
                            out.println("<td>" + rs.getString("product_name") + "</td>");

                            out.println("<td>" + rs.getString("address") + "</td>");
                            out.println("<td>" + rs.getString("payment_method") + "</td>");
                            out.println("<td>" + rs.getString("order_id") + "</td>");
                            out.println("<td>" + rs.getString("price") + "</td>");
      
                            String status = rs.getString("status");
                            out.println("<td>" + (status == null || status.isEmpty() ? "Pending" : status) + "</td>");

                            Timestamp approvalDate = rs.getTimestamp("approval_date");
                            out.println("<td>" + (approvalDate != null ? approvalDate : " - ") + "</td>");

                            out.println("<td>");
                            out.println("<div class='action-buttons'>");
                            out.println("<button class='approve-btn' onclick=\"updateStatus('" + rs.getInt("id") + "', 'approve')\">Approve</button>");
                            out.println("<button class='reject-btn' onclick=\"updateStatus('" + rs.getInt("id") + "', 'reject')\">Reject</button>");
                            out.println("<button class='delete-btn' onclick=\"deleteRecord('" + rs.getInt("id") + "', 'orders')\">Delete</button>");
                            out.println("</div>");
                            out.println("</td>");

                            out.println("</tr>");
                        }

                        rs.close();
                        ps.close();
                        conn.close();

                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<tr><td colspan='13' style='color:red;'>Error retrieving data from the database.</td></tr>");
                    }
                    %>
                </tbody>
            </table>
        </div>

   <div class="section">
                  <h2>User Details</h2>
            
                    <form method="post" action="AdminDashAlldelete.jsp?table=signup_login" onsubmit="return confirm('Are you sure you want to delete ALL Login Data?');">
                    <button type="submit" class="delete-all-btn">🗑 Delete All Login Datas</button>
                    </form>
                  <table>
                   <thead>
                    <tr>
                        <th>ID</th>
                        <th>username</th>
                        <th>password</th>
                        <th>email</th>
                        <th>Created At</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                 <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/tailor_db", "root", "12345");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM signup_login");
                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rs.getInt("id") + "</td>");
                            out.println("<td>" + rs.getString("username") + "</td>");
                            out.println("<td>" + rs.getString("password") + "</td>");
                            out.println("<td>" + rs.getString("email") + "</td>");

                            out.println("<td>" + rs.getTimestamp("created_at") + "</td>");
                            out.println("<td>");
                            out.println("<div class='action-buttons'>");
                            out.println("<button class='delete-btn' onclick=\"deleteRecord('" + rs.getInt("id") + "', 'signup_login')\">Delete</button>");
                            out.println("<button class='edit-btn' onclick=\"editRecord('" + rs.getInt("id") + "', 'Login')\">Edit</button>");
                            out.println("</div>");
                            out.println("</td>");

                            out.println("</tr>");
                        }
                        
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<tr><td colspan='11' style='color:red;'>Error retrieving data from the database.</td></tr>");
                    }
                    %>
                </tbody>
            </table>
        </div>
        
    
    </div>
    </div>
     <p class="redirect">Back to home page? <a href="index.jsp">Home</a></p>
    <script src="javascript/admindash.js"></script>
</body>
</html>