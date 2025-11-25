<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="My Reservations - UM6P Learning Center" />
    <jsp:param name="active" value="reservations" />
</jsp:include>

<style>
    .reservation-card {
        border-left: 4px solid #f39c12;
        margin-bottom: 15px;
        transition: all 0.3s ease;
    }
    .reservation-card:hover {
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        transform: translateY(-2px);
    }
    .status-badge {
        font-size: 0.85em;
        padding: 5px 12px;
    }
    .status-pending { background: linear-gradient(135deg, #f39c12, #f1c40f); }
    .status-available {
        background: linear-gradient(135deg, #27ae60, #2ecc71);
        animation: pulse 2s infinite;
    }
    .status-expired { background: linear-gradient(135deg, #e74c3c, #c0392b); }

    @keyframes pulse {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.7; }
    }

    .queue-position {
        font-size: 1.8em;
        font-weight: bold;
        color: #f39c12;
    }
</style>

<div class="container mt-4">
    <h2 class="mb-4">
        <i class="fas fa-bookmark"></i> My Book Reservations
    </h2>

    <c:if test="${param.success eq 'reserved'}">
        <div class="alert alert-success alert-dismissible fade show">
            <i class="fas fa-check-circle"></i> Book reserved successfully! Your queue position: <strong>#${param.position}</strong>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:if test="${param.success eq 'cancelled'}">
        <div class="alert alert-info alert-dismissible fade show">
            <i class="fas fa-info-circle"></i> Reservation cancelled successfully.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${empty reservations}">
            <div class="alert alert-info">
                <i class="fas fa-info-circle"></i> You don't have any active reservations.
                <a href="${pageContext.request.contextPath}/books" class="alert-link">Browse books</a> to reserve one.
            </div>
        </c:when>
        <c:otherwise>
            <div class="row">
                <c:forEach var="reservation" items="${reservations}">
                    <div class="col-md-6">
                        <div class="card reservation-card">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <h5 class="card-title">${reservation.bookTitle}</h5>
                                        <p class="text-muted mb-2">by ${reservation.bookAuthor}</p>
                                    </div>
                                    <span class="badge status-badge status-${fn:toLowerCase(reservation.status)}">
                                        ${reservation.status}
                                    </span>
                                </div>

                                <c:choose>
                                    <c:when test="${reservation.status eq 'PENDING'}">
                                        <div class="mt-3 p-3 bg-light rounded">
                                            <div class="row align-items-center">
                                                <div class="col-auto">
                                                    <div class="queue-position">#${reservation.queuePosition}</div>
                                                </div>
                                                <div class="col">
                                                    <small class="text-muted">Queue Position</small>
                                                    <p class="mb-0">Reserved on <fmt:formatDate value="${reservation.reservationDate}" pattern="MMM dd, yyyy"/></p>
                                                </div>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:when test="${reservation.status eq 'AVAILABLE'}">
                                        <div class="alert alert-success mt-3 mb-0">
                                            <i class="fas fa-check-circle"></i> <strong>Your book is ready!</strong>
                                            <p class="mb-1 mt-2">Pick it up before <fmt:formatDate value="${reservation.expiryDate}" pattern="MMM dd, yyyy HH:mm"/></p>
                                            <small class="text-muted">Expires in 48 hours</small>
                                        </div>
                                    </c:when>
                                </c:choose>

                                <div class="mt-3">
                                    <form action="${pageContext.request.contextPath}/reservations/cancel" method="get" style="display: inline;">
                                        <input type="hidden" name="id" value="${reservation.id}">
                                        <button type="submit" class="btn btn-sm btn-outline-danger" onclick="return confirm('Cancel this reservation?')">
                                            <i class="fas fa-times"></i> Cancel Reservation
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/books" class="btn btn-primary">
            <i class="fas fa-book"></i> Browse Books
        </a>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
