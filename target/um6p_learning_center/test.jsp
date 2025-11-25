<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>UM6P Test Page</title>
</head>
<body>
    <h1>UM6P Learning Center - Test Page</h1>
    <p>If you can see this, JSP is working!</p>
    
    <%
        out.println("<p>Server time: " + new java.util.Date() + "</p>");
        
        // Test database connection
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            out.println("<p style='color: green'>MySQL driver loaded successfully</p>");
            
            java.sql.Connection conn = java.sql.DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/um6p_learning_center", 
                "root", 
                "Informatique12@!"
            );
            out.println("<p style='color: green'>Database connection successful!</p>");
            conn.close();
            
        } catch (Exception e) {
            out.println("<p style='color: red'>Error: " + e.getMessage() + "</p>");
        }
    %>
</body>
</html>