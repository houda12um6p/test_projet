<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Student Dashboard - UM6P Learning Center" />
    <jsp:param name="active" value="dashboard" />
</jsp:include>

<div class="container">
    <!-- Welcome Section -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-body p-4">
                    <h2 class="card-title">Welcome back, ${sessionScope.user.name}!</h2>
                    <p class="text-muted mb-0">
                        <i class="fas fa-envelope me-2"></i>${sessionScope.user.email}
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Stats -->
    <div class="row g-4 mb-4">
        <div class="col-md-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body text-center">
                    <div class="mb-3">
                        <i class="fas fa-book-reader fa-3x text-primary"></i>
                    </div>
                    <h3 class="card-title">Active Loans</h3>
                    <p class="display-6 text-primary mb-0">0</p>
                    <small class="text-muted">Books currently borrowed</small>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body text-center">
                    <div class="mb-3">
                        <i class="fas fa-calendar-check fa-3x text-success"></i>
                    </div>
                    <h3 class="card-title">Events</h3>
                    <p class="display-6 text-success mb-0">0</p>
                    <small class="text-muted">Upcoming registrations</small>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body text-center">
                    <div class="mb-3">
                        <i class="fas fa-book fa-3x text-info"></i>
                    </div>
                    <h3 class="card-title">Library</h3>
                    <p class="display-6 text-info mb-0">5000+</p>
                    <small class="text-muted">Books available</small>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body text-center">
                    <div class="mb-3">
                        <i class="fas fa-history fa-3x text-warning"></i>
                    </div>
                    <h3 class="card-title">History</h3>
                    <p class="display-6 text-warning mb-0">0</p>
                    <small class="text-muted">Total books borrowed</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="row g-4 mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h4 class="mb-0"><i class="fas fa-bolt me-2 text-warning"></i>Quick Actions</h4>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <a href="${pageContext.request.contextPath}/books/list"
                               class="btn btn-outline-primary w-100 py-3">
                                <i class="fas fa-search fa-2x mb-2 d-block"></i>
                                Browse Books
                            </a>
                        </div>
                        <div class="col-md-4">
                            <a href="${pageContext.request.contextPath}/events/list"
                               class="btn btn-outline-success w-100 py-3">
                                <i class="fas fa-calendar-plus fa-2x mb-2 d-block"></i>
                                Register for Events
                            </a>
                        </div>
                        <div class="col-md-4">
                            <a href="${pageContext.request.contextPath}/borrowings/list"
                               class="btn btn-outline-info w-100 py-3">
                                <i class="fas fa-list fa-2x mb-2 d-block"></i>
                                View My Borrowings
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Activity -->
    <div class="row g-4">
        <div class="col-md-6">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0"><i class="fas fa-book-open me-2 text-primary"></i>Current Borrowings</h5>
                </div>
                <div class="card-body">
                    <div class="text-center text-muted py-5">
                        <i class="fas fa-inbox fa-3x mb-3 d-block"></i>
                        <p>No active borrowings</p>
                        <a href="${pageContext.request.contextPath}/books/list" class="btn btn-sm btn-primary">
                            Browse Books
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0"><i class="fas fa-calendar me-2 text-success"></i>Upcoming Events</h5>
                </div>
                <div class="card-body">
                    <div class="text-center text-muted py-5">
                        <i class="fas fa-calendar-times fa-3x mb-3 d-block"></i>
                        <p>No upcoming events</p>
                        <a href="${pageContext.request.contextPath}/events/list" class="btn btn-sm btn-success">
                            View All Events
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
