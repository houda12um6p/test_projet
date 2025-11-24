package com.um6p.filter;

import com.um6p.util.ConfigLoader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.SecureRandom;
import java.util.Base64;

@WebFilter("/*")
public class CSRFFilter implements Filter {
    private static final Logger logger = LoggerFactory.getLogger(CSRFFilter.class);
    private static final String CSRF_TOKEN_ATTRIBUTE = "csrfToken";
    private static final String CSRF_HEADER_NAME = "X-CSRF-Token";
    private static final int TOKEN_LENGTH = 32;
    private static final SecureRandom secureRandom = new SecureRandom();
    private boolean csrfEnabled;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        csrfEnabled = ConfigLoader.isCsrfEnabled();
        logger.info("CSRF Filter initialized - Enabled: {}", csrfEnabled);
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Skip CSRF for disabled configuration
        if (!csrfEnabled) {
            chain.doFilter(request, response);
            return;
        }

        // Skip CSRF protection for GET, HEAD, OPTIONS (safe methods)
        String method = httpRequest.getMethod();
        if ("GET".equalsIgnoreCase(method) || "HEAD".equalsIgnoreCase(method) ||
            "OPTIONS".equalsIgnoreCase(method)) {

            // Generate token for session if it doesn't exist
            HttpSession session = httpRequest.getSession(false);
            if (session != null && session.getAttribute(CSRF_TOKEN_ATTRIBUTE) == null) {
                String token = generateToken();
                session.setAttribute(CSRF_TOKEN_ATTRIBUTE, token);
                logger.debug("Generated new CSRF token for session: {}", session.getId());
            }

            chain.doFilter(request, response);
            return;
        }

        // Skip CSRF for public endpoints (login, register)
        String uri = httpRequest.getRequestURI();
        if (isPublicEndpoint(uri)) {
            chain.doFilter(request, response);
            return;
        }

        // Validate CSRF token for state-changing methods (POST, PUT, DELETE, PATCH)
        HttpSession session = httpRequest.getSession(false);
        if (session == null) {
            logger.warn("CSRF validation failed: No session found");
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid session");
            return;
        }

        String sessionToken = (String) session.getAttribute(CSRF_TOKEN_ATTRIBUTE);
        if (sessionToken == null) {
            logger.warn("CSRF validation failed: No CSRF token in session");
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "CSRF token missing");
            return;
        }

        // Get token from request (either header or parameter)
        String requestToken = httpRequest.getHeader(CSRF_HEADER_NAME);
        if (requestToken == null) {
            requestToken = httpRequest.getParameter("csrfToken");
        }

        if (requestToken == null || !sessionToken.equals(requestToken)) {
            logger.warn("CSRF validation failed: Token mismatch. Session: {}, Request: {}",
                    sessionToken, requestToken);
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token");
            return;
        }

        logger.debug("CSRF token validated successfully");
        chain.doFilter(request, response);
    }

    private boolean isPublicEndpoint(String uri) {
        return uri.contains("/login") ||
               uri.contains("/register") ||
               uri.contains("/logout") ||
               uri.endsWith(".css") ||
               uri.endsWith(".js") ||
               uri.endsWith(".jpg") ||
               uri.endsWith(".png") ||
               uri.endsWith(".gif") ||
               uri.endsWith(".ico");
    }

    private String generateToken() {
        byte[] randomBytes = new byte[TOKEN_LENGTH];
        secureRandom.nextBytes(randomBytes);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(randomBytes);
    }

    @Override
    public void destroy() {
        logger.info("CSRF Filter destroyed");
    }
}
