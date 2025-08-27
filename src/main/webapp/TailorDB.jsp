<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String tailorName = (String) session.getAttribute("tailorName");
    if (tailorName == null || tailorName.isEmpty()) {
        response.sendRedirect("unifiedLogin.jsp");  
        return;
    }
    String tailorEmail = (String) session.getAttribute("tailorEmail");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tailor Dashboard</title>
    <link rel="stylesheet" href="css/tailordb.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css">
</head>
<body>
    <div class="admin-container">
        <h1>Welcome, <%= tailorName %>!</h1>
        <p>Email: <%= tailorEmail %></p>  
        <h1>Tailor Dashboard</h1>

        <div class="section">
            <h2>Custom Tailoring Requests</h2>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Garment Type</th>
                        <th>Salai</th>
                        <th>Deadline</th>
                        <th>Measurements</th>
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

                        String sql = "SELECT * FROM suit_requests WHERE TRIM(LOWER(tailor_name)) = TRIM(LOWER(?))";
                      
                        PreparedStatement ps = conn.prepareStatement(sql);
                        ps.setString(1, tailorName);

                        ResultSet rs = ps.executeQuery();

                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rs.getInt("id") + "</td>");
                            out.println("<td>" + rs.getString("garment") + "</td>");
                            out.println("<td>" + rs.getString("slai") + "</td>");
                            out.println("<td>" + rs.getString("deadline") + "</td>");

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
                            out.println("<td>" + (status == null || status.isEmpty() ? "Pending" : status) + "</td>");

                            Timestamp approvalDate = rs.getTimestamp("approval_date");
                            out.println("<td>" + (approvalDate != null ? approvalDate : " - ") + "</td>");

                            out.println("<td>");
                            out.println("<div class='action-buttons'>");
                            out.println("<button class='approve-btn' onclick=\"updateStatus('" + rs.getInt("id") + "', 'approve', 'suit')\">Approve</button>");
                            out.println("<button class='reject-btn' onclick=\"updateStatus('" + rs.getInt("id") + "', 'reject', 'suit')\">Reject</button>");
                            out.println("<button class='delete-btn' onclick=\"deleteRecord(" + rs.getInt("id") + ", 'suit_requests')\">🗑 Delete</button>");

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
            <h2>Alteration Requests</h2>


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

                        String sql = "SELECT * FROM alteration_requests WHERE TRIM(LOWER(tailor_name)) = TRIM(LOWER(?))";
                        PreparedStatement ps = conn.prepareStatement(sql);
                        ps.setString(1, tailorName);

                        ResultSet rs = ps.executeQuery();

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
                            out.println("<td>" + (status == null || status.isEmpty() ? "Pending" : status) + "</td>");

                            Timestamp approvalDate = rs.getTimestamp("approval_date");
                            out.println("<td>" + (approvalDate != null ? approvalDate : " - ") + "</td>");

                            out.println("<td>");
                            out.println("<div class='action-buttons'>");
                            out.println("<button class='approve-btn' onclick=\"updateStatus('" + rs.getInt("id") + "', 'approve', 'alteration')\">Approve</button>");
                            out.println("<button class='reject-btn' onclick=\"updateStatus('" + rs.getInt("id") + "', 'reject', 'alteration')\">Reject</button>");
                            out.println("<button class='delete-btn' onclick=\"deleteRecord(" + rs.getInt("id") + ", 'alteration_requests')\">🗑 Delete</button>");


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

    </div>

    <p class="redirect">Back to home page? <a href="index.jsp">Home</a></p>
    <script src="javascript/tailordb.js"></script>
</body>
</html>
