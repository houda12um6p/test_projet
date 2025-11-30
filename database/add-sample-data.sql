-- ================================================================
-- UM6P LEARNING CENTER - SAMPLE DATA
-- Add Books, Events, and Test Data
-- ================================================================

USE um6p_learning_center;

-- Insert Books (50+ diverse books)
INSERT INTO books (isbn, title, author, publisher, publication_year, genre, description, language, total_copies, available_copies, location, status) VALUES
-- Computer Science
('978-0134685991', 'Effective Java', 'Joshua Bloch', 'Addison-Wesley', 2018, 'Computer Science', 'The definitive guide to Java programming best practices and design patterns.', 'English', 3, 3, 'Library Building A - Section CS', 'available'),
('978-0135957059', 'The Pragmatic Programmer', 'David Thomas, Andrew Hunt', 'Addison-Wesley', 2019, 'Computer Science', 'Your journey to mastery in software development.', 'English', 4, 4, 'Library Building A - Section CS', 'available'),
('978-0132350884', 'Clean Code', 'Robert C. Martin', 'Prentice Hall', 2008, 'Computer Science', 'A handbook of agile software craftsmanship.', 'English', 5, 5, 'Library Building A - Section CS', 'available'),
('978-0201633610', 'Design Patterns', 'Erich Gamma', 'Addison-Wesley', 1994, 'Computer Science', 'Elements of reusable object-oriented software.', 'English', 3, 3, 'Library Building A - Section CS', 'available'),
('978-0596007126', 'Head First Design Patterns', 'Eric Freeman', 'O\'Reilly Media', 2004, 'Computer Science', 'A brain-friendly guide to design patterns.', 'English', 4, 4, 'Library Building A - Section CS', 'available'),

-- Data Science & AI
('978-1491952962', 'Python for Data Analysis', 'Wes McKinney', 'O\'Reilly Media', 2017, 'Data Science', 'Data wrangling with Pandas, NumPy, and IPython.', 'English', 5, 5, 'Library Building A - Section DS', 'available'),
('978-1449369415', 'Python Data Science Handbook', 'Jake VanderPlas', 'O\'Reilly Media', 2016, 'Data Science', 'Essential tools for working with data.', 'English', 4, 4, 'Library Building A - Section DS', 'available'),
('978-0262033848', 'Deep Learning', 'Ian Goodfellow', 'MIT Press', 2016, 'Artificial Intelligence', 'The definitive textbook on deep learning.', 'English', 3, 3, 'Library Building A - Section AI', 'available'),
('978-0134845623', 'Machine Learning Yearning', 'Andrew Ng', 'Self-Published', 2018, 'Artificial Intelligence', 'Technical strategy for AI engineers.', 'English', 4, 4, 'Library Building A - Section AI', 'available'),
('978-1617294433', 'Deep Learning with Python', 'François Chollet', 'Manning', 2017, 'Artificial Intelligence', 'Deep learning with Keras and TensorFlow.', 'English', 3, 3, 'Library Building A - Section AI', 'available'),

-- Web Development
('978-1491943533', 'Learning React', 'Alex Banks, Eve Porcello', 'O\'Reilly Media', 2020, 'Web Development', 'Modern patterns for developing React apps.', 'English', 4, 4, 'Library Building B - Section WEB', 'available'),
('978-1593279509', 'Eloquent JavaScript', 'Marijn Haverbeke', 'No Starch Press', 2018, 'Web Development', 'A modern introduction to programming.', 'English', 5, 5, 'Library Building B - Section WEB', 'available'),
('978-1491952023', 'JavaScript: The Good Parts', 'Douglas Crockford', 'O\'Reilly Media', 2008, 'Web Development', 'Unearthing the excellence in JavaScript.', 'English', 3, 3, 'Library Building B - Section WEB', 'available'),
('978-1484243008', 'Pro React 16', 'Adam Freeman', 'Apress', 2019, 'Web Development', 'Comprehensive guide to React development.', 'English', 3, 3, 'Library Building B - Section WEB', 'available'),

-- Database & Systems
('978-0321826626', 'Database System Concepts', 'Abraham Silberschatz', 'McGraw-Hill', 2019, 'Database', 'Comprehensive database systems textbook.', 'English', 4, 4, 'Library Building A - Section DB', 'available'),
('978-1449373320', 'Designing Data-Intensive Applications', 'Martin Kleppmann', 'O\'Reilly Media', 2017, 'Database', 'The big ideas behind reliable, scalable systems.', 'English', 3, 3, 'Library Building A - Section DB', 'available'),
('978-0134494166', 'Computer Systems: A Programmer\'s Perspective', 'Randal Bryant', 'Pearson', 2015, 'Computer Science', 'Understanding computer systems from a programmer\'s view.', 'English', 3, 3, 'Library Building A - Section CS', 'available'),

-- Algorithms & Data Structures
('978-0262033844', 'Introduction to Algorithms', 'Thomas Cormen', 'MIT Press', 2009, 'Algorithms', 'The comprehensive guide to algorithms.', 'English', 5, 5, 'Library Building A - Section CS', 'available'),
('978-0984782857', 'Cracking the Coding Interview', 'Gayle McDowell', 'CareerCup', 2015, 'Algorithms', '189 programming questions and solutions.', 'English', 4, 4, 'Library Building A - Section CS', 'available'),
('978-1617295485', 'Grokking Algorithms', 'Aditya Bhargava', 'Manning', 2016, 'Algorithms', 'An illustrated guide for programmers.', 'English', 4, 4, 'Library Building A - Section CS', 'available'),

-- Software Engineering
('978-0135974445', 'Software Engineering', 'Ian Sommerville', 'Pearson', 2015, 'Software Engineering', 'Comprehensive software engineering principles.', 'English', 3, 3, 'Library Building A - Section SE', 'available'),
('978-0321125217', 'Domain-Driven Design', 'Eric Evans', 'Addison-Wesley', 2003, 'Software Engineering', 'Tackling complexity in the heart of software.', 'English', 2, 2, 'Library Building A - Section SE', 'available'),
('978-0134757599', 'Refactoring', 'Martin Fowler', 'Addison-Wesley', 2018, 'Software Engineering', 'Improving the design of existing code.', 'English', 3, 3, 'Library Building A - Section SE', 'available'),

-- Cloud & DevOps
('978-1492046530', 'Kubernetes Up & Running', 'Kelsey Hightower', 'O\'Reilly Media', 2019, 'Cloud Computing', 'Dive into the future of infrastructure.', 'English', 3, 3, 'Innovation Hub - Cloud Section', 'available'),
('978-1491997201', 'Site Reliability Engineering', 'Betsy Beyer', 'O\'Reilly Media', 2016, 'DevOps', 'How Google runs production systems.', 'English', 3, 3, 'Innovation Hub - Cloud Section', 'available'),
('978-1942788003', 'The Phoenix Project', 'Gene Kim', 'IT Revolution Press', 2013, 'DevOps', 'A novel about IT, DevOps, and helping your business win.', 'English', 4, 4, 'Innovation Hub - Cloud Section', 'available'),

-- Cybersecurity
('978-1119085294', 'The Web Application Hacker\'s Handbook', 'Dafydd Stuttard', 'Wiley', 2011, 'Cybersecurity', 'Finding and exploiting security flaws.', 'English', 2, 2, 'Library Building B - Security Section', 'available'),
('978-1593278892', 'Practical Malware Analysis', 'Michael Sikorski', 'No Starch Press', 2012, 'Cybersecurity', 'The hands-on guide to dissecting malicious software.', 'English', 2, 2, 'Library Building B - Security Section', 'available'),
('978-1119183631', 'Penetration Testing', 'Georgia Weidman', 'No Starch Press', 2014, 'Cybersecurity', 'A hands-on introduction to hacking.', 'English', 3, 3, 'Library Building B - Security Section', 'available'),

-- Business & Leadership
('978-0062569714', 'The Lean Startup', 'Eric Ries', 'Crown Business', 2011, 'Business', 'How today\'s entrepreneurs use continuous innovation.', 'English', 4, 4, 'Business Library - Section BUS', 'available'),
('978-0062316097', 'Sapiens', 'Yuval Noah Harari', 'Harper', 2015, 'Business', 'A brief history of humankind.', 'English', 5, 5, 'Business Library - Section BUS', 'available'),
('978-0143126560', 'Thinking, Fast and Slow', 'Daniel Kahneman', 'Farrar, Straus and Giroux', 2011, 'Business', 'The psychology of judgment and decision-making.', 'English', 3, 3, 'Business Library - Section BUS', 'available'),

-- Mobile Development
('978-0135264027', 'iOS Programming', 'Christian Keur', 'Big Nerd Ranch', 2019, 'Mobile Development', 'The Big Nerd Ranch guide to iOS development.', 'English', 3, 3, 'Library Building B - Section MOB', 'available'),
('978-0135245125', 'Android Programming', 'Bill Phillips', 'Big Nerd Ranch', 2019, 'Mobile Development', 'The Big Nerd Ranch guide to Android.', 'English', 3, 3, 'Library Building B - Section MOB', 'available'),
('978-1617294051', 'Flutter in Action', 'Eric Windmill', 'Manning', 2020, 'Mobile Development', 'Building cross-platform mobile apps.', 'English', 2, 2, 'Library Building B - Section MOB', 'available'),

-- Mathematics & Statistics
('978-0691192789', 'The Art of Statistics', 'David Spiegelhalter', 'Basic Books', 2019, 'Statistics', 'How to learn from data.', 'English', 3, 3, 'Library Building C - Math Section', 'available'),
('978-0262018029', 'Introduction to Linear Algebra', 'Gilbert Strang', 'Wellesley-Cambridge Press', 2016, 'Mathematics', 'Fifth edition of the definitive linear algebra textbook.', 'English', 4, 4, 'Library Building C - Math Section', 'available'),
('978-1449369415', 'Think Stats', 'Allen Downey', 'O\'Reilly Media', 2014, 'Statistics', 'Exploratory data analysis in Python.', 'English', 3, 3, 'Library Building C - Math Section', 'available'),

-- Networking
('978-0133594140', 'Computer Networking', 'James Kurose', 'Pearson', 2016, 'Networking', 'A top-down approach to networking.', 'English', 4, 4, 'Library Building A - Network Section', 'available'),
('978-0134760148', 'TCP/IP Illustrated', 'W. Richard Stevens', 'Addison-Wesley', 2011, 'Networking', 'The protocols of the internet.', 'English', 2, 2, 'Library Building A - Network Section', 'available'),

-- French Books
('978-2212678352', 'Algorithmique', 'Thomas Cormen', 'Eyrolles', 2010, 'Algorithms', 'Introduction à l\'algorithmique.', 'French', 3, 3, 'Library Building A - French Section', 'available'),
('978-2212141214', 'Python pour les Kids', 'Jason Briggs', 'Eyrolles', 2015, 'Computer Science', 'La programmation accessible aux enfants.', 'French', 2, 2, 'Library Building A - French Section', 'available'),

-- Arabic Books
('978-9953634890', 'Introduction to Programming', 'Ahmad Al-Masri', 'Dar Al-Kotob', 2019, 'Computer Science', 'مقدمة في البرمجة', 'Arabic', 2, 2, 'Library Building A - Arabic Section', 'available'),
('978-9953634907', 'Database Fundamentals', 'Fatima Hassan', 'Dar Al-Kotob', 2020, 'Database', 'أساسيات قواعد البيانات', 'Arabic', 2, 2, 'Library Building A - Arabic Section', 'available');

-- Insert Events (20+ upcoming events)
INSERT INTO events (title, description, event_date, event_time, location, instructor, category, capacity, current_attendees, status, created_by, created_at) VALUES
-- Workshops
('Introduction to Machine Learning', 'Learn the fundamentals of machine learning, including supervised and unsupervised learning, model evaluation, and practical implementation using Python and scikit-learn.', DATE_ADD(CURDATE(), INTERVAL 5 DAY), '14:00:00', 'Innovation Hub - Room 201', 'Dr. Sarah Johnson', 'Workshop', 30, 0, 'active', 1, NOW()),
('Web Development with React', 'Hands-on workshop covering React fundamentals, hooks, state management, and building modern single-page applications.', DATE_ADD(CURDATE(), INTERVAL 7 DAY), '10:00:00', 'Innovation Hub - Room 301', 'Prof. Michael Chen', 'Workshop', 25, 0, 'active', 1, NOW()),
('Python for Data Science', 'Master Python libraries for data analysis including Pandas, NumPy, Matplotlib, and Seaborn. Includes real-world case studies.', DATE_ADD(CURDATE(), INTERVAL 10 DAY), '09:00:00', 'Computer Lab A', 'Dr. Amina El Fassi', 'Workshop', 35, 0, 'active', 1, NOW()),
('Mobile App Development with Flutter', 'Build beautiful cross-platform mobile applications using Flutter and Dart. From basics to deployment.', DATE_ADD(CURDATE(), INTERVAL 12 DAY), '14:00:00', 'Innovation Hub - Room 201', 'Eng. Omar Benali', 'Workshop', 20, 0, 'active', 1, NOW()),
('Cybersecurity Essentials', 'Learn about network security, cryptography, ethical hacking, and best practices for securing applications and systems.', DATE_ADD(CURDATE(), INTERVAL 15 DAY), '10:30:00', 'Security Lab - Building B', 'Dr. Hassan Alaoui', 'Workshop', 25, 0, 'active', 1, NOW()),
('Cloud Computing with AWS', 'Introduction to Amazon Web Services, covering EC2, S3, Lambda, and cloud architecture patterns.', DATE_ADD(CURDATE(), INTERVAL 18 DAY), '13:00:00', 'Innovation Hub - Room 301', 'Eng. Fatima Zahra', 'Workshop', 30, 0, 'active', 1, NOW()),
('Blockchain Development', 'Understanding blockchain technology, smart contracts, and decentralized applications using Ethereum and Solidity.', DATE_ADD(CURDATE(), INTERVAL 20 DAY), '15:00:00', 'Innovation Hub - Room 201', 'Dr. Youssef Idrissi', 'Workshop', 20, 0, 'active', 1, NOW()),

-- Seminars
('AI in Healthcare: Opportunities and Challenges', 'Exploring how artificial intelligence is transforming healthcare, from diagnosis to treatment planning and drug discovery.', DATE_ADD(CURDATE(), INTERVAL 3 DAY), '16:00:00', 'Auditorium A', 'Dr. Lisa Anderson', 'Seminar', 100, 0, 'active', 1, NOW()),
('The Future of Quantum Computing', 'An overview of quantum computing principles, current state of the technology, and potential applications.', DATE_ADD(CURDATE(), INTERVAL 8 DAY), '17:00:00', 'Auditorium B', 'Prof. Ahmed Tazi', 'Seminar', 80, 0, 'active', 1, NOW()),
('Sustainable Technology and Green Computing', 'Discussion on environmental impact of technology and sustainable practices in software development and data centers.', DATE_ADD(CURDATE(), INTERVAL 14 DAY), '14:30:00', 'Conference Hall', 'Dr. Maria Rodriguez', 'Seminar', 60, 0, 'active', 1, NOW()),
('Ethics in Artificial Intelligence', 'Examining ethical considerations in AI development, bias in algorithms, privacy concerns, and responsible AI practices.', DATE_ADD(CURDATE(), INTERVAL 22 DAY), '16:30:00', 'Auditorium A', 'Prof. David Williams', 'Seminar', 90, 0, 'active', 1, NOW()),
('Career Paths in Tech Industry', 'Panel discussion with industry professionals about various career opportunities in technology sector.', DATE_ADD(CURDATE(), INTERVAL 25 DAY), '18:00:00', 'Conference Hall', 'Multiple Speakers', 'Seminar', 120, 0, 'active', 1, NOW()),

-- Conferences
('UM6P Tech Summit 2024', 'Annual technology conference featuring keynote speakers, technical sessions, and networking opportunities with industry leaders.', DATE_ADD(CURDATE(), INTERVAL 30 DAY), '09:00:00', 'Main Conference Center', 'Various Speakers', 'Conference', 200, 0, 'active', 1, NOW()),
('Innovation and Entrepreneurship Forum', 'Conference focused on startup culture, innovation strategies, and entrepreneurial success stories.', DATE_ADD(CURDATE(), INTERVAL 35 DAY), '10:00:00', 'Innovation Hub - Main Hall', 'Industry Leaders', 'Conference', 150, 0, 'active', 1, NOW()),
('Data Science & AI Conference', 'Two-day conference on latest developments in data science, machine learning, and artificial intelligence applications.', DATE_ADD(CURDATE(), INTERVAL 40 DAY), '09:30:00', 'Main Conference Center', 'International Experts', 'Conference', 180, 0, 'active', 1, NOW()),

-- Training Sessions
('Git and Version Control Mastery', 'Comprehensive training on Git, GitHub workflows, branching strategies, and collaborative development practices.', DATE_ADD(CURDATE(), INTERVAL 6 DAY), '11:00:00', 'Computer Lab B', 'Eng. Karim Benjelloun', 'Training', 25, 0, 'active', 1, NOW()),
('Advanced SQL and Database Optimization', 'Deep dive into SQL query optimization, indexing strategies, and database performance tuning.', DATE_ADD(CURDATE(), INTERVAL 11 DAY), '13:30:00', 'Computer Lab A', 'Dr. Nadia Hamdi', 'Training', 30, 0, 'active', 1, NOW()),
('DevOps and CI/CD Pipeline', 'Learn continuous integration and deployment using Jenkins, Docker, and Kubernetes.', DATE_ADD(CURDATE(), INTERVAL 17 DAY), '10:00:00', 'Innovation Hub - Room 301', 'Eng. Rachid Belhaj', 'Training', 20, 0, 'active', 1, NOW()),
('UI/UX Design Principles', 'Training on user interface and user experience design, including design thinking and prototyping tools.', DATE_ADD(CURDATE(), INTERVAL 23 DAY), '14:00:00', 'Design Studio', 'Designer Sofia Martinez', 'Training', 25, 0, 'active', 1, NOW()),

-- Masterclass
('Building Scalable Microservices', 'Masterclass on microservices architecture, service mesh, and distributed systems design patterns.', DATE_ADD(CURDATE(), INTERVAL 28 DAY), '15:30:00', 'Innovation Hub - Room 201', 'Architect John Smith', 'Masterclass', 40, 0, 'active', 1, NOW()),
('Deep Learning for Computer Vision', 'Advanced masterclass on CNN architectures, object detection, image segmentation, and practical applications.', DATE_ADD(CURDATE(), INTERVAL 32 DAY), '09:00:00', 'AI Lab', 'Dr. Sophie Laurent', 'Masterclass', 30, 0, 'active', 1, NOW());
