<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="UM6P Learning Center - Access books, events, and academic resources at Mohammed VI Polytechnic University">
    <title>UM6P Learning Center - Welcome</title>

    <!-- Custom CSS Framework -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/core.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components.css">

    <!-- Google Fonts - Montserrat & Open Sans -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800&family=Open+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="navbar-container">
            <a href="${pageContext.request.contextPath}/views/public/index.jsp" class="navbar-logo">
                <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="UM6P Learning Center" style="height: 50px;">
            </a>

            <ul class="navbar-menu">
                <li class="navbar-item active"><a href="#home">Home</a></li>
                <li class="navbar-item"><a href="#about">About</a></li>
                <li class="navbar-item"><a href="#services">Services</a></li>
                <li class="navbar-item"><a href="#events">Events</a></li>
                <li class="navbar-item"><a href="#contact">Contact</a></li>
                <li class="navbar-item"><a href="${pageContext.request.contextPath}/views/public/login.jsp" class="btn btn-primary btn-sm">Sign In</a></li>
            </ul>
        </div>
    </nav>

    <!-- Hero Section with Carousel -->
    <section class="hero" id="home">
        <div style="max-width: 1200px; margin: 0 auto; padding: 40px 24px;">
            <div class="carousel">
                <div class="carousel-inner">
                    <!-- Slide 1 -->
                    <div class="carousel-item active">
                        <img src="${pageContext.request.contextPath}/assets/images/carousel-1.gif" alt="Learning Center Cultural Club Event">
                        <div class="carousel-caption">
                            <h3>Cultural Club Highlights</h3>
                            <p>Discover moments from our vibrant cultural events and community gatherings</p>
                        </div>
                    </div>

                    <!-- Slide 2 -->
                    <div class="carousel-item">
                        <img src="${pageContext.request.contextPath}/assets/images/carousel-2.gif" alt="Community Events">
                        <div class="carousel-caption">
                            <h3>Join Our Community</h3>
                            <p>Experience engaging workshops, seminars, and networking opportunities</p>
                        </div>
                    </div>

                    <!-- Slide 3 -->
                    <div class="carousel-item">
                        <img src="${pageContext.request.contextPath}/assets/images/learning-center.jpg" alt="UM6P Learning Center">
                        <div class="carousel-caption">
                            <h3>State-of-the-Art Facilities</h3>
                            <p>Modern learning spaces designed to inspire innovation and collaboration</p>
                        </div>
                    </div>
                </div>

                <!-- Controls -->
                <div class="carousel-controls">
                    <button class="carousel-btn carousel-prev" aria-label="Previous slide">
                        <i class="fas fa-chevron-left"></i>
                    </button>
                    <button class="carousel-btn carousel-next" aria-label="Next slide">
                        <i class="fas fa-chevron-right"></i>
                    </button>
                </div>

                <!-- Indicators -->
                <div class="carousel-indicators">
                    <button class="carousel-indicator active" aria-label="Slide 1"></button>
                    <button class="carousel-indicator" aria-label="Slide 2"></button>
                    <button class="carousel-indicator" aria-label="Slide 3"></button>
                </div>
            </div>

            <div style="text-align: center; margin-top: 48px;">
                <h1 class="hero-title" style="color: white;">Welcome to UM6P Learning Center</h1>
                <p class="hero-subtitle" style="margin: 0 auto;">Your gateway to knowledge, innovation, and community at Mohammed VI Polytechnic University</p>
                <div class="hero-actions" style="justify-content: center;">
                    <a href="${pageContext.request.contextPath}/views/public/login.jsp" class="btn btn-primary btn-lg">
                        <i class="fas fa-sign-in-alt"></i> Get Started
                    </a>
                    <a href="#about" class="btn btn-outline btn-lg" style="background: rgba(255,255,255,0.1); border-color: white; color: white;">
                        <i class="fas fa-info-circle"></i> Learn More
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section style="background-color: white; padding: 80px 0;">
        <div class="container">
            <div class="grid grid-cols-4 gap-6" style="gap: 24px;">
                <div class="stats-card">
                    <div class="stats-icon orange">
                        <i class="fas fa-book"></i>
                    </div>
                    <div class="stats-content">
                        <div class="stats-label">Books Available</div>
                        <div class="stats-value">5,000+</div>
                    </div>
                </div>

                <div class="stats-card">
                    <div class="stats-icon purple">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="stats-content">
                        <div class="stats-label">Monthly Events</div>
                        <div class="stats-value">50+</div>
                    </div>
                </div>

                <div class="stats-card">
                    <div class="stats-icon blue">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stats-content">
                        <div class="stats-label">Active Students</div>
                        <div class="stats-value">2,500+</div>
                    </div>
                </div>

                <div class="stats-card">
                    <div class="stats-icon orange">
                        <i class="fas fa-graduation-cap"></i>
                    </div>
                    <div class="stats-content">
                        <div class="stats-label">Workshops</div>
                        <div class="stats-value">200+</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section id="about" style="background-color: var(--gray-50); padding: 96px 0;">
        <div class="container">
            <div style="text-align: center; max-width: 800px; margin: 0 auto 64px;">
                <h2 style="font-size: 40px; font-weight: 800; color: var(--lc-navy); margin-bottom: 16px;">About Learning Center</h2>
                <p style="font-size: 18px; color: var(--gray-700);">
                    The UM6P Learning Center is more than just a library. It's a hub of innovation, collaboration,
                    and academic excellence where students, faculty, and researchers come together to learn, create, and grow.
                </p>
            </div>

            <div class="grid grid-cols-3 gap-6">
                <div class="card">
                    <div style="text-align: center;">
                        <div style="width: 80px; height: 80px; margin: 0 auto 24px; background-color: #FED7AA; border-radius: 16px; display: flex; align-items: center; justify-content: center;">
                            <i class="fas fa-book-reader" style="font-size: 36px; color: var(--um6p-orange);"></i>
                        </div>
                        <h3 style="font-size: 24px; font-weight: 700; margin-bottom: 16px;">Extensive Collection</h3>
                        <p style="color: var(--gray-600);">
                            Access over 5,000 books, journals, and digital resources across all academic disciplines.
                        </p>
                    </div>
                </div>

                <div class="card">
                    <div style="text-align: center;">
                        <div style="width: 80px; height: 80px; margin: 0 auto 24px; background-color: #E9D5FF; border-radius: 16px; display: flex; align-items: center; justify-content: center;">
                            <i class="fas fa-chalkboard-teacher" style="font-size: 36px; color: var(--lc-purple);"></i>
                        </div>
                        <h3 style="font-size: 24px; font-weight: 700; margin-bottom: 16px;">Learning Events</h3>
                        <p style="color: var(--gray-600);">
                            Attend workshops, seminars, and masterclasses led by industry experts and academics.
                        </p>
                    </div>
                </div>

                <div class="card">
                    <div style="text-align: center;">
                        <div style="width: 80px; height: 80px; margin: 0 auto 24px; background-color: #DBEAFE; border-radius: 16px; display: flex; align-items: center; justify-content: center;">
                            <i class="fas fa-laptop-code" style="font-size: 36px; color: var(--lc-blue);"></i>
                        </div>
                        <h3 style="font-size: 24px; font-weight: 700; margin-bottom: 16px;">Modern Facilities</h3>
                        <p style="color: var(--gray-600);">
                            Study in comfortable spaces equipped with the latest technology and resources.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Upcoming Events Section -->
    <section id="events" style="background-color: white; padding: 96px 0;">
        <div class="container">
            <div style="text-align: center; margin-bottom: 64px;">
                <h2 style="font-size: 40px; font-weight: 800; color: var(--lc-navy); margin-bottom: 16px;">Upcoming Events</h2>
                <p style="font-size: 18px; color: var(--gray-700);">Join our community events and expand your knowledge</p>
            </div>

            <div class="grid grid-cols-2 gap-6">
                <!-- Event Card 1 -->
                <div class="event-card">
                    <div class="event-card-image">
                        <img src="${pageContext.request.contextPath}/assets/images/event-1.png" alt="Masterclass Ali Benmakhlouf">
                        <div class="event-card-date">
                            <div class="event-date-day">25</div>
                            <div class="event-date-month">Nov</div>
                        </div>
                    </div>
                    <div class="event-card-body">
                        <span class="badge badge-orange event-card-type">Masterclass</span>
                        <h3 class="event-card-title">Pr. Ali Benmakhlouf - Mémoriser le Coran, vivre l'islam</h3>
                        <div class="event-card-info">
                            <div class="event-info-item">
                                <i class="fas fa-clock"></i>
                                <span>Tuesday, November 25th, 2025 - 6:00 PM</span>
                            </div>
                            <div class="event-info-item">
                                <i class="fas fa-map-marker-alt"></i>
                                <span>Showroom - Learning Center EMINES</span>
                            </div>
                        </div>
                        <div class="event-card-footer">
                            <span class="event-capacity">40/50 registered</span>
                            <a href="${pageContext.request.contextPath}/views/public/login.jsp" class="btn btn-primary btn-sm">Register Now</a>
                        </div>
                    </div>
                </div>

                <!-- Event Card 2 -->
                <div class="event-card">
                    <div class="event-card-image">
                        <img src="${pageContext.request.contextPath}/assets/images/event-4.png" alt="Masterclass Halim Mahmoudi">
                        <div class="event-card-date">
                            <div class="event-date-day">16</div>
                            <div class="event-date-month">Oct</div>
                        </div>
                    </div>
                    <div class="event-card-body">
                        <span class="badge badge-purple event-card-type">Masterclass</span>
                        <h3 class="event-card-title">Halim Mahmoudi - Falloujah: Ma campagne perdue</h3>
                        <div class="event-card-info">
                            <div class="event-info-item">
                                <i class="fas fa-clock"></i>
                                <span>Thursday, October 16th - 6:00 PM</span>
                            </div>
                            <div class="event-info-item">
                                <i class="fas fa-map-marker-alt"></i>
                                <span>Showroom - Learning Center EMINES</span>
                            </div>
                        </div>
                        <div class="event-card-footer">
                            <span class="event-capacity">50/50 registered</span>
                            <button class="btn btn-sm" style="background-color: var(--gray-300); color: var(--gray-700); cursor: not-allowed;" disabled>Full</button>
                        </div>
                    </div>
                </div>
            </div>

            <div style="text-align: center; margin-top: 48px;">
                <a href="${pageContext.request.contextPath}/views/public/login.jsp" class="btn btn-outline btn-lg">
                    View All Events <i class="fas fa-arrow-right"></i>
                </a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-grid">
                <div class="footer-section">
                    <h3>About UM6P</h3>
                    <ul class="footer-links">
                        <li><a href="#">About University</a></li>
                        <li><a href="#">Campus Life</a></li>
                        <li><a href="#">Research</a></li>
                        <li><a href="#">News & Events</a></li>
                    </ul>
                </div>

                <div class="footer-section">
                    <h3>Resources</h3>
                    <ul class="footer-links">
                        <li><a href="#">Library Catalog</a></li>
                        <li><a href="#">Digital Resources</a></li>
                        <li><a href="#">Study Spaces</a></li>
                        <li><a href="#">Research Support</a></li>
                    </ul>
                </div>

                <div class="footer-section">
                    <h3>Quick Links</h3>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/views/public/login.jsp">Student Portal</a></li>
                        <li><a href="#">Book a Room</a></li>
                        <li><a href="#">Event Calendar</a></li>
                        <li><a href="#">Contact Us</a></li>
                    </ul>
                </div>

                <div class="footer-section">
                    <h3>Contact</h3>
                    <ul class="footer-links" style="list-style: none;">
                        <li style="margin-bottom: 12px;">
                            <i class="fas fa-map-marker-alt" style="margin-right: 8px;"></i>
                            Ben Guerir, Morocco
                        </li>
                        <li style="margin-bottom: 12px;">
                            <i class="fas fa-phone" style="margin-right: 8px;"></i>
                            +212 5XX-XXXXXX
                        </li>
                        <li style="margin-bottom: 12px;">
                            <i class="fas fa-envelope" style="margin-right: 8px;"></i>
                            library@um6p.ma
                        </li>
                    </ul>
                </div>
            </div>

            <div class="footer-bottom">
                <p>&copy; 2025 Mohammed VI Polytechnic University. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/assets/js/carousel.js"></script>
</body>
</html>
