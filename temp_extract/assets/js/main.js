/**
 * UM6P Learning Center - Main JavaScript Utilities
 * Handles form validation, search, modals, and interactive features
 */

// ====================
// FORM VALIDATION
// ====================

/**
 * Validates email format
 */
function validateEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

/**
 * Validates UM6P email (must end with @um6p.ma)
 */
function validateUM6PEmail(email) {
    return email.endsWith('@um6p.ma');
}

/**
 * Validates password strength
 */
function validatePassword(password) {
    const minLength = 6;
    const hasUppercase = /[A-Z]/.test(password);
    const hasNumber = /[0-9]/.test(password);

    return {
        isValid: password.length >= minLength && hasUppercase && hasNumber,
        length: password.length >= minLength,
        uppercase: hasUppercase,
        number: hasNumber
    };
}

/**
 * Validates ISBN format
 */
function validateISBN(isbn) {
    // Remove hyphens and spaces
    const cleanISBN = isbn.replace(/[-\s]/g, '');

    // Check if it's 10 or 13 digits
    if (cleanISBN.length !== 10 && cleanISBN.length !== 13) {
        return false;
    }

    // Simple check for digits
    return /^\d+$/.test(cleanISBN);
}

// ====================
// SEARCH & FILTER
// ====================

/**
 * Debounce function for search input
 */
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

/**
 * Live search filter for tables
 */
function initTableSearch(inputId, tableId) {
    const searchInput = document.getElementById(inputId);
    const table = document.getElementById(tableId);

    if (!searchInput || !table) return;

    const debouncedSearch = debounce(function(searchTerm) {
        const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
        const term = searchTerm.toLowerCase();

        for (let row of rows) {
            const text = row.textContent.toLowerCase();
            row.style.display = text.includes(term) ? '' : 'none';
        }
    }, 300);

    searchInput.addEventListener('input', function() {
        debouncedSearch(this.value);
    });
}

// ====================
// MODAL FUNCTIONS
// ====================

/**
 * Opens a modal by ID
 */
function openModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.classList.add('active');
        document.body.style.overflow = 'hidden';
    }
}

/**
 * Closes a modal by ID
 */
function closeModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.classList.remove('active');
        document.body.style.overflow = '';
    }
}

/**
 * Initialize all modals on the page
 */
function initModals() {
    // Close modal when clicking outside
    document.querySelectorAll('.modal').forEach(modal => {
        modal.addEventListener('click', function(e) {
            if (e.target === this) {
                closeModal(this.id);
            }
        });
    });

    // Close modal with close button
    document.querySelectorAll('.modal-close').forEach(btn => {
        btn.addEventListener('click', function() {
            const modal = this.closest('.modal');
            if (modal) {
                closeModal(modal.id);
            }
        });
    });

    // Close modal with ESC key
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            document.querySelectorAll('.modal.active').forEach(modal => {
                closeModal(modal.id);
            });
        }
    });
}

// ====================
// ALERTS & NOTIFICATIONS
// ====================

/**
 * Shows a toast notification
 */
function showToast(message, type = 'info', duration = 3000) {
    const toast = document.createElement('div');
    toast.className = `alert alert-${type}`;
    toast.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 9999;
        min-width: 300px;
        animation: slideIn 0.3s ease-out;
    `;

    const icons = {
        success: 'fa-check-circle',
        error: 'fa-exclamation-circle',
        warning: 'fa-exclamation-triangle',
        info: 'fa-info-circle'
    };

    toast.innerHTML = `
        <i class="fas ${icons[type] || icons.info}"></i>
        <span>${message}</span>
    `;

    document.body.appendChild(toast);

    setTimeout(() => {
        toast.style.animation = 'slideOut 0.3s ease-out';
        setTimeout(() => {
            document.body.removeChild(toast);
        }, 300);
    }, duration);
}

// ====================
// FORM HELPERS
// ====================

/**
 * Auto-submit form after delay
 */
function autoSubmitForm(formId, delay = 500) {
    const form = document.getElementById(formId);
    if (!form) return;

    const inputs = form.querySelectorAll('input, select');
    let timeout;

    inputs.forEach(input => {
        input.addEventListener('change', function() {
            clearTimeout(timeout);
            timeout = setTimeout(() => {
                form.submit();
            }, delay);
        });
    });
}

/**
 * Confirm before form submission
 */
function confirmFormSubmit(formId, message) {
    const form = document.getElementById(formId);
    if (!form) return;

    form.addEventListener('submit', function(e) {
        if (!confirm(message)) {
            e.preventDefault();
        }
    });
}

// ====================
// URL QUERY PARAMETERS
// ====================

/**
 * Gets URL parameter by name
 */
function getUrlParameter(name) {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(name);
}

/**
 * Updates URL parameter without reload
 */
function updateUrlParameter(key, value) {
    const url = new URL(window.location);
    url.searchParams.set(key, value);
    window.history.pushState({}, '', url);
}

// ====================
// DATE & TIME FORMATTING
// ====================

/**
 * Formats date to readable string
 */
function formatDate(dateString) {
    const date = new Date(dateString);
    const options = { year: 'numeric', month: 'short', day: 'numeric' };
    return date.toLocaleDateString('en-US', options);
}

/**
 * Gets relative time (e.g., "2 days ago")
 */
function getRelativeTime(dateString) {
    const date = new Date(dateString);
    const now = new Date();
    const diffMs = now - date;
    const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24));

    if (diffDays === 0) return 'Today';
    if (diffDays === 1) return 'Yesterday';
    if (diffDays < 7) return `${diffDays} days ago`;
    if (diffDays < 30) return `${Math.floor(diffDays / 7)} weeks ago`;
    if (diffDays < 365) return `${Math.floor(diffDays / 30)} months ago`;
    return `${Math.floor(diffDays / 365)} years ago`;
}

// ====================
// LOADING SPINNER
// ====================

/**
 * Shows loading spinner
 */
function showLoading(elementId) {
    const element = document.getElementById(elementId);
    if (!element) return;

    const spinner = document.createElement('div');
    spinner.className = 'loading';
    spinner.id = `${elementId}-spinner`;
    element.appendChild(spinner);
}

/**
 * Hides loading spinner
 */
function hideLoading(elementId) {
    const spinner = document.getElementById(`${elementId}-spinner`);
    if (spinner) {
        spinner.remove();
    }
}

// ====================
// PAGINATION
// ====================

/**
 * Simple pagination handler
 */
function initPagination(itemsPerPage = 10) {
    const items = document.querySelectorAll('[data-paginate-item]');
    const totalPages = Math.ceil(items.length / itemsPerPage);
    let currentPage = 1;

    function showPage(page) {
        const start = (page - 1) * itemsPerPage;
        const end = start + itemsPerPage;

        items.forEach((item, index) => {
            item.style.display = (index >= start && index < end) ? '' : 'none';
        });

        currentPage = page;
    }

    showPage(1);

    return {
        goToPage: showPage,
        nextPage: () => showPage(Math.min(currentPage + 1, totalPages)),
        prevPage: () => showPage(Math.max(currentPage - 1, 1)),
        totalPages,
        currentPage: () => currentPage
    };
}

// ====================
// TABS
// ====================

/**
 * Initialize tab navigation
 */
function initTabs() {
    const tabButtons = document.querySelectorAll('[data-tab-button]');
    const tabPanels = document.querySelectorAll('[data-tab-panel]');

    tabButtons.forEach(button => {
        button.addEventListener('click', function() {
            const targetId = this.getAttribute('data-tab-button');

            // Remove active class from all buttons and panels
            tabButtons.forEach(btn => btn.classList.remove('active'));
            tabPanels.forEach(panel => panel.classList.remove('active'));

            // Add active class to clicked button and corresponding panel
            this.classList.add('active');
            const targetPanel = document.querySelector(`[data-tab-panel="${targetId}"]`);
            if (targetPanel) {
                targetPanel.classList.add('active');
            }
        });
    });
}

// ====================
// COPY TO CLIPBOARD
// ====================

/**
 * Copies text to clipboard
 */
function copyToClipboard(text) {
    if (navigator.clipboard) {
        navigator.clipboard.writeText(text).then(() => {
            showToast('Copied to clipboard!', 'success', 2000);
        }).catch(() => {
            showToast('Failed to copy', 'error', 2000);
        });
    } else {
        // Fallback for older browsers
        const textarea = document.createElement('textarea');
        textarea.value = text;
        document.body.appendChild(textarea);
        textarea.select();
        document.execCommand('copy');
        document.body.removeChild(textarea);
        showToast('Copied to clipboard!', 'success', 2000);
    }
}

// ====================
// INITIALIZATION
// ====================

/**
 * Initialize all components when DOM is ready
 */
document.addEventListener('DOMContentLoaded', function() {
    // Initialize modals
    initModals();

    // Initialize tabs
    initTabs();

    // Auto-dismiss alerts after 5 seconds
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
        setTimeout(() => {
            alert.style.transition = 'opacity 0.3s';
            alert.style.opacity = '0';
            setTimeout(() => {
                alert.remove();
            }, 300);
        }, 5000);
    });

    // Add smooth scrolling to anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            const targetId = this.getAttribute('href');
            if (targetId !== '#' && targetId !== '#!') {
                const target = document.querySelector(targetId);
                if (target) {
                    e.preventDefault();
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            }
        });
    });

    // Form validation on submit
    const forms = document.querySelectorAll('form[data-validate]');
    forms.forEach(form => {
        form.addEventListener('submit', function(e) {
            const emailInputs = form.querySelectorAll('input[type="email"]');
            emailInputs.forEach(input => {
                if (input.value && !validateEmail(input.value)) {
                    e.preventDefault();
                    showToast('Please enter a valid email address', 'error');
                    input.focus();
                }
            });
        });
    });

    console.log('UM6P Learning Center - JavaScript initialized successfully');
});

// Export functions for global use
window.LearningCenter = {
    validateEmail,
    validateUM6PEmail,
    validatePassword,
    validateISBN,
    openModal,
    closeModal,
    showToast,
    formatDate,
    getRelativeTime,
    copyToClipboard,
    showLoading,
    hideLoading,
    getUrlParameter,
    updateUrlParameter
};
