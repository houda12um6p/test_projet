        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-brand">
                    <div class="footer-logo">
                        <i class="fas fa-graduation-cap"></i>
                        <span>UM6P Learning Center</span>
                    </div>
                    <p class="footer-description">
                        Mohammed VI Polytechnic University<br>
                        Ben Guerir, Morocco
                    </p>
                </div>
                
                <div class="footer-contact">
                    <p><strong>Contact Information</strong></p>
                    <p>Email: learning.center@um6p.ma</p>
                    <p>Phone: +212 525-073-000</p>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p>&copy; 2025 Mohammed VI Polytechnic University. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
    <script>
        // Mobile menu toggle
        document.addEventListener('DOMContentLoaded', function() {
            const navbarToggle = document.getElementById('navbarToggle');
            const navbarNav = document.getElementById('navbarNav');

            if (navbarToggle && navbarNav) {
                navbarToggle.addEventListener('click', function() {
                    navbarNav.classList.toggle('active');
                    const icon = this.querySelector('i');
                    if (navbarNav.classList.contains('active')) {
                        icon.className = 'fas fa-times';
                    } else {
                        icon.className = 'fas fa-bars';
                    }
                });
            }

            // Close mobile menu when clicking outside
            document.addEventListener('click', function(event) {
                if (!event.target.closest('.navbar-container') && navbarNav.classList.contains('active')) {
                    navbarNav.classList.remove('active');
                    const icon = navbarToggle.querySelector('i');
                    icon.className = 'fas fa-bars';
                }
            });

            // Display URL parameters as alerts
            const urlParams = new URLSearchParams(window.location.search);
            const success = urlParams.get('success');
            const error = urlParams.get('error');

            if (success && window.LearningCenter) {
                window.LearningCenter.showToast(success, 'success');
            }
            if (error && window.LearningCenter) {
                window.LearningCenter.showToast(error, 'error');
            }
        });
    </script>
</body>
</html>