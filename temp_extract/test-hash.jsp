<%@ page import="com.um6p.util.PasswordUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Password Hash Tester</title>
</head>
<body>
    <h1>Password Hash Generator</h1>
    <%
        String password = "Password123";
        String hash = PasswordUtil.hashPassword(password);
        boolean verified = PasswordUtil.verifyPassword(password, hash);

        // Test with old hash
        String oldHash = "$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyJgHlqKe/TK";
        boolean oldVerified = PasswordUtil.verifyPassword(password, oldHash);
    %>

    <h2>Results:</h2>
    <p><strong>Password:</strong> <%= password %></p>
    <p><strong>New Hash:</strong> <%= hash %></p>
    <p><strong>Verification:</strong> <%= verified ? "SUCCESS" : "FAILED" %></p>

    <hr>

    <p><strong>Old Hash:</strong> <%= oldHash %></p>
    <p><strong>Old Hash Verification:</strong> <%= oldVerified ? "SUCCESS" : "FAILED" %></p>

    <hr>
    <p>Copy the "New Hash" above and use it in the database!</p>
</body>
</html>
