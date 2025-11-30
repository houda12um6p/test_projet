/**
 * UM6P Learning Center - Carousel Component
 * Professional image carousel with auto-play and manual controls
 */

class Carousel {
    constructor(element) {
        this.carousel = element;
        this.items = element.querySelectorAll('.carousel-item');
        this.indicators = element.querySelectorAll('.carousel-indicator');
        this.prevBtn = element.querySelector('.carousel-prev');
        this.nextBtn = element.querySelector('.carousel-next');

        this.currentIndex = 0;
        this.autoPlayInterval = null;
        this.autoPlayDelay = 5000; // 5 seconds

        this.init();
    }

    init() {
        // Show first item
        if (this.items.length > 0) {
            this.showItem(0);
        }

        // Add event listeners
        if (this.prevBtn) {
            this.prevBtn.addEventListener('click', () => this.prev());
        }

        if (this.nextBtn) {
            this.nextBtn.addEventListener('click', () => this.next());
        }

        // Indicator clicks
        this.indicators.forEach((indicator, index) => {
            indicator.addEventListener('click', () => {
                this.goTo(index);
            });
        });

        // Keyboard navigation
        document.addEventListener('keydown', (e) => {
            if (e.key === 'ArrowLeft') this.prev();
            if (e.key === 'ArrowRight') this.next();
        });

        // Touch/swipe support
        this.addSwipeSupport();

        // Start autoplay
        this.startAutoPlay();

        // Pause on hover
        this.carousel.addEventListener('mouseenter', () => this.stopAutoPlay());
        this.carousel.addEventListener('mouseleave', () => this.startAutoPlay());
    }

    showItem(index) {
        // Remove active class from all items and indicators
        this.items.forEach(item => item.classList.remove('active'));
        this.indicators.forEach(indicator => indicator.classList.remove('active'));

        // Add active class to current item and indicator
        if (this.items[index]) {
            this.items[index].classList.add('active');
        }
        if (this.indicators[index]) {
            this.indicators[index].classList.add('active');
        }

        this.currentIndex = index;
    }

    next() {
        let newIndex = this.currentIndex + 1;
        if (newIndex >= this.items.length) {
            newIndex = 0;
        }
        this.showItem(newIndex);
    }

    prev() {
        let newIndex = this.currentIndex - 1;
        if (newIndex < 0) {
            newIndex = this.items.length - 1;
        }
        this.showItem(newIndex);
    }

    goTo(index) {
        if (index >= 0 && index < this.items.length) {
            this.showItem(index);
            this.stopAutoPlay();
            this.startAutoPlay();
        }
    }

    startAutoPlay() {
        this.stopAutoPlay();
        this.autoPlayInterval = setInterval(() => {
            this.next();
        }, this.autoPlayDelay);
    }

    stopAutoPlay() {
        if (this.autoPlayInterval) {
            clearInterval(this.autoPlayInterval);
            this.autoPlayInterval = null;
        }
    }

    addSwipeSupport() {
        let startX = 0;
        let endX = 0;

        this.carousel.addEventListener('touchstart', (e) => {
            startX = e.touches[0].clientX;
        });

        this.carousel.addEventListener('touchmove', (e) => {
            endX = e.touches[0].clientX;
        });

        this.carousel.addEventListener('touchend', () => {
            const diff = startX - endX;
            const threshold = 50; // minimum swipe distance

            if (Math.abs(diff) > threshold) {
                if (diff > 0) {
                    // Swiped left
                    this.next();
                } else {
                    // Swiped right
                    this.prev();
                }
            }
        });
    }
}

// Initialize all carousels on page load
document.addEventListener('DOMContentLoaded', () => {
    const carousels = document.querySelectorAll('.carousel');
    carousels.forEach(carousel => {
        new Carousel(carousel);
    });
});
