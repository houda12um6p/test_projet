<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="My Reservations - UM6P Learning Center" />
    <jsp:param name="active" value="reservations" />
</jsp:include>

<div class="container">
    <!-- Page Header -->
    <div class="mb-8">
        <h1 style="font-size: 40px; font-weight: 800; color: var(--gray-900); margin-bottom: var(--space-3);">
            <i class="fas fa-bookmark" style="margin-right: var(--space-3); color: var(--orange-primary);"></i>
            My Book Reservations
        </h1>
        <p style="font-size: 18px; color: var(--gray-600);">Track your reserved books and queue positions</p>
    </div>

    <c:if test="${param.success eq 'reserved'}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i>
            <span>Book reserved successfully! Your queue position: <strong>#${param.position}</strong></span>
        </div>
    </c:if>

    <c:if test="${param.success eq 'cancelled'}">
        <div class="alert alert-info">
            <i class="fas fa-info-circle"></i>
            <span>Reservation cancelled successfully.</span>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${empty reservations}">
            <div class="card">
                <div class="card-body">
                    <div class="empty-state">
                        <div class="empty-state-icon">
                            <i class="fas fa-bookmark"></i>
                        </div>
                        <h3 class="empty-state-title">No Active Reservations</h3>
                        <p class="empty-state-description">You don't have any active reservations. Browse our library to reserve a book.</p>
                        <a href="${pageContext.request.contextPath}/books" class="btn btn-primary">
                            <i class="fas fa-book"></i> Browse Books
                        </a>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="grid grid-cols-2 gap-6">
                <c:forEach var="reservation" items="${reservations}">
                    <div class="card card-hover" style="border-left: 4px solid var(--warning);">
                        <div class="card-body">
                            <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: var(--space-4);">
                                <div style="flex: 1;">
                                    <h3 style="font-size: 20px; font-weight: 700; color: var(--gray-900); margin: 0 0 var(--space-2) 0;">${reservation.bookTitle}</h3>
                                    <p style="color: var(--gray-600); margin: 0; font-size: 14px;">by ${reservation.bookAuthor}</p>
                                </div>
                                <c:choose>
                                    <c:when test="${reservation.status == 'PENDING'}">
                                        <span class="badge badge-warning">Pending</span>
                                    </c:when>
                                    <c:when test="${reservation.status == 'AVAILABLE'}">
                                        <span class="badge badge-success">Available</span>
                                    </c:when>
                                    <c:when test="${reservation.status == 'EXPIRED'}">
                                        <span class="badge badge-danger">Expired</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-gray">${reservation.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <c:choose>
                                <c:when test="${reservation.status eq 'PENDING'}">
                                    <div style="padding: var(--space-4); background-color: var(--gray-100); border-radius: var(--radius-md); margin-bottom: var(--space-4);">
                                        <div style="display: grid; grid-template-columns: auto 1fr; gap: var(--space-4); align-items: center;">
                                            <div style="text-align: center;">
                                                <div style="font-size: 32px; font-weight: 800; color: var(--warning);">#${reservation.queuePosition}</div>
                                            </div>
                                            <div>
                                                <small style="color: var(--gray-600); display: block; margin-bottom: var(--space-1);">Queue Position</small>
                                                <p style="margin: 0; color: var(--gray-700); font-size: 14px;">
                                                    Reserved on <fmt:formatDate value="${reservation.reservationDate}" pattern="MMM dd, yyyy"/>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </c:when>
                                <c:when test="${reservation.status eq 'AVAILABLE'}">
                                    <div class="alert alert-success" style="margin-bottom: var(--space-4);">
                                        <i class="fas fa-check-circle"></i>
                                        <div>
                                            <strong>Your book is ready!</strong>
                                            <p style="margin: var(--space-2) 0 var(--space-1) 0; font-size: 14px;">
                                                Pick it up before <fmt:formatDate value="${reservation.expiryDate}" pattern="MMM dd, yyyy HH:mm"/>
                                            </p>
                                            <small style="color: var(--gray-600);">Expires in 48 hours</small>
                                        </div>
                                    </div>
                                </c:when>
                            </c:choose>

                            <div>
                                <form action="${pageContext.request.contextPath}/reservations/cancel" method="get" style="display: inline;" onsubmit="return confirm('Cancel this reservation?')">
                                    <input type="hidden" name="id" value="${reservation.id}">
                                    <button type="submit" class="btn btn-sm btn-danger">
                                        <i class="fas fa-times"></i> Cancel Reservation
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

    <div style="margin-top: var(--space-8);">
        <a href="${pageContext.request.contextPath}/books" class="btn btn-primary">
            <i class="fas fa-book"></i> Browse Books
        </a>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
