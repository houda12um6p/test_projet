<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UM6P Learning Center - Home</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800&family=Open+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            /* UM6P Brand Colors */
            --um6p-red: #D94A3D;
            --um6p-red-dark: #B83D32;
            --navy: #1E3A8A;
            --navy-dark: #1E293B;
            --purple: #7C3AED;
            --cyan: #0EA5E9;
            --gold: #F59E0B;
            --green: #10B981;

            /* Neutrals */
            --white: #FFFFFF;
            --gray-50: #F9FAFB;
            --gray-100: #F3F4F6;
            --gray-200: #E5E7EB;
            --gray-300: #D1D5DB;
            --gray-700: #374151;
            --gray-900: #111827;
            --black: #000000;
        }

        body {
            font-family: 'Open Sans', sans-serif;
            color: var(--gray-900);
            line-height: 1.6;
        }

        /* Navigation - UM6P Style */
        .navbar {
            background: var(--white);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .nav-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 80px;
        }

        .logo-section {
            display: flex;
            align-items: center;
            gap: 24px;
        }

        .um6p-logo {
            height: 45px;
        }

        .divider {
            width: 2px;
            height: 40px;
            background: var(--gray-200);
        }

        .lc-title {
            font-family: 'Montserrat', sans-serif;
            font-size: 20px;
            font-weight: 800;
            color: var(--um6p-red);
        }

        .nav-links {
            display: flex;
            gap: 40px;
            list-style: none;
            align-items: center;
        }

        .nav-links a {
            text-decoration: none;
            color: var(--gray-900);
            font-weight: 600;
            font-size: 15px;
            transition: color 0.3s ease;
            position: relative;
            padding: 8px 0;
        }

        .nav-links a::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--um6p-red);
            transition: width 0.3s ease;
        }

        .nav-links a:hover::after {
            width: 100%;
        }

        .nav-links a:hover {
            color: var(--um6p-red);
        }

        .nav-actions {
            display: flex;
            gap: 16px;
        }

        .btn {
            padding: 12px 28px;
            border-radius: 4px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            font-size: 14px;
            border: none;
            cursor: pointer;
        }

        .btn-outline {
            border: 2px solid var(--um6p-red);
            background: transparent;
            color: var(--um6p-red);
        }

        .btn-outline:hover {
            background: var(--um6p-red);
            color: white;
        }

        .btn-primary {
            background: var(--um6p-red);
            color: white;
        }

        .btn-primary:hover {
            background: var(--um6p-red-dark);
        }

        /* Hero Carousel */
        .hero-carousel {
            position: relative;
            height: 650px;
            overflow: hidden;
        }

        .carousel-slide {
            position: absolute;
            width: 100%;
            height: 100%;
            opacity: 0;
            transition: opacity 1s ease-in-out;
        }

        .carousel-slide.active {
            opacity: 1;
        }

        .carousel-slide img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .carousel-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(to right, rgba(0,0,0,0.7) 0%, rgba(0,0,0,0.3) 100%);
            display: flex;
            align-items: center;
        }

        .carousel-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 40px;
            color: white;
            width: 100%;
        }

        .carousel-title {
            font-family: 'Montserrat', sans-serif;
            font-size: 54px;
            font-weight: 800;
            margin-bottom: 20px;
            max-width: 700px;
            line-height: 1.2;
        }

        .carousel-description {
            font-size: 20px;
            margin-bottom: 40px;
            max-width: 600px;
            line-height: 1.6;
        }

        .carousel-controls {
            position: absolute;
            bottom: 40px;
            right: 40px;
            display: flex;
            gap: 16px;
        }

        .carousel-btn {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.9);
            border: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            color: var(--gray-900);
            transition: all 0.3s ease;
        }

        .carousel-btn:hover {
            background: white;
            transform: scale(1.1);
        }

        .carousel-indicators {
            position: absolute;
            bottom: 40px;
            left: 50%;
            transform: translateX(-50%);
            display: flex;
            gap: 12px;
        }

        .indicator {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.5);
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .indicator.active {
            background: white;
            width: 40px;
            border-radius: 6px;
        }

        /* Stats Section */
        .stats-section {
            background: var(--gray-900);
            padding: 60px 40px;
        }

        .stats-container {
            max-width: 1400px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 60px;
        }

        .stat-item {
            text-align: center;
            color: white;
        }

        .stat-number {
            font-family: 'Montserrat', sans-serif;
            font-size: 48px;
            font-weight: 800;
            color: var(--um6p-red);
            display: block;
            margin-bottom: 12px;
        }

        .stat-label {
            font-size: 16px;
            font-weight: 500;
            opacity: 0.9;
        }

        /* Services Section */
        .services-section {
            padding: 100px 40px;
            background: var(--white);
        }

        .section-container {
            max-width: 1400px;
            margin: 0 auto;
        }

        .section-header {
            text-align: center;
            margin-bottom: 60px;
        }

        .section-subtitle {
            color: var(--um6p-red);
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 2px;
            font-size: 14px;
            margin-bottom: 16px;
        }

        .section-title {
            font-family: 'Montserrat', sans-serif;
            font-size: 42px;
            font-weight: 800;
            color: var(--gray-900);
            margin-bottom: 20px;
        }

        .section-description {
            color: var(--gray-700);
            font-size: 18px;
            max-width: 700px;
            margin: 0 auto;
        }

        .services-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 40px;
        }

        .service-card {
            background: var(--white);
            border: 1px solid var(--gray-200);
            padding: 40px;
            transition: all 0.3s ease;
        }

        .service-card:hover {
            border-color: var(--um6p-red);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
            transform: translateY(-4px);
        }

        .service-icon {
            width: 60px;
            height: 60px;
            background: var(--um6p-red);
            color: white;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            margin-bottom: 24px;
        }

        .service-title {
            font-family: 'Montserrat', sans-serif;
            font-size: 22px;
            font-weight: 700;
            color: var(--gray-900);
            margin-bottom: 16px;
        }

        .service-description {
            color: var(--gray-700);
            line-height: 1.8;
        }

        /* Featured Events */
        .events-section {
            padding: 100px 40px;
            background: var(--gray-50);
        }

        .events-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 32px;
        }

        .event-card {
            background: white;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .event-card:hover {
            box-shadow: 0 12px 32px rgba(0, 0, 0, 0.12);
            transform: translateY(-8px);
        }

        .event-image {
            width: 100%;
            height: 240px;
            background: linear-gradient(135deg, var(--navy), var(--purple));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 64px;
        }

        .event-content {
            padding: 28px;
        }

        .event-date {
            color: var(--um6p-red);
            font-weight: 700;
            font-size: 14px;
            margin-bottom: 12px;
        }

        .event-title {
            font-family: 'Montserrat', sans-serif;
            font-size: 20px;
            font-weight: 700;
            color: var(--gray-900);
            margin-bottom: 12px;
        }

        .event-description {
            color: var(--gray-700);
            font-size: 15px;
            line-height: 1.6;
            margin-bottom: 20px;
        }

        .event-link {
            color: var(--um6p-red);
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .event-link:hover {
            gap: 12px;
        }

        /* CTA Section */
        .cta-section {
            padding: 100px 40px;
            background: var(--um6p-red);
            text-align: center;
            color: white;
        }

        .cta-content {
            max-width: 800px;
            margin: 0 auto;
        }

        .cta-title {
            font-family: 'Montserrat', sans-serif;
            font-size: 44px;
            font-weight: 800;
            margin-bottom: 20px;
        }

        .cta-description {
            font-size: 20px;
            margin-bottom: 40px;
            opacity: 0.95;
        }

        .btn-white {
            background: white;
            color: var(--um6p-red);
            padding: 16px 40px;
            font-size: 16px;
        }

        .btn-white:hover {
            background: var(--gray-100);
        }

        /* Footer */
        .footer {
            background: var(--gray-900);
            color: white;
            padding: 60px 40px 30px;
        }

        .footer-container {
            max-width: 1400px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            gap: 60px;
            margin-bottom: 40px;
        }

        .footer-about h3 {
            font-family: 'Montserrat', sans-serif;
            font-size: 20px;
            margin-bottom: 16px;
        }

        .footer-about p {
            color: rgba(255, 255, 255, 0.7);
            line-height: 1.8;
            margin-bottom: 20px;
        }

        .social-links {
            display: flex;
            gap: 16px;
        }

        .social-link {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .social-link:hover {
            background: var(--um6p-red);
        }

        .footer-section h4 {
            font-family: 'Montserrat', sans-serif;
            font-size: 16px;
            margin-bottom: 20px;
        }

        .footer-links {
            list-style: none;
        }

        .footer-links li {
            margin-bottom: 12px;
        }

        .footer-links a {
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-links a:hover {
            color: var(--um6p-red);
        }

        .footer-bottom {
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            padding-top: 30px;
            text-align: center;
            color: rgba(255, 255, 255, 0.6);
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .nav-links {
                display: none;
            }

            .services-grid,
            .events-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .stats-container {
                grid-template-columns: repeat(2, 1fr);
            }

            .footer-container {
                grid-template-columns: 1fr 1fr;
            }
        }

        @media (max-width: 768px) {
            .carousel-title {
                font-size: 36px;
            }

            .services-grid,
            .events-grid,
            .stats-container {
                grid-template-columns: 1fr;
            }

            .footer-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-container">
            <div class="logo-section">
                <svg class="um6p-logo" viewBox="0 0 200 50" xmlns="http://www.w3.org/2000/svg">
                    <rect x="10" y="10" width="35" height="30" fill="#D94A3D"/>
                    <text x="50" y="35" font-family="Montserrat, sans-serif" font-size="24" font-weight="800" fill="#D94A3D">UM6P</text>
                </svg>

                <div class="divider"></div>

                <div class="lc-title">Learning Center</div>
            </div>

            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/books">Library</a></li>
                <li><a href="${pageContext.request.contextPath}/events">Events & Workshops</a></li>
                <li><a href="#services">Services</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>

            <div class="nav-actions">
                <a href="${pageContext.request.contextPath}/login" class="btn btn-outline">Sign In</a>
                <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">Get Started</a>
            </div>
        </div>
    </nav>

    <!-- Hero Carousel -->
    <section class="hero-carousel">
        <!-- Slide 1: Learning Center Interior -->
        <div class="carousel-slide active">
            <div style="width: 100%; height: 100%; background: linear-gradient(135deg, var(--navy) 0%, var(--navy-dark) 100%); display: flex; align-items: center; justify-content: center;">
                <i class="fas fa-book-reader" style="font-size: 200px; color: rgba(255,255,255,0.1);"></i>
            </div>
            <div class="carousel-overlay">
                <div class="carousel-content">
                    <h1 class="carousel-title">Welcome to UM6P Learning Center</h1>
                    <p class="carousel-description">A modern academic hub providing students with world-class resources, innovative workshops, and collaborative spaces for excellence.</p>
                    <a href="${pageContext.request.contextPath}/books" class="btn btn-primary">Explore Resources</a>
                </div>
            </div>
        </div>

        <!-- Slide 2: Event Poster -->
        <div class="carousel-slide">
            <div style="width: 100%; height: 100%; background: linear-gradient(135deg, var(--um6p-red) 0%, var(--gold) 100%); display: flex; align-items: center; justify-content: center;">
                <i class="fas fa-calendar-alt" style="font-size: 200px; color: rgba(255,255,255,0.1);"></i>
            </div>
            <div class="carousel-overlay">
                <div class="carousel-content">
                    <h1 class="carousel-title">Exclusive Masterclasses</h1>
                    <p class="carousel-description">Join renowned experts and thought leaders for inspiring talks, workshops, and learning experiences that shape your academic journey.</p>
                    <a href="${pageContext.request.contextPath}/events" class="btn btn-primary">View Events</a>
                </div>
            </div>
        </div>

        <!-- Slide 3: Another Event -->
        <div class="carousel-slide">
            <div style="width: 100%; height: 100%; background: linear-gradient(135deg, var(--purple) 0%, var(--cyan) 100%); display: flex; align-items: center; justify-content: center;">
                <i class="fas fa-users" style="font-size: 200px; color: rgba(255,255,255,0.1);"></i>
            </div>
            <div class="carousel-overlay">
                <div class="carousel-content">
                    <h1 class="carousel-title">Cultural & Academic Events</h1>
                    <p class="carousel-description">Participate in enriching cultural activities, academic seminars, and networking events designed to broaden your horizons.</p>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">Register Now</a>
                </div>
            </div>
        </div>

        <!-- Carousel Controls -->
        <div class="carousel-controls">
            <button class="carousel-btn" onclick="prevSlide()">
                <i class="fas fa-chevron-left"></i>
            </button>
            <button class="carousel-btn" onclick="nextSlide()">
                <i class="fas fa-chevron-right"></i>
            </button>
        </div>

        <!-- Carousel Indicators -->
        <div class="carousel-indicators">
            <div class="indicator active" onclick="goToSlide(0)"></div>
            <div class="indicator" onclick="goToSlide(1)"></div>
            <div class="indicator" onclick="goToSlide(2)"></div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats-section">
        <div class="stats-container">
            <div class="stat-item">
                <span class="stat-number">5,000+</span>
                <span class="stat-label">Books & Resources</span>
            </div>
            <div class="stat-item">
                <span class="stat-number">50+</span>
                <span class="stat-label">Monthly Workshops</span>
            </div>
            <div class="stat-item">
                <span class="stat-number">2,000+</span>
                <span class="stat-label">Active Students</span>
            </div>
            <div class="stat-item">
                <span class="stat-number">100+</span>
                <span class="stat-label">Annual Events</span>
            </div>
        </div>
    </section>

    <!-- Services Section -->
    <section class="services-section" id="services">
        <div class="section-container">
            <div class="section-header">
                <div class="section-subtitle">Our Services</div>
                <h2 class="section-title">Everything You Need to Excel</h2>
                <p class="section-description">Comprehensive resources and support services designed to enhance your academic experience at UM6P</p>
            </div>

            <div class="services-grid">
                <div class="service-card">
                    <div class="service-icon">
                        <i class="fas fa-book"></i>
                    </div>
                    <h3 class="service-title">Extensive Library</h3>
                    <p class="service-description">Access over 5,000 books, academic journals, research papers, and digital resources across all disciplines.</p>
                </div>

                <div class="service-card">
                    <div class="service-icon">
                        <i class="fas fa-chalkboard-teacher"></i>
                    </div>
                    <h3 class="service-title">Expert Workshops</h3>
                    <p class="service-description">Participate in specialized workshops led by industry professionals and academic experts.</p>
                </div>

                <div class="service-card">
                    <div class="service-icon">
                        <i class="fas fa-laptop-code"></i>
                    </div>
                    <h3 class="service-title">Study Spaces</h3>
                    <p class="service-description">Modern, equipped study rooms and collaborative spaces for individual and group work.</p>
                </div>

                <div class="service-card">
                    <div class="service-icon">
                        <i class="fas fa-calendar-alt"></i>
                    </div>
                    <h3 class="service-title">Event Management</h3>
                    <p class="service-description">Easy online registration and management system for all events, seminars, and workshops.</p>
                </div>

                <div class="service-card">
                    <div class="service-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3 class="service-title">Community Support</h3>
                    <p class="service-description">Connect with peers, join study groups, and receive personalized academic support.</p>
                </div>

                <div class="service-card">
                    <div class="service-icon">
                        <i class="fas fa-bell"></i>
                    </div>
                    <h3 class="service-title">Smart Notifications</h3>
                    <p class="service-description">Stay updated with timely reminders for due dates, events, and new resource additions.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Featured Events -->
    <section class="events-section">
        <div class="section-container">
            <div class="section-header">
                <div class="section-subtitle">Upcoming Events</div>
                <h2 class="section-title">Featured Workshops & Events</h2>
                <p class="section-description">Join our curated selection of academic and cultural events designed to enrich your university experience</p>
            </div>

            <div class="events-grid">
                <div class="event-card">
                    <div class="event-image">
                        <i class="fas fa-brain"></i>
                    </div>
                    <div class="event-content">
                        <div class="event-date">Tuesday, November 25, 2025 - 6:00 PM</div>
                        <h3 class="event-title">Masterclass with Prof. Ali Benmakhlouf</h3>
                        <p class="event-description">An enlightening session on memorizing the Quran and living through Islamic principles.</p>
                        <a href="${pageContext.request.contextPath}/events" class="event-link">
                            Learn More <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>

                <div class="event-card">
                    <div class="event-image" style="background: linear-gradient(135deg, var(--um6p-red), var(--gold));">
                        <i class="fas fa-palette"></i>
                    </div>
                    <div class="event-content">
                        <div class="event-date">Thursday, October 23, 2025 - 6:00 PM</div>
                        <h3 class="event-title">Cultural Evening: Mahi Binebine</h3>
                        <p class="event-description">Discover the works of acclaimed Moroccan artist and author in this special evening event.</p>
                        <a href="${pageContext.request.contextPath}/events" class="event-link">
                            Learn More <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>

                <div class="event-card">
                    <div class="event-image" style="background: linear-gradient(135deg, var(--cyan), var(--green));">
                        <i class="fas fa-graduation-cap"></i>
                    </div>
                    <div class="event-content">
                        <div class="event-date">Weekly Sessions</div>
                        <h3 class="event-title">Study Skills Workshop Series</h3>
                        <p class="event-description">Enhance your research, writing, and critical thinking skills through our weekly workshop series.</p>
                        <a href="${pageContext.request.contextPath}/events" class="event-link">
                            Learn More <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
        <div class="cta-content">
            <h2 class="cta-title">Ready to Begin Your Journey?</h2>
            <p class="cta-description">Join thousands of UM6P students leveraging our platform to enhance their academic experience</p>
            <a href="${pageContext.request.contextPath}/register" class="btn btn-white">Create Your Account</a>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer" id="about">
        <div class="footer-container">
            <div class="footer-about">
                <h3>UM6P Learning Center</h3>
                <p>Empowering students with world-class learning resources and opportunities at Mohammed VI Polytechnic University.</p>
                <div class="social-links">
                    <a href="#" class="social-link"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>

            <div class="footer-section">
                <h4>Quick Links</h4>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/books">Library Catalog</a></li>
                    <li><a href="${pageContext.request.contextPath}/events">Events Calendar</a></li>
                    <li><a href="#services">Services</a></li>
                    <li><a href="#about">About Us</a></li>
                </ul>
            </div>

            <div class="footer-section">
                <h4>Resources</h4>
                <ul class="footer-links">
                    <li><a href="#help">Help Center</a></li>
                    <li><a href="#guides">User Guides</a></li>
                    <li><a href="#faq">FAQ</a></li>
                    <li><a href="#contact" id="contact">Contact Support</a></li>
                </ul>
            </div>

            <div class="footer-section">
                <h4>Legal</h4>
                <ul class="footer-links">
                    <li><a href="#privacy">Privacy Policy</a></li>
                    <li><a href="#terms">Terms of Service</a></li>
                    <li><a href="#cookies">Cookie Policy</a></li>
                </ul>
            </div>
        </div>

        <div class="footer-bottom">
            © 2025 Mohammed VI Polytechnic University. All rights reserved.
        </div>
    </footer>

    <script>
        // Carousel functionality
        let currentSlide = 0;
        const slides = document.querySelectorAll('.carousel-slide');
        const indicators = document.querySelectorAll('.indicator');

        function showSlide(n) {
            if (n >= slides.length) currentSlide = 0;
            if (n < 0) currentSlide = slides.length - 1;

            slides.forEach(slide => slide.classList.remove('active'));
            indicators.forEach(indicator => indicator.classList.remove('active'));

            slides[currentSlide].classList.add('active');
            indicators[currentSlide].classList.add('active');
        }

        function nextSlide() {
            currentSlide++;
            showSlide(currentSlide);
        }

        function prevSlide() {
            currentSlide--;
            showSlide(currentSlide);
        }

        function goToSlide(n) {
            currentSlide = n;
            showSlide(currentSlide);
        }

        // Auto-advance carousel every 5 seconds
        setInterval(() => {
            nextSlide();
        }, 5000);
    </script>
</body>
</html>
