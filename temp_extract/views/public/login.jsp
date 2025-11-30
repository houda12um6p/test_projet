<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In - UM6P Learning Center</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@600;700;800&family=Open+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --um6p-red: #D94A3D;
            --um6p-red-dark: #B83D32;
            --navy: #1E3A8A;
            --navy-dark: #1E293B;
            --gray-50: #F9FAFB;
            --gray-100: #F3F4F6;
            --gray-200: #E5E7EB;
            --gray-700: #374151;
            --gray-900: #111827;
        }

        body {
            font-family: 'Open Sans', sans-serif;
            background: linear-gradient(135deg, var(--navy) 0%, var(--navy-dark) 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
            margin: 0;
            padding: 20px;
        }

        /* Background patterns */
        .bg-pattern {
            position: absolute;
            opacity: 0.05;
        }

        .pattern-1 {
            top: -100px;
            right: -100px;
            width: 400px;
            height: 400px;
            border: 2px solid white;
            border-radius: 50%;
        }

        .pattern-2 {
            bottom: -100px;
            left: -100px;
            width: 300px;
            height: 300px;
            border: 2px solid white;
            border-radius: 50%;
        }

        .login-container {
            background: white;
            border-radius: 0;
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 1000px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            overflow: hidden;
            position: relative;
            z-index: 10;
            animation: slideUp 0.6s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Left side - Branding */
        .login-left {
            background: linear-gradient(135deg, var(--um6p-red) 0%, var(--um6p-red-dark) 100%);
            padding: 60px;
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .logo-section {
            margin-bottom: 40px;
        }

        .um6p-logo {
            height: 50px;
            margin-bottom: 24px;
        }

        .brand-title {
            font-family: 'Montserrat', sans-serif;
            font-size: 36px;
            font-weight: 800;
            margin-bottom: 16px;
            line-height: 1.2;
        }

        .brand-subtitle {
            font-size: 18px;
            opacity: 0.95;
            line-height: 1.6;
            margin-bottom: 40px;
        }

        .features-list {
            list-style: none;
        }

        .feature-item {
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .feature-icon {
            width: 40px;
            height: 40px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
        }

        .feature-text {
            font-size: 16px;
            font-weight: 500;
        }

        .copyright {
            font-size: 13px;
            opacity: 0.7;
            margin-top: 40px;
        }

        /* Right side - Form */
        .login-right {
            padding: 60px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-header {
            margin-bottom: 40px;
        }

        .login-header h2 {
            font-family: 'Montserrat', sans-serif;
            font-size: 32px;
            font-weight: 800;
            color: var(--gray-900);
            margin-bottom: 8px;
        }

        .login-header p {
            color: var(--gray-700);
            font-size: 15px;
        }

        /* Alert Messages */
        .alert {
            padding: 12px 16px;
            border-radius: 4px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 14px;
        }

        .alert-error {
            background: #FEE2E2;
            color: #991B1B;
            border-left: 4px solid #DC2626;
        }

        .alert-success {
            background: #D1FAE5;
            color: #065F46;
            border-left: 4px solid #10B981;
        }

        .form-group {
            margin-bottom: 24px;
        }

        label {
            display: block;
            color: var(--gray-900);
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray-700);
            font-size: 18px;
        }

        input {
            width: 100%;
            padding: 14px 16px 14px 48px;
            border: 2px solid var(--gray-200);
            border-radius: 4px;
            font-size: 15px;
            font-family: 'Open Sans', sans-serif;
            transition: all 0.3s ease;
            background: var(--gray-50);
        }

        input:focus {
            outline: none;
            border-color: var(--um6p-red);
            background: white;
        }

        .options-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
        }

        .remember-me {
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--gray-700);
            font-size: 14px;
        }

        .remember-me input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
            padding: 0;
        }

        .forgot-link {
            color: var(--um6p-red);
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .forgot-link:hover {
            color: var(--um6p-red-dark);
        }

        .login-button {
            width: 100%;
            padding: 16px;
            background: var(--um6p-red);
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: 700;
            font-family: 'Montserrat', sans-serif;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .login-button:hover {
            background: var(--um6p-red-dark);
        }

        .divider {
            display: flex;
            align-items: center;
            gap: 16px;
            margin: 32px 0;
            color: var(--gray-700);
            font-size: 14px;
        }

        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: var(--gray-200);
        }

        .register-link {
            text-align: center;
            color: var(--gray-700);
            font-size: 14px;
        }

        .register-link a {
            color: var(--um6p-red);
            text-decoration: none;
            font-weight: 700;
            transition: color 0.3s ease;
        }

        .register-link a:hover {
            color: var(--um6p-red-dark);
        }

        .back-link {
            margin-top: 24px;
            text-align: center;
        }

        .back-link a {
            color: var(--gray-700);
            font-size: 14px;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .back-link a:hover {
            color: var(--um6p-red);
        }

        /* Responsive */
        @media (max-width: 968px) {
            .login-container {
                grid-template-columns: 1fr;
                max-width: 500px;
            }

            .login-left {
                display: none;
            }

            .login-right {
                padding: 40px;
            }
        }

        @media (max-width: 480px) {
            body {
                padding: 10px;
            }

            .login-right {
                padding: 30px;
            }

            .login-header h2 {
                font-size: 28px;
            }
        }
    </style>
</head>
<body>
    <div class="bg-pattern pattern-1"></div>
    <div class="bg-pattern pattern-2"></div>

    <div class="login-container">
        <!-- Left Side - Branding -->
        <div class="login-left">
            <div class="logo-section">
                <svg class="um6p-logo" viewBox="0 0 200 50" xmlns="http://www.w3.org/2000/svg">
                    <rect x="10" y="10" width="35" height="30" fill="white"/>
                    <text x="50" y="35" font-family="Montserrat, sans-serif" font-size="24" font-weight="800" fill="white">UM6P</text>
                </svg>

                <h1 class="brand-title">Learning Center Portal</h1>
                <p class="brand-subtitle">Access your academic resources and connect with UM6P's vibrant learning community</p>
            </div>

            <ul class="features-list">
                <li class="feature-item">
                    <div class="feature-icon">
                        <i class="fas fa-book"></i>
                    </div>
                    <span class="feature-text">Access 5,000+ books and resources</span>
                </li>
                <li class="feature-item">
                    <div class="feature-icon">
                        <i class="fas fa-calendar"></i>
                    </div>
                    <span class="feature-text">Register for workshops and events</span>
                </li>
                <li class="feature-item">
                    <div class="feature-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <span class="feature-text">Track your learning progress</span>
                </li>
                <li class="feature-item">
                    <div class="feature-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <span class="feature-text">Connect with the academic community</span>
                </li>
            </ul>

            <div class="copyright">
                © 2025 Mohammed VI Polytechnic University
            </div>
        </div>

        <!-- Right Side - Login Form -->
        <div class="login-right">
            <div class="login-header">
                <h2>Welcome Back</h2>
                <p>Sign in to your account to continue</p>
            </div>

            <!-- Error/Success Messages -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> ${success}
                </div>
            </c:if>

            <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <div class="input-wrapper">
                        <i class="input-icon fas fa-envelope"></i>
                        <input type="email" id="email" name="email" placeholder="student@um6p.ma" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-wrapper">
                        <i class="input-icon fas fa-lock"></i>
                        <input type="password" id="password" name="password" placeholder="Enter your password" required>
                    </div>
                </div>

                <div class="options-row">
                    <label class="remember-me">
                        <input type="checkbox" id="remember" name="remember">
                        <span>Remember me</span>
                    </label>
                    <a href="#forgot" class="forgot-link">Forgot Password?</a>
                </div>

                <button type="submit" class="login-button">Sign In</button>

                <div class="divider">OR</div>

                <div class="register-link">
                    Don't have an account? <a href="${pageContext.request.contextPath}/register">Create Account</a>
                </div>

                <div class="back-link">
                    <a href="${pageContext.request.contextPath}/">
                        <i class="fas fa-arrow-left"></i> Back to Home
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script>
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;

            if (!email || !password) {
                e.preventDefault();
                alert('Please fill in all fields');
            }
        });
    </script>
</body>
</html>
