package com.um6p.controller;

import com.um6p.dao.ReservationDAO;
import com.um6p.dao.BookDAO;
import com.um6p.model.Reservation;
import com.um6p.model.Book;
import com.um6p.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/reservations/*")
public class ReservationController extends HttpServlet {
    private ReservationDAO reservationDAO = new ReservationDAO();
    private BookDAO bookDAO = new BookDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = request.getPathInfo();

        try {
            if (action == null || action.equals("/")) {
                listReservations(request, response, user);
            } else if (action.equals("/cancel")) {
                cancelReservation(request, response, user);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = request.getPathInfo();

        try {
            if (action != null && action.equals("/reserve")) {
                createReservation(request, response, user);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    private void listReservations(HttpServletRequest request, HttpServletResponse response, User user)
            throws SQLException, ServletException, IOException {
        List<Reservation> reservations = reservationDAO.getByUserId(user.getId());
        request.setAttribute("reservations", reservations);
        request.getRequestDispatcher("/reservations.jsp").forward(request, response);
    }

    private void createReservation(HttpServletRequest request, HttpServletResponse response, User user)
            throws SQLException, IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));

        Book book = bookDAO.getBookById(bookId);
        if (book == null) {
            response.sendRedirect(request.getContextPath() + "/books?error=book_not_found");
            return;
        }

        if (book.canBorrow()) {
            response.sendRedirect(request.getContextPath() + "/books?error=book_available");
            return;
        }

        Reservation reservation = new Reservation(user.getId(), bookId);
        boolean created = reservationDAO.create(reservation);

        if (created) {
            response.sendRedirect(request.getContextPath() + "/reservations?success=reserved&position=" + reservation.getQueuePosition());
        } else {
            response.sendRedirect(request.getContextPath() + "/books?error=reservation_failed");
        }
    }

    private void cancelReservation(HttpServletRequest request, HttpServletResponse response, User user)
            throws SQLException, IOException {
        int reservationId = Integer.parseInt(request.getParameter("id"));

        boolean cancelled = reservationDAO.cancel(reservationId);
        if (cancelled) {
            response.sendRedirect(request.getContextPath() + "/reservations?success=cancelled");
        } else {
            response.sendRedirect(request.getContextPath() + "/reservations?error=cancel_failed");
        }
    }
}
