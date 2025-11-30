<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.title != null ? param.title : 'UM6P Learning Center'}</title>

    <!-- CSS Framework -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">

    <!-- Google Fonts - Montserrat & Open Sans -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800&family=Open+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation Header -->
    <nav class="navbar">
        <div class="container">
            <div class="navbar-container">
                <!-- Logo -->
                <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                    <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="UM6P Logo">
                    <span>UM6P Learning Center</span>
                </a>

                <!-- Mobile Toggle -->
                <button class="navbar-toggle" id="navbarToggle">
                    <i class="fas fa-bars"></i>
                </button>

                <!-- Navigation Links -->
                <ul class="navbar-nav" id="navbarNav">
                    <c:if test="${sessionScope.user != null}">
                        <!-- Student Links -->
                        <c:if test="${sessionScope.user.role == 'STUDENT'}">
                            <li><a class="nav-link ${param.active == 'dashboard' ? 'active' : ''}"
                                  href="${pageContext.request.contextPath}/student/dashboard.jsp">
                                <i class="fas fa-home"></i> Dashboard
                            </a></li>
                            <li><a class="nav-link ${param.active == 'books' ? 'active' : ''}"
                                  href="${pageContext.request.contextPath}/books">
                                <i class="fas fa-book"></i> Books
                            </a></li>
                            <li><a class="nav-link ${param.active == 'events' ? 'active' : ''}"
                                  href="${pageContext.request.contextPath}/events">
                                <i class="fas fa-calendar-alt"></i> Events
                            </a></li>
                            <li><a class="nav-link ${param.active == 'borrowings' ? 'active' : ''}"
                                  href="${pageContext.request.contextPath}/borrowings">
                                <i class="fas fa-book-reader"></i> My Borrowings
                            </a></li>
                            <li><a class="nav-link ${param.active == 'reservations' ? 'active' : ''}"
                                  href="${pageContext.request.contextPath}/reservations">
                                <i class="fas fa-bookmark"></i> My Reservations
                            </a></li>
                        </c:if>

                        <!-- Staff Links -->
                        <c:if test="${sessionScope.user.role == 'STAFF'}">
                            <li><a class="nav-link ${param.active == 'dashboard' ? 'active' : ''}"
                                  href="${pageContext.request.contextPath}/staff/dashboard.jsp">
                                <i class="fas fa-tachometer-alt"></i> Dashboard
                            </a></li>
                            <li><a class="nav-link ${param.active == 'books' ? 'active' : ''}"
                                  href="${pageContext.request.contextPath}/books">
                                <i class="fas fa-book"></i> Manage Books
                            </a></li>
                            <li><a class="nav-link ${param.active == 'events' ? 'active' : ''}"
                                  href="${pageContext.request.contextPath}/events">
                                <i class="fas fa-calendar-alt"></i> Manage Events
                            </a></li>
                            <li><a class="nav-link ${param.active == 'borrowings' ? 'active' : ''}"
                                  href="${pageContext.request.contextPath}/borrowings">
                                <i class="fas fa-book-reader"></i> Manage Borrowings
                            </a></li>
                        </c:if>

                        <!-- Common User Links -->
                        <li><a class="nav-link ${param.active == 'profile' ? 'active' : ''}"
                              href="${pageContext.request.contextPath}/profile">
                            <i class="fas fa-user-circle"></i> ${sessionScope.user.name}
                        </a></li>
                        <li><a class="nav-link logout-btn" href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a></li>
                    </c:if>

                    <c:if test="${sessionScope.user == null}">
                        <li><a class="nav-link login-btn" href="${pageContext.request.contextPath}/views/public/login.jsp">
                            <i class="fas fa-sign-in-alt"></i> Sign In
                        </a></li>
                    </c:if>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content Area -->
    <main class="main-content">
        <div class="container">