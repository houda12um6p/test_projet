<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Staff Dashboard - UM6P Learning Center" />
    <jsp:param name="active" value="dashboard" />
</jsp:include>

<div class="container">
    <!-- Welcome Banner -->
    <div class="mb-8">
        <div class="card" style="background: linear-gradient(135deg, #D94A3D 0%, #B83D32 100%); color: var(--white); border: none;">
            <div class="card-body" style="padding: var(--space-10);">
                <h2 style="font-size: 32px; font-weight: 800; margin: 0 0 var(--space-2) 0;">
                    Welcome back, ${sessionScope.user.name}!
                </h2>
                <p style="font-size: 18px; margin: 0; opacity: 0.95;">
                    <i class="fas fa-briefcase"></i> Staff Member Dashboard
                </p>
            </div>
        </div>
    </div>

    <!-- Quick Stats -->
    <div class="grid grid-cols-4 gap-6 mb-8">
        <div class="card card-hover">
            <div class="card-body" style="text-align: center; padding: var(--space-8);">
                <div style="width: 64px; height: 64px; background-color: #FBE9E7; border-radius: var(--radius-lg); display: flex; align-items: center; justify-content: center; margin: 0 auto var(--space-4) auto;">
                    <i class="fas fa-book" style="font-size: 32px; color: var(--orange-primary);"></i>
                </div>
                <h3 style="font-size: 32px; font-weight: 800; margin-bottom: var(--space-1);">5000+</h3>
                <small style="color: var(--gray-600);">Total Books</small>
                <p style="font-size: 12px; color: var(--gray-500); margin-top: var(--space-2);">In library catalog</p>
            </div>
        </div>

        <div class="card card-hover">
            <div class="card-body" style="text-align: center; padding: var(--space-8);">
                <div style="width: 64px; height: 64px; background-color: #FFF3E0; border-radius: var(--radius-lg); display: flex; align-items: center; justify-content: center; margin: 0 auto var(--space-4) auto;">
                    <i class="fas fa-book-reader" style="font-size: 32px; color: var(--warning);"></i>
                </div>
                <h3 style="font-size: 32px; font-weight: 800; margin-bottom: var(--space-1);">0</h3>
                <small style="color: var(--gray-600);">Active Loans</small>
                <p style="font-size: 12px; color: var(--gray-500); margin-top: var(--space-2);">Currently borrowed</p>
            </div>
        </div>

        <div class="card card-hover">
            <div class="card-body" style="text-align: center; padding: var(--space-8);">
                <div style="width: 64px; height: 64px; background-color: #E8F5E9; border-radius: var(--radius-lg); display: flex; align-items: center; justify-content: center; margin: 0 auto var(--space-4) auto;">
                    <i class="fas fa-calendar-alt" style="font-size: 32px; color: var(--success);"></i>
                </div>
                <h3 style="font-size: 32px; font-weight: 800; margin-bottom: var(--space-1);">0</h3>
                <small style="color: var(--gray-600);">Events</small>
                <p style="font-size: 12px; color: var(--gray-500); margin-top: var(--space-2);">Active events</p>
            </div>
        </div>

        <div class="card card-hover">
            <div class="card-body" style="text-align: center; padding: var(--space-8);">
                <div style="width: 64px; height: 64px; background-color: #E1F5FE; border-radius: var(--radius-lg); display: flex; align-items: center; justify-content: center; margin: 0 auto var(--space-4) auto;">
                    <i class="fas fa-users" style="font-size: 32px; color: var(--info);"></i>
                </div>
                <h3 style="font-size: 32px; font-weight: 800; margin-bottom: var(--space-1);">2000+</h3>
                <small style="color: var(--gray-600);">Users</small>
                <p style="font-size: 12px; color: var(--gray-500); margin-top: var(--space-2);">Registered users</p>
            </div>
        </div>
    </div>

    <!-- Staff Management Actions -->
    <div class="card mb-8">
        <div class="card-header">
            <h4 style="margin: 0; font-size: 20px; font-weight: 700;">
                <i class="fas fa-tools" style="color: var(--orange-primary); margin-right: var(--space-2);"></i>
                Staff Management
            </h4>
        </div>
        <div class="card-body">
            <div class="grid grid-cols-4 gap-4">
                <a href="${pageContext.request.contextPath}/books/list" class="btn btn-outline-primary" style="padding: var(--space-6); display: flex; flex-direction: column; align-items: center; gap: var(--space-3);">
                    <i class="fas fa-book" style="font-size: 32px;"></i>
                    <span>Manage Books</span>
                </a>
                <a href="${pageContext.request.contextPath}/events/list" class="btn btn-outline-primary" style="padding: var(--space-6); display: flex; flex-direction: column; align-items: center; gap: var(--space-3);">
                    <i class="fas fa-calendar-plus" style="font-size: 32px;"></i>
                    <span>Manage Events</span>
                </a>
                <a href="${pageContext.request.contextPath}/borrowings/list" class="btn btn-outline-primary" style="padding: var(--space-6); display: flex; flex-direction: column; align-items: center; gap: var(--space-3);">
                    <i class="fas fa-exchange-alt" style="font-size: 32px;"></i>
                    <span>View Borrowings</span>
                </a>
                <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline-primary" style="padding: var(--space-6); display: flex; flex-direction: column; align-items: center; gap: var(--space-3);">
                    <i class="fas fa-user-circle" style="font-size: 32px;"></i>
                    <span>My Profile</span>
                </a>
            </div>
        </div>
    </div>

    <!-- Recent Activity and System Overview -->
    <div class="grid grid-cols-2 gap-6">
        <!-- Recent Borrowings -->
        <div class="card">
            <div class="card-header">
                <h5 style="margin: 0; font-size: 18px; font-weight: 700;">
                    <i class="fas fa-clock" style="color: var(--warning); margin-right: var(--space-2);"></i>
                    Recent Borrowings
                </h5>
            </div>
            <div class="card-body">
                <div class="empty-state" style="padding: var(--space-8);">
                    <div class="empty-state-icon">
                        <i class="fas fa-inbox"></i>
                    </div>
                    <h3 class="empty-state-title">No Recent Activity</h3>
                    <p class="empty-state-description">No recent borrowing activity to display</p>
                    <a href="${pageContext.request.contextPath}/borrowings/list" class="btn btn-sm btn-primary">
                        View All Borrowings
                    </a>
                </div>
            </div>
        </div>

        <!-- System Overview -->
        <div class="card">
            <div class="card-header">
                <h5 style="margin: 0; font-size: 18px; font-weight: 700;">
                    <i class="fas fa-chart-line" style="color: var(--success); margin-right: var(--space-2);"></i>
                    System Overview
                </h5>
            </div>
            <div class="card-body">
                <div style="display: flex; justify-content: space-between; align-items: center; padding: var(--space-4); margin-bottom: var(--space-4); border-bottom: 1px solid var(--gray-200);">
                    <div>
                        <h6 style="margin: 0 0 var(--space-1) 0; font-size: 14px; font-weight: 700;">Available Books</h6>
                        <small style="color: var(--gray-600);">Ready for borrowing</small>
                    </div>
                    <span class="badge badge-success" style="font-size: 16px; padding: var(--space-2) var(--space-4);">4500+</span>
                </div>
                <div style="display: flex; justify-content: space-between; align-items: center; padding: var(--space-4); margin-bottom: var(--space-4); border-bottom: 1px solid var(--gray-200);">
                    <div>
                        <h6 style="margin: 0 0 var(--space-1) 0; font-size: 14px; font-weight: 700;">Overdue Returns</h6>
                        <small style="color: var(--gray-600);">Require attention</small>
                    </div>
                    <span class="badge badge-danger" style="font-size: 16px; padding: var(--space-2) var(--space-4);">0</span>
                </div>
                <div style="display: flex; justify-content: space-between; align-items: center; padding: var(--space-4);">
                    <div>
                        <h6 style="margin: 0 0 var(--space-1) 0; font-size: 14px; font-weight: 700;">Upcoming Events</h6>
                        <small style="color: var(--gray-600);">Next 30 days</small>
                    </div>
                    <span class="badge badge-primary" style="font-size: 16px; padding: var(--space-2) var(--space-4);">0</span>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
