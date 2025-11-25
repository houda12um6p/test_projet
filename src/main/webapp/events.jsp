<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Events - UM6P Learning Center" />
    <jsp:param name="active" value="events" />
</jsp:include>

<div class="container">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <h1 class="display-4"><i class="fas fa-calendar-alt me-3"></i>Events & Workshops</h1>
            <p class="lead text-muted">Register for upcoming seminars, workshops, and training sessions</p>
        </div>
    </div>

    <!-- Filter and Actions -->
    <div class="row mb-4">
        <div class="col-md-8">
            <div class="btn-group">
                <a href="${pageContext.request.contextPath}/events" class="btn btn-outline-primary">
                    <i class="fas fa-list me-2"></i>All Events
                </a>
                <a href="${pageContext.request.contextPath}/events/upcoming" class="btn btn-outline-success">
                    <i class="fas fa-clock me-2"></i>Upcoming
                </a>
                <a href="${pageContext.request.contextPath}/events/my-registrations" class="btn btn-outline-info">
                    <i class="fas fa-user-check me-2"></i>My Registrations
                </a>
            </div>
        </div>
        <c:if test="${sessionScope.user.role == 'STAFF'}">
            <div class="col-md-4 text-end">
                <a href="${pageContext.request.contextPath}/events/add" class="btn btn-success">
                    <i class="fas fa-plus me-2"></i>Create Event
                </a>
            </div>
        </c:if>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show">
            <i class="fas fa-check-circle me-2"></i>${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show">
            <i class="fas fa-exclamation-circle me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Events List -->
    <div class="row">
        <c:choose>
            <c:when test="${not empty events}">
                <c:forEach var="event" items="${events}">
                    <div class="col-md-6 mb-4">
                        <div class="card h-100 border-0 shadow-sm">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <h5 class="card-title mb-0">${event.title}</h5>
                                    <c:choose>
                                        <c:when test="${event.status == 'active'}">
                                            <span class="badge bg-success">Active</span>
                                        </c:when>
                                        <c:when test="${event.status == 'cancelled'}">
                                            <span class="badge bg-danger">Cancelled</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Completed</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <p class="card-text text-muted mb-3">${event.description}</p>

                                <div class="mb-3">
                                    <p class="mb-2">
                                        <i class="fas fa-calendar text-primary me-2"></i>
                                        <strong>Date:</strong> ${event.eventDate}
                                    </p>
                                    <p class="mb-2">
                                        <i class="fas fa-map-marker-alt text-danger me-2"></i>
                                        <strong>Location:</strong> ${event.location}
                                    </p>
                                    <p class="mb-2">
                                        <i class="fas fa-tag text-success me-2"></i>
                                        <strong>Category:</strong>
                                        <span class="badge bg-light text-dark">${event.category}</span>
                                    </p>
                                </div>

                                <!-- Capacity Progress -->
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between mb-1">
                                        <small class="text-muted">Capacity</small>
                                        <small class="text-muted">${event.currentAttendees} / ${event.capacity}</small>
                                    </div>
                                    <c:set var="percentage" value="${(event.currentAttendees * 100) / event.capacity}" />
                                    <div class="progress" style="height: 20px;">
                                        <div class="progress-bar ${percentage >= 90 ? 'bg-danger' : percentage >= 70 ? 'bg-warning' : 'bg-success'}"
                                             style="width: ${percentage}%">
                                            ${event.currentAttendees} registered
                                        </div>
                                    </div>
                                    <c:if test="${event.currentAttendees >= event.capacity}">
                                        <small class="text-danger">
                                            <i class="fas fa-exclamation-triangle me-1"></i>Event is full
                                        </small>
                                    </c:if>
                                    <c:if test="${event.currentAttendees < event.capacity}">
                                        <small class="text-success">
                                            <i class="fas fa-check-circle me-1"></i>${event.capacity - event.currentAttendees} spots available
                                        </small>
                                    </c:if>
                                </div>

                                <!-- Action Buttons -->
                                <div class="d-grid gap-2">
                                    <c:choose>
                                        <c:when test="${event.status == 'active' && event.currentAttendees < event.capacity}">
                                            <form action="${pageContext.request.contextPath}/events/register" method="post">
                                                <input type="hidden" name="eventId" value="${event.id}">
                                                <button type="submit" class="btn btn-primary w-100">
                                                    <i class="fas fa-calendar-check me-2"></i>Register for Event
                                                </button>
                                            </form>
                                        </c:when>
                                        <c:when test="${event.currentAttendees >= event.capacity}">
                                            <button class="btn btn-secondary w-100" disabled>
                                                <i class="fas fa-times me-2"></i>Event Full
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="btn btn-secondary w-100" disabled>
                                                <i class="fas fa-ban me-2"></i>${event.status == 'cancelled' ? 'Cancelled' : 'Completed'}
                                            </button>
                                        </c:otherwise>
                                    </c:choose>

                                    <c:if test="${sessionScope.user.role == 'STAFF'}">
                                        <div class="btn-group">
                                            <a href="${pageContext.request.contextPath}/events/edit/${event.id}"
                                               class="btn btn-sm btn-outline-warning">
                                                <i class="fas fa-edit"></i> Edit
                                            </a>
                                            <form action="${pageContext.request.contextPath}/events/delete/${event.id}"
                                                  method="post" class="d-inline"
                                                  onsubmit="return confirm('Are you sure you want to delete this event?');">
                                                <button type="submit" class="btn btn-sm btn-outline-danger">
                                                    <i class="fas fa-trash"></i> Delete
                                                </button>
                                            </form>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="col-12">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body text-center py-5">
                            <i class="fas fa-calendar-times fa-4x text-muted mb-3 d-block"></i>
                            <h4 class="text-muted">No events found</h4>
                            <p class="text-muted">Check back later for upcoming events</p>
                            <c:if test="${sessionScope.user.role == 'STAFF'}">
                                <a href="${pageContext.request.contextPath}/events/add" class="btn btn-primary">
                                    <i class="fas fa-plus me-2"></i>Create New Event
                                </a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
