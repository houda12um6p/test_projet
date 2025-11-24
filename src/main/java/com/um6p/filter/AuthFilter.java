package com.um6p.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("Authentication Filter initialized");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String uri = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();

        // Add security headers to all responses
        addSecurityHeaders(httpResponse);

        // Check for static resources first (most efficient)
        if (isStaticResource(uri)) {
            chain.doFilter(request, response);
            return;
        }

        // Public pages that don't require authentication
        boolean isPublicPage = isPublicPage(uri, contextPath);

        // Check if user is logged in
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);

        // Check session timeout for logged-in users
        if (isLoggedIn && isSessionExpired(session)) {
            session.invalidate();
            httpResponse.sendRedirect(contextPath + "/login.jsp?error=session_timeout");
            return;
        }

        if (isLoggedIn) {
            // User is logged in, check authorization
            String userRole = (String) session.getAttribute("userRole");
            if (isAuthorized(uri, userRole, contextPath)) {
                chain.doFilter(request, response);
            } else {
                // Log unauthorized access attempt
                System.err.println("Unauthorized access attempt by user " +
                        session.getAttribute("userName") + " to: " + uri);
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            }
        } else if (isPublicPage) {
            // Public page, allow access
            chain.doFilter(request, response);
        } else {
            // User is not logged in and trying to access protected page
            // Log unauthorized access attempt
            System.err.println("Unauthenticated access attempt to: " + uri +
                    " from IP: " + httpRequest.getRemoteAddr());
            httpResponse.sendRedirect(contextPath + "/login.jsp?error=login_required");
        }
    }

    private boolean isStaticResource(String uri) {
        return uri.contains("/css/") ||
                uri.contains("/js/") ||
                uri.contains("/images/") ||
                uri.contains("/fonts/") ||
                uri.endsWith(".css") ||
                uri.endsWith(".js") ||
                uri.endsWith(".png") ||
                uri.endsWith(".jpg") ||
                uri.endsWith(".jpeg") ||
                uri.endsWith(".gif") ||
                uri.endsWith(".ico") ||
                uri.endsWith(".svg");
    }

    private boolean isPublicPage(String uri, String contextPath) {
        return uri.endsWith("login.jsp") ||
                uri.endsWith("register.jsp") ||
                uri.endsWith("index.jsp") ||
                uri.contains("/login") ||
                uri.contains("/register") ||
                uri.equals(contextPath + "/") ||
                uri.equals(contextPath + "/index.jsp");
    }

    private boolean isAuthorized(String uri, String userRole, String contextPath) {
        // Staff-only areas
        if (uri.contains("/staff/") || uri.contains("/admin/")) {
            return "staff".equals(userRole);
        }

        // Student areas (students and staff can access)
        if (uri.contains("/student/")) {
            return "student".equals(userRole) || "staff".equals(userRole);
        }

        // Common areas accessible to all authenticated users
        return uri.contains("/profile") ||
                uri.contains("/events") ||
                uri.contains("/books") ||
                uri.contains("/borrowings") ||
                uri.endsWith("dashboard.jsp") ||
                uri.equals(contextPath + "/");
    }

    private boolean isSessionExpired(HttpSession session) {
        long lastAccessedTime = session.getLastAccessedTime();
        long currentTime = System.currentTimeMillis();
        long sessionTimeout = session.getMaxInactiveInterval() * 1000L;

        return (currentTime - lastAccessedTime) > sessionTimeout;
    }

    private void addSecurityHeaders(HttpServletResponse response) {
        response.setHeader("X-Content-Type-Options", "nosniff");
        response.setHeader("X-Frame-Options", "DENY");
        response.setHeader("X-XSS-Protection", "1; mode=block");
        response.setHeader("Strict-Transport-Security", "max-age=31536000; includeSubDomains");
    }

    @Override
    public void destroy() {
        System.out.println("Authentication Filter destroyed");
    }
}