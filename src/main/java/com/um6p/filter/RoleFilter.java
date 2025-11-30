package com.um6p.filter;

import com.um6p.model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/staff/*")
public class RoleFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                // Allow access if user is any type of staff (Staff, Librarian, Administrator, System Admin)
                if (user.isStaff() || user.isLibrarian() || user.isAdministrator() || user.isSystemAdmin()) {
                    chain.doFilter(request, response);
                    return;
                }
            }
        }

        httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN,
                "Access Denied - Staff privileges required");
    }

    @Override
    public void destroy() {
        // Cleanup code
    }
}