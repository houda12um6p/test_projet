<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Student Dashboard - UM6P Learning Center" />
    <jsp:param name="active" value="dashboard" />
</jsp:include>

<div class="container">
    <!-- Welcome Section -->
    <div class="mb-8">
        <div class="card" style="background: linear-gradient(135deg, #D94A3D 0%, #B83D32 100%); color: var(--white); border: none;">
            <div class="card-body" style="padding: var(--space-8);">
                <h1 style="font-size: 32px; font-weight: 800; margin-bottom: var(--space-2); color: var(--white);">
                    Welcome back, ${sessionScope.user.name}!
                </h1>
                <p style="font-size: 16px; margin: 0; opacity: 0.95;">
                    <i class="fas fa-envelope" style="margin-right: var(--space-2);"></i>
                    ${sessionScope.user.email}
                </p>
            </div>
        </div>
    </div>

    <!-- Quick Stats -->
    <div class="grid grid-cols-4 gap-6 mb-8">
        <div class="card card-hover">
            <div class="card-body" style="text-align: center; padding: var(--space-8);">
                <div style="width: 64px; height: 64px; background-color: #FBE9E7; border-radius: var(--radius-lg); display: flex; align-items: center; justify-content: center; margin: 0 auto var(--space-4); color: var(--orange-primary); font-size: 28px;">
                    <i class="fas fa-book-reader"></i>
                </div>
                <h3 style="font-size: 14px; font-weight: 600; color: var(--gray-600); margin-bottom: var(--space-2); text-transform: uppercase; letter-spacing: 0.5px;">Active Loans</h3>
                <p style="font-size: 36px; font-weight: 800; color: var(--gray-900); margin-bottom: var(--space-1);">0</p>
                <small style="color: var(--gray-600);">Books currently borrowed</small>
            </div>
        </div>
        <div class="card card-hover">
            <div class="card-body" style="text-align: center; padding: var(--space-8);">
                <div style="width: 64px; height: 64px; background-color: var(--success-bg); border-radius: var(--radius-lg); display: flex; align-items: center; justify-content: center; margin: 0 auto var(--space-4); color: var(--success); font-size: 28px;">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <h3 style="font-size: 14px; font-weight: 600; color: var(--gray-600); margin-bottom: var(--space-2); text-transform: uppercase; letter-spacing: 0.5px;">Events</h3>
                <p style="font-size: 36px; font-weight: 800; color: var(--gray-900); margin-bottom: var(--space-1);">0</p>
                <small style="color: var(--gray-600);">Upcoming registrations</small>
            </div>
        </div>
        <div class="card card-hover">
            <div class="card-body" style="text-align: center; padding: var(--space-8);">
                <div style="width: 64px; height: 64px; background-color: var(--info-bg); border-radius: var(--radius-lg); display: flex; align-items: center; justify-content: center; margin: 0 auto var(--space-4); color: var(--info); font-size: 28px;">
                    <i class="fas fa-book"></i>
                </div>
                <h3 style="font-size: 14px; font-weight: 600; color: var(--gray-600); margin-bottom: var(--space-2); text-transform: uppercase; letter-spacing: 0.5px;">Library</h3>
                <p style="font-size: 36px; font-weight: 800; color: var(--gray-900); margin-bottom: var(--space-1);">5000+</p>
                <small style="color: var(--gray-600);">Books available</small>
            </div>
        </div>
        <div class="card card-hover">
            <div class="card-body" style="text-align: center; padding: var(--space-8);">
                <div style="width: 64px; height: 64px; background-color: var(--warning-bg); border-radius: var(--radius-lg); display: flex; align-items: center; justify-content: center; margin: 0 auto var(--space-4); color: var(--warning); font-size: 28px;">
                    <i class="fas fa-history"></i>
                </div>
                <h3 style="font-size: 14px; font-weight: 600; color: var(--gray-600); margin-bottom: var(--space-2); text-transform: uppercase; letter-spacing: 0.5px;">History</h3>
                <p style="font-size: 36px; font-weight: 800; color: var(--gray-900); margin-bottom: var(--space-1);">0</p>
                <small style="color: var(--gray-600);">Total books borrowed</small>
            </div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="mb-8">
        <div class="card">
            <div class="card-header" style="background-color: var(--white); border-bottom: 2px solid var(--gray-200);">
                <h2 style="font-size: 20px; font-weight: 700; color: var(--gray-900); margin: 0;">
                    <i class="fas fa-bolt" style="color: var(--orange-primary); margin-right: var(--space-2);"></i>
                    Quick Actions
                </h2>
            </div>
            <div class="card-body" style="padding: var(--space-8);">
                <div class="grid grid-cols-3 gap-6">
                    <a href="${pageContext.request.contextPath}/books" class="btn btn-outline-primary" style="padding: var(--space-8); display: flex; flex-direction: column; align-items: center; text-align: center; height: 100%;">
                        <i class="fas fa-search" style="font-size: 48px; margin-bottom: var(--space-4);"></i>
                        <span style="font-size: 18px; font-weight: 600;">Browse Books</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/events" class="btn btn-outline-primary" style="padding: var(--space-8); display: flex; flex-direction: column; align-items: center; text-align: center; height: 100%;">
                        <i class="fas fa-calendar-plus" style="font-size: 48px; margin-bottom: var(--space-4);"></i>
                        <span style="font-size: 18px; font-weight: 600;">Register for Events</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/borrowings" class="btn btn-outline-primary" style="padding: var(--space-8); display: flex; flex-direction: column; align-items: center; text-align: center; height: 100%;">
                        <i class="fas fa-list" style="font-size: 48px; margin-bottom: var(--space-4);"></i>
                        <span style="font-size: 18px; font-weight: 600;">View My Borrowings</span>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Activity -->
    <div class="grid grid-cols-2 gap-6">
        <div class="card">
            <div class="card-header">
                <h3 style="font-size: 18px; font-weight: 700; color: var(--gray-900); margin: 0;">
                    <i class="fas fa-book-open" style="color: var(--orange-primary); margin-right: var(--space-2);"></i>
                    Current Borrowings
                </h3>
            </div>
            <div class="card-body">
                <div class="empty-state" style="padding: var(--space-12) var(--space-6);">
                    <div style="font-size: 48px; color: var(--gray-400); margin-bottom: var(--space-4);">
                        <i class="fas fa-inbox"></i>
                    </div>
                    <p style="font-size: 16px; font-weight: 600; color: var(--gray-700); margin-bottom: var(--space-4);">No active borrowings</p>
                    <a href="${pageContext.request.contextPath}/books" class="btn btn-primary">
                        Browse Books
                    </a>
                </div>
            </div>
        </div>
        <div class="card">
            <div class="card-header">
                <h3 style="font-size: 18px; font-weight: 700; color: var(--gray-900); margin: 0;">
                    <i class="fas fa-calendar" style="color: var(--success); margin-right: var(--space-2);"></i>
                    Upcoming Events
                </h3>
            </div>
            <div class="card-body">
                <div class="empty-state" style="padding: var(--space-12) var(--space-6);">
                    <div style="font-size: 48px; color: var(--gray-400); margin-bottom: var(--space-4);">
                        <i class="fas fa-calendar-times"></i>
                    </div>
                    <p style="font-size: 16px; font-weight: 600; color: var(--gray-700); margin-bottom: var(--space-4);">No upcoming events</p>
                    <a href="${pageContext.request.contextPath}/events" class="btn btn-success">
                        View All Events
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
