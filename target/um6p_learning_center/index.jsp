<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UM6P Learning Center - Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #667eea;
            --secondary-color: #764ba2;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .hero-section {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 100px 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .hero-content h1 {
            font-size: 48px;
            font-weight: 700;
            margin-bottom: 20px;
        }
        .hero-content p {
            font-size: 20px;
            margin-bottom: 30px;
            opacity: 0.95;
        }
        .btn-hero {
            padding: 15px 40px;
            font-size: 18px;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn-hero-primary {
            background: white;
            color: var(--primary-color);
        }
        .btn-hero-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }
        .btn-hero-outline {
            border: 2px solid white;
            color: white;
        }
        .btn-hero-outline:hover {
            background: white;
            color: var(--primary-color);
        }
        .features-section {
            padding: 80px 0;
        }
        .feature-card {
            text-align: center;
            padding: 40px 30px;
            border-radius: 15px;
            transition: transform 0.3s;
            height: 100%;
            border: 1px solid #e9ecef;
        }
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .feature-icon {
            font-size: 50px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 20px;
        }
        .stats-section {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 60px 0;
        }
        .stat-box {
            text-align: center;
            padding: 20px;
        }
        .stat-number {
            font-size: 48px;
            font-weight: 700;
        }
        .stat-label {
            font-size: 18px;
            opacity: 0.9;
        }
        footer {
            background: #2d3748;
            color: white;
            padding: 40px 0;
            text-align: center;
        }
    </style>
</head>
<body>
    <!-- Hero Section -->
    <div class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 hero-content">
                    <h1>Welcome to UM6P Learning Center</h1>
                    <p>Your gateway to knowledge, resources, and academic excellence. Access our extensive book library, register for events, and enhance your learning experience.</p>
                    <div class="d-flex gap-3">
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-hero btn-hero-primary">
                            <i class="fas fa-sign-in-alt me-2"></i>Login
                        </a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-hero btn-hero-outline">
                            <i class="fas fa-user-plus me-2"></i>Register
                        </a>
                    </div>
                </div>
                <div class="col-lg-6 text-center">
                    <i class="fas fa-book-reader" style="font-size: 300px; opacity: 0.2;"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Features Section -->
    <div class="features-section">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="display-4 fw-bold">Our Services</h2>
                <p class="lead text-muted">Everything you need for your academic journey</p>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-book"></i>
                        </div>
                        <h4>Book Library</h4>
                        <p class="text-muted">Browse and borrow from our extensive collection of academic books and resources.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-calendar-alt"></i>
                        </div>
                        <h4>Events & Workshops</h4>
                        <p class="text-muted">Register for seminars, workshops, and training sessions to enhance your skills.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-user-circle"></i>
                        </div>
                        <h4>Profile Management</h4>
                        <p class="text-muted">Manage your account, track borrowing history, and view your registrations.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <h4>Real-Time Availability</h4>
                        <p class="text-muted">Check book availability and event capacity in real-time.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h4>Secure Access</h4>
                        <p class="text-muted">Your data is protected with industry-standard security measures.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h4>Mobile Friendly</h4>
                        <p class="text-muted">Access the platform from any device, anywhere, anytime.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Stats Section -->
    <div class="stats-section">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="stat-box">
                        <div class="stat-number">5000+</div>
                        <div class="stat-label">Books Available</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-box">
                        <div class="stat-number">2000+</div>
                        <div class="stat-label">Active Users</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-box">
                        <div class="stat-number">150+</div>
                        <div class="stat-label">Monthly Events</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-box">
                        <div class="stat-number">98%</div>
                        <div class="stat-label">Satisfaction Rate</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <div class="container">
            <p class="mb-2"><i class="fas fa-graduation-cap me-2"></i><strong>UM6P Learning Center</strong></p>
            <p class="mb-0">&copy; 2024 Mohammed VI Polytechnic University. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
