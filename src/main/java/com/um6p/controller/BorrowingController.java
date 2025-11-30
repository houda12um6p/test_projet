package com.um6p.controller;

import com.um6p.dao.BookDAO;
import com.um6p.dao.BorrowingDAO;
import com.um6p.model.User;
import com.um6p.model.Borrowing; // ADD THIS IMPORT
import com.um6p.model.Borrowing.BorrowingStatus; // ADD THIS IMPORT

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/borrowings/*")
public class BorrowingController extends HttpServlet {

    private BorrowingDAO borrowingDAO;
    private BookDAO bookDAO;
    private static final int MAX_BORROWING_LIMIT = 5; // Maximum books a user can borrow
    private static final int BORROWING_PERIOD_DAYS = 14; // Default borrowing period

    @Override
    public void init() throws ServletException {
        borrowingDAO = new BorrowingDAO();
        bookDAO = new BookDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // List user's borrowings
            listUserBorrowings(request, response);
        } else if (pathInfo.equals("/active")) {
            // List active borrowings
            listActiveBorrowings(request, response);
        } else if (pathInfo.equals("/history")) {
            // List borrowing history
            listBorrowingHistory(request, response);
        } else if (pathInfo.equals("/overdue")) {
            // List overdue borrowings (staff only)
            listOverdueBorrowings(request, response);
        } else if (pathInfo.equals("/all")) {
            // List all borrowings (staff only)
            listAllBorrowings(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        if (pathInfo == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        } else if (pathInfo.equals("/borrow")) {
            // Borrow a book
            borrowBook(request, response);
        } else if (pathInfo.startsWith("/return/")) {
            // Return a book
            returnBook(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void listUserBorrowings(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Borrowing> borrowings = borrowingDAO.getAllBorrowingsByUser(user.getId());
        request.setAttribute("borrowings", borrowings);
        request.getRequestDispatcher("/student/myBorrowings.jsp").forward(request, response);
    }

    private void listActiveBorrowings(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Borrowing> borrowings = borrowingDAO.getActiveBorrowingsByUser(user.getId());
        request.setAttribute("borrowings", borrowings);
        request.setAttribute("activeOnly", true);
        request.getRequestDispatcher("/student/myBorrowings.jsp").forward(request, response);
    }

    private void listBorrowingHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Borrowing> borrowings = borrowingDAO.getAllBorrowingsByUser(user.getId());
        request.setAttribute("borrowings", borrowings);
        request.setAttribute("historyView", true);
        request.getRequestDispatcher("/student/borrowingHistory.jsp").forward(request, response);
    }

    private void listOverdueBorrowings(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"staff".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        List<Borrowing> overdueBorrowings = borrowingDAO.getOverdueBorrowings();
        request.setAttribute("borrowings", overdueBorrowings);
        request.getRequestDispatcher("/staff/overdueBorrowings.jsp").forward(request, response);
    }

    private void listAllBorrowings(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"staff".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        List<Borrowing> borrowings = borrowingDAO.getAllActiveBorrowings();
        request.setAttribute("borrowings", borrowings);
        request.getRequestDispatcher("/staff/allBorrowings.jsp").forward(request, response);
    }

    private void borrowBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int bookId = Integer.parseInt(request.getParameter("bookId"));

        // Check if user has reached borrowing limit
        int currentBorrowings = borrowingDAO.getActiveBorrowingsCount(user.getId());
        if (currentBorrowings >= MAX_BORROWING_LIMIT) {
            request.setAttribute("error", "You have reached the maximum borrowing limit of " + MAX_BORROWING_LIMIT + " books.");
            response.sendRedirect(request.getContextPath() + "/books/view/" + bookId + "?error=limit");
            return;
        }

        // Check if user has overdue books
        if (borrowingDAO.hasOverdueBooks(user.getId())) {
            request.setAttribute("error", "You have overdue books. Please return them before borrowing new books.");
            response.sendRedirect(request.getContextPath() + "/books/view/" + bookId + "?error=overdue");
            return;
        }

        // Check if book is available
        if (!bookDAO.isBookAvailable(bookId)) {
            request.setAttribute("error", "This book is currently not available.");
            response.sendRedirect(request.getContextPath() + "/books/view/" + bookId + "?error=unavailable");
            return;
        }

        // Calculate due date
        LocalDateTime borrowDate = LocalDateTime.now(); // CHANGED: LocalDate to LocalDateTime
        LocalDateTime dueDate = borrowDate.plusDays(BORROWING_PERIOD_DAYS); // CHANGED: LocalDate to LocalDateTime

        // Create borrowing record
        Borrowing borrowing = new Borrowing();
        borrowing.setUserId(user.getId());
        borrowing.setBookId(bookId);
        borrowing.setBorrowDate(borrowDate); // CHANGED: Direct LocalDateTime, not toString()
        borrowing.setDueDate(dueDate); // CHANGED: Direct LocalDateTime, not toString()
        borrowing.setStatus(BorrowingStatus.BORROWED); // CHANGED: Use enum, not string

        boolean borrowingCreated = borrowingDAO.createBorrowing(borrowing);

        if (borrowingCreated) {
            // Decrement available copies
            bookDAO.decrementAvailableCopies(bookId);
            response.sendRedirect(request.getContextPath() + "/borrowings/active?success=Book borrowed successfully");
        } else {
            request.setAttribute("error", "Failed to borrow book. Please try again.");
            response.sendRedirect(request.getContextPath() + "/books/view/" + bookId + "?error=failed");
        }
    }

    private void returnBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();
        int borrowingId = Integer.parseInt(pathInfo.substring(8)); // Remove "/return/"

        Borrowing borrowing = borrowingDAO.getBorrowingById(borrowingId);

        if (borrowing == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Borrowing record not found");
            return;
        }

        // Verify that the borrowing belongs to the current user (unless staff)
        if (borrowing.getUserId() != user.getId() && !"staff".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        LocalDateTime returnDate = LocalDateTime.now(); // CHANGED: LocalDate to LocalDateTime
        boolean returned = borrowingDAO.returnBook(borrowingId, returnDate); // CHANGED: Direct LocalDateTime, not toString()

        if (returned) {
            // Increment available copies
            bookDAO.incrementAvailableCopies(borrowing.getBookId());
            response.sendRedirect(request.getContextPath() + "/borrowings/active?success=Book returned successfully");
        } else {
            response.sendRedirect(request.getContextPath() + "/borrowings/active?error=Failed to return book");
        }
    }
}