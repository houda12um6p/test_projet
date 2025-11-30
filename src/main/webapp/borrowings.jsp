<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="My Borrowings - UM6P Learning Center" />
    <jsp:param name="active" value="borrowings" />
</jsp:include>

<div class="container">
    <!-- Page Header -->
    <div class="mb-8">
        <h1 style="font-size: 40px; font-weight: 800; color: var(--gray-900); margin-bottom: var(--space-3);">
            <i class="fas fa-book-reader" style="margin-right: var(--space-3); color: var(--orange-primary);"></i>
            My Borrowings
        </h1>
        <p style="font-size: 18px; color: var(--gray-600);">Track your borrowed books and borrowing history</p>
    </div>

    <!-- Filter Tabs -->
    <div style="display: flex; gap: var(--space-2); margin-bottom: var(--space-8); flex-wrap: wrap;">
        <a href="${pageContext.request.contextPath}/borrowings" class="btn btn-outline-primary">
            <i class="fas fa-list"></i> All Borrowings
        </a>
        <a href="${pageContext.request.contextPath}/borrowings/active" class="btn btn-outline-primary">
            <i class="fas fa-book-reader"></i> Active
        </a>
        <a href="${pageContext.request.contextPath}/borrowings/history" class="btn btn-outline-primary">
            <i class="fas fa-history"></i> History
        </a>
        <c:if test="${sessionScope.user.role == 'STAFF'}">
            <a href="${pageContext.request.contextPath}/borrowings/overdue" class="btn btn-danger">
                <i class="fas fa-exclamation-triangle"></i> Overdue
            </a>
            <a href="${pageContext.request.contextPath}/borrowings/all" class="btn btn-outline-primary">
                <i class="fas fa-globe"></i> All Users
            </a>
        </c:if>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i>
            <span>${success}</span>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-error">
            <i class="fas fa-exclamation-circle"></i>
            <span>${error}</span>
        </div>
    </c:if>

    <!-- Summary Cards -->
    <div class="grid grid-cols-4 gap-6 mb-8">
        <div class="card">
            <div class="card-body" style="text-align: center; padding: var(--space-6);">
                <i class="fas fa-book-reader" style="font-size: 48px; color: var(--orange-primary); margin-bottom: var(--space-3); display: block;"></i>
                <h3 style="font-size: 32px; font-weight: 800; margin-bottom: var(--space-1);">${not empty borrowings ? borrowings.size() : 0}</h3>
                <small style="color: var(--gray-600);">Total Borrowings</small>
            </div>
        </div>
        <div class="card">
            <div class="card-body" style="text-align: center; padding: var(--space-6);">
                <i class="fas fa-check-circle" style="font-size: 48px; color: var(--success); margin-bottom: var(--space-3); display: block;"></i>
                <h3 style="font-size: 32px; font-weight: 800; margin-bottom: var(--space-1);">0</h3>
                <small style="color: var(--gray-600);">Active Loans</small>
            </div>
        </div>
        <div class="card">
            <div class="card-body" style="text-align: center; padding: var(--space-6);">
                <i class="fas fa-undo" style="font-size: 48px; color: var(--info); margin-bottom: var(--space-3); display: block;"></i>
                <h3 style="font-size: 32px; font-weight: 800; margin-bottom: var(--space-1);">0</h3>
                <small style="color: var(--gray-600);">Returned</small>
            </div>
        </div>
        <div class="card">
            <div class="card-body" style="text-align: center; padding: var(--space-6);">
                <i class="fas fa-exclamation-triangle" style="font-size: 48px; color: var(--error); margin-bottom: var(--space-3); display: block;"></i>
                <h3 style="font-size: 32px; font-weight: 800; margin-bottom: var(--space-1);">0</h3>
                <small style="color: var(--gray-600);">Overdue</small>
            </div>
        </div>
    </div>

    <!-- Borrowings Table -->
    <div class="card">
        <div class="card-header">
            <h2 style="font-size: 20px; font-weight: 700; color: var(--gray-900); margin: 0;">
                <i class="fas fa-list" style="color: var(--orange-primary); margin-right: var(--space-2);"></i>
                Borrowing History
            </h2>
        </div>
        <div class="card-body" style="padding: 0;">
            <c:choose>
                <c:when test="${not empty borrowings}">
                    <div class="table-container">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Book Title</th>
                                    <th>Borrow Date</th>
                                    <th>Due Date</th>
                                    <th>Return Date</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="borrowing" items="${borrowings}">
                                    <tr>
                                        <td style="font-weight: 600; color: var(--gray-900);">${borrowing.bookTitle}</td>
                                        <td><fmt:formatDate value="${borrowing.borrowDate}" pattern="MMM dd, yyyy" /></td>
                                        <td><fmt:formatDate value="${borrowing.dueDate}" pattern="MMM dd, yyyy" /></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty borrowing.returnDate}">
                                                    <fmt:formatDate value="${borrowing.returnDate}" pattern="MMM dd, yyyy" />
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: var(--gray-500);">Not returned</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${borrowing.status == 'active'}">
                                                    <span class="badge badge-success">Active</span>
                                                </c:when>
                                                <c:when test="${borrowing.status == 'returned'}">
                                                    <span class="badge badge-gray">Returned</span>
                                                </c:when>
                                                <c:when test="${borrowing.status == 'overdue'}">
                                                    <span class="badge badge-danger">Overdue</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-gray">${borrowing.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:if test="${borrowing.status == 'active' || borrowing.status == 'overdue'}">
                                                <form action="${pageContext.request.contextPath}/borrowings/return" method="post" style="display: inline;">
                                                    <input type="hidden" name="borrowingId" value="${borrowing.id}">
                                                    <button type="submit" class="btn btn-sm btn-primary">
                                                        <i class="fas fa-undo"></i> Return
                                                    </button>
                                                </form>
                                            </c:if>
                                            <c:if test="${borrowing.status == 'returned'}">
                                                <span style="color: var(--success); font-size: 14px;">
                                                    <i class="fas fa-check"></i> Completed
                                                </span>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-state-icon">
                            <i class="fas fa-inbox"></i>
                        </div>
                        <h3 class="empty-state-title">No borrowings found</h3>
                        <p class="empty-state-description">Start borrowing books from our library</p>
                        <a href="${pageContext.request.contextPath}/books" class="btn btn-primary">
                            <i class="fas fa-book"></i> Browse Books
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
