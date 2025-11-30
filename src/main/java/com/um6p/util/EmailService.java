package com.um6p.util;

import com.um6p.model.User;
import com.um6p.model.Book;
import com.um6p.model.Event;
import com.um6p.model.Reservation;
import com.um6p.model.Borrowing;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;
import java.util.logging.Logger;
import java.util.logging.Level;
import java.time.format.DateTimeFormatter;

/**
 * EmailService handles all email notifications for the UM6P Learning Center System
 * Implements requirements FR-10 and FR-14 from SRS document
 */
public class EmailService {
    private static final Logger logger = Logger.getLogger(EmailService.class.getName());

    // Email configuration from environment variables or defaults
    private static final String SMTP_HOST = getEnvOrDefault("SMTP_HOST", "smtp.gmail.com");
    private static final String SMTP_PORT = getEnvOrDefault("SMTP_PORT", "587");
    private static final String SMTP_USERNAME = getEnvOrDefault("SMTP_USERNAME", "");
    private static final String SMTP_PASSWORD = getEnvOrDefault("SMTP_PASSWORD", "");
    private static final String FROM_EMAIL = getEnvOrDefault("FROM_EMAIL", "noreply@um6p.ma");
    private static final String FROM_NAME = getEnvOrDefault("FROM_NAME", "UM6P Learning Center");

    // Email enabled flag - can be disabled in development
    private static final boolean EMAIL_ENABLED = Boolean.parseBoolean(
        getEnvOrDefault("EMAIL_ENABLED", "true"));

    private static Session mailSession;

    static {
        initializeMailSession();
    }

    private static void initializeMailSession() {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.ssl.trust", SMTP_HOST);
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");

        mailSession = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SMTP_USERNAME, SMTP_PASSWORD);
            }
        });

        logger.info("Email service initialized. Enabled: " + EMAIL_ENABLED);
    }

    private static String getEnvOrDefault(String key, String defaultValue) {
        String value = System.getenv(key);
        return (value != null && !value.isEmpty()) ? value : defaultValue;
    }

    /**
     * FR-10: Send email confirmation for workshop/event registration
     */
    public static boolean sendRegistrationConfirmation(User user, Event event) {
        if (!EMAIL_ENABLED) {
            logger.info("Email disabled - Would send registration confirmation to: " + user.getEmail());
            return true;
        }

        try {
            String subject = "Registration Confirmed: " + event.getTitle();
            String body = buildRegistrationEmail(user, event);

            sendEmail(user.getEmail(), subject, body);
            logger.info("Registration confirmation sent to: " + user.getEmail() + " for event: " + event.getTitle());
            return true;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Failed to send registration confirmation", e);
            return false;
        }
    }

    /**
     * FR-14: Send email notification when reserved book is available for pickup
     */
    public static boolean sendBookAvailableNotification(User user, Book book, Reservation reservation) {
        if (!EMAIL_ENABLED) {
            logger.info("Email disabled - Would send book available notification to: " + user.getEmail());
            return true;
        }

        try {
            String subject = "Book Ready for Pickup: " + book.getTitle();
            String body = buildBookAvailableEmail(user, book, reservation);

            sendEmail(user.getEmail(), subject, body);
            logger.info("Book available notification sent to: " + user.getEmail() + " for book: " + book.getTitle());
            return true;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Failed to send book available notification", e);
            return false;
        }
    }

    /**
     * Send event reminder (24 hours before event)
     */
    public static boolean sendEventReminder(User user, Event event) {
        if (!EMAIL_ENABLED) {
            logger.info("Email disabled - Would send event reminder to: " + user.getEmail());
            return true;
        }

        try {
            String subject = "Reminder: " + event.getTitle() + " - Tomorrow!";
            String body = buildEventReminderEmail(user, event);

            sendEmail(user.getEmail(), subject, body);
            logger.info("Event reminder sent to: " + user.getEmail() + " for event: " + event.getTitle());
            return true;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Failed to send event reminder", e);
            return false;
        }
    }

    /**
     * Send overdue book notification
     */
    public static boolean sendOverdueBookNotification(User user, Borrowing borrowing, Book book) {
        if (!EMAIL_ENABLED) {
            logger.info("Email disabled - Would send overdue notification to: " + user.getEmail());
            return true;
        }

        try {
            String subject = "Overdue Book Notice: " + book.getTitle();
            String body = buildOverdueEmail(user, borrowing, book);

            sendEmail(user.getEmail(), subject, body);
            logger.info("Overdue notification sent to: " + user.getEmail());
            return true;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Failed to send overdue notification", e);
            return false;
        }
    }

    /**
     * Send event cancellation notification
     */
    public static boolean sendEventCancellation(User user, Event event, String reason) {
        if (!EMAIL_ENABLED) {
            logger.info("Email disabled - Would send cancellation notification to: " + user.getEmail());
            return true;
        }

        try {
            String subject = "Event Cancelled: " + event.getTitle();
            String body = buildCancellationEmail(user, event, reason);

            sendEmail(user.getEmail(), subject, body);
            logger.info("Cancellation notification sent to: " + user.getEmail());
            return true;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Failed to send cancellation notification", e);
            return false;
        }
    }

    /**
     * Send reservation expiry warning (12 hours before expiry)
     */
    public static boolean sendReservationExpiryWarning(User user, Book book, Reservation reservation) {
        if (!EMAIL_ENABLED) {
            logger.info("Email disabled - Would send expiry warning to: " + user.getEmail());
            return true;
        }

        try {
            String subject = "Pickup Reminder: Your Reserved Book Expires Soon";
            String body = buildExpiryWarningEmail(user, book, reservation);

            sendEmail(user.getEmail(), subject, body);
            logger.info("Reservation expiry warning sent to: " + user.getEmail());
            return true;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Failed to send expiry warning", e);
            return false;
        }
    }

    // ==================== Email Building Methods ====================

    private static String buildRegistrationEmail(User user, Event event) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE, MMMM d, yyyy 'at' h:mm a");

        return String.format("""
            <!DOCTYPE html>
            <html>
            <head>
                <style>
                    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
                    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
                    .header { background-color: #003366; color: white; padding: 20px; text-align: center; }
                    .content { background-color: #f9f9f9; padding: 30px; border: 1px solid #ddd; }
                    .event-details { background-color: white; padding: 20px; margin: 20px 0; border-left: 4px solid #003366; }
                    .footer { text-align: center; padding: 20px; color: #666; font-size: 12px; }
                    .button { background-color: #003366; color: white; padding: 12px 30px; text-decoration: none;
                              border-radius: 5px; display: inline-block; margin: 20px 0; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>Registration Confirmed</h1>
                    </div>
                    <div class="content">
                        <p>Dear %s,</p>
                        <p>Thank you for registering! We're excited to confirm your registration for the following event:</p>

                        <div class="event-details">
                            <h2>%s</h2>
                            <p><strong>Date & Time:</strong> %s</p>
                            <p><strong>Location:</strong> %s</p>
                            <p><strong>Category:</strong> %s</p>
                            %s
                        </div>

                        <p><strong>Important Information:</strong></p>
                        <ul>
                            <li>Please arrive 10 minutes early for check-in</li>
                            <li>Bring your student ID for verification</li>
                            <li>Check your email for any updates or changes</li>
                        </ul>

                        <p>If you need to cancel your registration, please do so at least 24 hours in advance
                        through the Learning Center portal.</p>

                        <p>Looking forward to seeing you there!</p>
                    </div>
                    <div class="footer">
                        <p>UM6P Learning Center | Mohammed VI Polytechnic University</p>
                        <p>This is an automated message. Please do not reply to this email.</p>
                    </div>
                </div>
            </body>
            </html>
            """,
            user.getName(),
            event.getTitle(),
            event.getEventDate(),
            event.getLocation(),
            event.getCategory(),
            event.getDescription() != null ? "<p><strong>Description:</strong> " + event.getDescription() + "</p>" : ""
        );
    }

    private static String buildBookAvailableEmail(User user, Book book, Reservation reservation) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE, MMMM d, yyyy 'at' h:mm a");
        String expiryTime = reservation.getExpiryDate() != null ?
            reservation.getExpiryDate().format(formatter) : "within 48 hours";

        return String.format("""
            <!DOCTYPE html>
            <html>
            <head>
                <style>
                    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
                    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
                    .header { background-color: #28a745; color: white; padding: 20px; text-align: center; }
                    .content { background-color: #f9f9f9; padding: 30px; border: 1px solid #ddd; }
                    .book-info { background-color: white; padding: 20px; margin: 20px 0; border-left: 4px solid #28a745; }
                    .warning { background-color: #fff3cd; padding: 15px; border-radius: 5px; margin: 20px 0;
                              border-left: 4px solid #ffc107; }
                    .footer { text-align: center; padding: 20px; color: #666; font-size: 12px; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>📚 Your Reserved Book is Ready!</h1>
                    </div>
                    <div class="content">
                        <p>Dear %s,</p>
                        <p>Great news! The book you reserved is now available for pickup at the Learning Center.</p>

                        <div class="book-info">
                            <h2>%s</h2>
                            <p><strong>Author:</strong> %s</p>
                            <p><strong>ISBN:</strong> %s</p>
                            <p><strong>Location:</strong> %s</p>
                            <p><strong>Queue Position:</strong> %d</p>
                        </div>

                        <div class="warning">
                            <p><strong>⏰ Important: 48-Hour Pickup Window</strong></p>
                            <p>Please pick up your book before <strong>%s</strong></p>
                            <p>If not picked up within 48 hours, your reservation will be automatically cancelled
                            and the book will be offered to the next person in the queue.</p>
                        </div>

                        <p><strong>Pickup Instructions:</strong></p>
                        <ol>
                            <li>Visit the Learning Center during operating hours</li>
                            <li>Bring your student ID</li>
                            <li>Go to the circulation desk</li>
                            <li>Mention your reservation (Reservation ID: #%d)</li>
                        </ol>

                        <p>Thank you for using the UM6P Learning Center!</p>
                    </div>
                    <div class="footer">
                        <p>UM6P Learning Center | Mohammed VI Polytechnic University</p>
                        <p>This is an automated message. Please do not reply to this email.</p>
                    </div>
                </div>
            </body>
            </html>
            """,
            user.getName(),
            book.getTitle(),
            book.getAuthor(),
            book.getIsbn() != null ? book.getIsbn() : "N/A",
            book.getLocation() != null ? book.getLocation() : "See librarian",
            reservation.getQueuePosition(),
            expiryTime,
            reservation.getId()
        );
    }

    private static String buildEventReminderEmail(User user, Event event) {
        return String.format("""
            <!DOCTYPE html>
            <html>
            <head>
                <style>
                    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
                    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
                    .header { background-color: #ffc107; color: #333; padding: 20px; text-align: center; }
                    .content { background-color: #f9f9f9; padding: 30px; border: 1px solid #ddd; }
                    .footer { text-align: center; padding: 20px; color: #666; font-size: 12px; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>⏰ Event Reminder</h1>
                    </div>
                    <div class="content">
                        <p>Dear %s,</p>
                        <p>This is a friendly reminder that you're registered for the following event <strong>tomorrow</strong>:</p>
                        <h2>%s</h2>
                        <p><strong>Date & Time:</strong> %s</p>
                        <p><strong>Location:</strong> %s</p>
                        <p>We look forward to seeing you there!</p>
                    </div>
                    <div class="footer">
                        <p>UM6P Learning Center</p>
                    </div>
                </div>
            </body>
            </html>
            """,
            user.getName(),
            event.getTitle(),
            event.getEventDate(),
            event.getLocation()
        );
    }

    private static String buildOverdueEmail(User user, Borrowing borrowing, Book book) {
        return String.format("""
            <!DOCTYPE html>
            <html>
            <head>
                <style>
                    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
                    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
                    .header { background-color: #dc3545; color: white; padding: 20px; text-align: center; }
                    .content { background-color: #f9f9f9; padding: 30px; border: 1px solid #ddd; }
                    .footer { text-align: center; padding: 20px; color: #666; font-size: 12px; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>⚠️ Overdue Book Notice</h1>
                    </div>
                    <div class="content">
                        <p>Dear %s,</p>
                        <p>Our records show that the following book is overdue:</p>
                        <h2>%s</h2>
                        <p><strong>Due Date:</strong> %s</p>
                        <p><strong>Fine Amount:</strong> MAD %.2f</p>
                        <p>Please return the book as soon as possible to avoid additional fines.</p>
                    </div>
                    <div class="footer">
                        <p>UM6P Learning Center</p>
                    </div>
                </div>
            </body>
            </html>
            """,
            user.getName(),
            book.getTitle(),
            borrowing.getDueDate(),
            borrowing.getFineAmount()
        );
    }

    private static String buildCancellationEmail(User user, Event event, String reason) {
        return String.format("""
            <!DOCTYPE html>
            <html>
            <head>
                <style>
                    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
                    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
                    .header { background-color: #6c757d; color: white; padding: 20px; text-align: center; }
                    .content { background-color: #f9f9f9; padding: 30px; border: 1px solid #ddd; }
                    .footer { text-align: center; padding: 20px; color: #666; font-size: 12px; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>Event Cancellation Notice</h1>
                    </div>
                    <div class="content">
                        <p>Dear %s,</p>
                        <p>We regret to inform you that the following event has been cancelled:</p>
                        <h2>%s</h2>
                        <p><strong>Originally Scheduled:</strong> %s</p>
                        %s
                        <p>We apologize for any inconvenience. Please check our events page for other upcoming opportunities.</p>
                    </div>
                    <div class="footer">
                        <p>UM6P Learning Center</p>
                    </div>
                </div>
            </body>
            </html>
            """,
            user.getName(),
            event.getTitle(),
            event.getEventDate(),
            reason != null ? "<p><strong>Reason:</strong> " + reason + "</p>" : ""
        );
    }

    private static String buildExpiryWarningEmail(User user, Book book, Reservation reservation) {
        return String.format("""
            <!DOCTYPE html>
            <html>
            <head>
                <style>
                    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
                    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
                    .header { background-color: #ff6600; color: white; padding: 20px; text-align: center; }
                    .content { background-color: #f9f9f9; padding: 30px; border: 1px solid #ddd; }
                    .footer { text-align: center; padding: 20px; color: #666; font-size: 12px; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>⏰ Reservation Expiring Soon!</h1>
                    </div>
                    <div class="content">
                        <p>Dear %s,</p>
                        <p>This is a reminder that your reservation for the following book will expire in 12 hours:</p>
                        <h2>%s</h2>
                        <p><strong>Expiry Time:</strong> %s</p>
                        <p>Please pick up your book before it expires, or it will be offered to the next person in the queue.</p>
                    </div>
                    <div class="footer">
                        <p>UM6P Learning Center</p>
                    </div>
                </div>
            </body>
            </html>
            """,
            user.getName(),
            book.getTitle(),
            reservation.getExpiryDate()
        );
    }

    // ==================== Core Email Sending Method ====================

    private static void sendEmail(String to, String subject, String htmlBody) throws MessagingException {
        try {
            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(FROM_EMAIL, FROM_NAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setContent(htmlBody, "text/html; charset=utf-8");

            Transport.send(message);
        } catch (java.io.UnsupportedEncodingException e) {
            throw new MessagingException("Failed to set sender name", e);
        }
    }

    /**
     * Test email connectivity
     */
    public static boolean testEmailConnection() {
        try {
            Transport transport = mailSession.getTransport("smtp");
            transport.connect(SMTP_HOST, SMTP_USERNAME, SMTP_PASSWORD);
            transport.close();
            logger.info("Email connection test successful");
            return true;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Email connection test failed", e);
            return false;
        }
    }
}
