-- Insert 10 users
INSERT INTO users (name, user_name, email, password_hashed, bio, birthday) 
VALUES 
('John Doe', 'john_doe', 'john@example.com', 'hashed_password', 'Student at XYZ University', '1995-05-15'),
('Jane Smith', 'jane_smith', 'jane@example.com', 'hashed_password', 'Aspiring teacher', '1990-12-03'),
('Alice Johnson', 'alice_j', 'alice@example.com', 'hashed_password', 'Professional programmer', '1988-08-20'),
('Bob Brown', 'bob_brown', 'bob@example.com', 'hashed_password', 'Enthusiastic learner', '1998-02-28'),
('Emily Davis', 'emily_davis', 'emily@example.com', 'hashed_password', 'Math lover', '1993-09-10'),
('Michael Wilson', 'michael_wilson', 'michael@example.com', 'hashed_password', 'English enthusiast', '1985-07-25'),
('Sarah Lee', 'sarah_lee', 'sarah@example.com', 'hashed_password', 'Lifelong learner', '1989-04-17'),
('David Martinez', 'david_martinez', 'david@example.com', 'hashed_password', 'Science enthusiast', '1996-11-22'),
('Jessica Taylor', 'jessica_taylor', 'jessica@example.com', 'hashed_password', 'Art lover', '1991-06-03'),
('Andrew Anderson', 'andrew_anderson', 'andrew@example.com', 'hashed_password', 'Passionate educator', '1983-03-12');

-- Insert 5 students
INSERT INTO students (user_id, grade) 
VALUES 
(1, 10),
(4, 11),
(5, 9),
(8, 10),
(9, 11);

-- Insert 5 teachers
INSERT INTO teachers (user_id, description) 
VALUES 
(2, 'Passionate about mathematics and physics'),
(3, 'Experienced language teacher'),
(6, 'Software engineer with a passion for teaching coding'),
(7, 'Experienced in teaching literature'),
(10, 'History enthusiast');

INSERT INTO courses (name) VALUES
('Introduction to Python Programming'),
('Data Science Fundamentals'),
('Web Development with JavaScript'),
('Machine Learning Basics'),
('Graphic Design Essentials'),
('Digital Marketing Strategies'),
('Financial Planning and Analysis'),
('English Literature: A Journey Through Time'),
('History of Ancient Civilizations'),
('Introduction to Psychology');

-- Assign courses to students
INSERT INTO enrollments (student_id, course_id, rating, review) 
VALUES 
(1, 1, 4, 'Great course, learned a lot!'),
(1, 2, 5, 'Excellent teacher, very engaging!'),
(4, 3, 4, 'Great course, learned a lot!'),
(4, 4, 5, 'Excellent teacher, very engaging!'),
(5, 5, 3, 'Content was good but pacing could be improved'),
(5, 6, 4, 'Great course, learned a lot!'),
(2, 7, 4, 'Great course, learned a lot!'),
(2, 8, 5, 'Excellent teacher, very engaging!'),
(3, 9, 3, 'Content was good but pacing could be improved'),
(3, 10, 4, 'Great course, learned a lot!');

-- Assign courses to teachers
INSERT INTO teachingAllocations (teacher_id, course_id) 
VALUES 
(2, 1),
(2, 2),
(3, 3),
(3, 4),
(1, 5),
(1, 6),
(4, 7),
(4, 8),
(5, 9),
(5, 10);

-- CREATE SESSIONS FOR COURSES

-- Course 1: Introduction to Python Programming
INSERT INTO sessions (course_id, name, `order`, video, summary, transcript) 
VALUES 
(1, 'Python Basics', 1, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(1, 'Control Flow and Loops', 2, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(1, 'Functions and Modules', 3, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(1, 'Data Structures', 4, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(1, 'File Handling', 5, 'video_blob_here', 'Summary of the session', 'Transcript of the session');

-- Course 2: Data Science Fundamentals
INSERT INTO sessions (course_id, name, `order`, video, summary, transcript) 
VALUES 
(2, 'Introduction to Data Science', 1, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(2, 'Data Analysis with Python', 2, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(2, 'Data Visualization', 3, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(2, 'Machine Learning Basics', 4, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(2, 'Big Data Analytics', 5, 'video_blob_here', 'Summary of the session', 'Transcript of the session');

-- Course 3: Web Development with JavaScript
INSERT INTO sessions (course_id, name, `order`, video, summary, transcript) 
VALUES 
(3, 'Introduction to Web Development', 1, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(3, 'HTML and CSS Basics', 2, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(3, 'JavaScript Fundamentals', 3, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(3, 'DOM Manipulation', 4, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(3, 'AJAX and APIs', 5, 'video_blob_here', 'Summary of the session', 'Transcript of the session');

-- Course 4: Machine Learning Basics
INSERT INTO sessions (course_id, name, `order`, video, summary, transcript) 
VALUES 
(4, 'Introduction to Machine Learning', 1, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(4, 'Regression Analysis', 2, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(4, 'Classification Algorithms', 3, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(4, 'Clustering Techniques', 4, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(4, 'Neural Networks', 5, 'video_blob_here', 'Summary of the session', 'Transcript of the session');

-- Course 5: Graphic Design Essentials
INSERT INTO sessions (course_id, name, `order`, video, summary, transcript) 
VALUES 
(5, 'Introduction to Graphic Design', 1, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(5, 'Typography Basics', 2, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(5, 'Color Theory', 3, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(5, 'Layout and Composition', 4, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(5, 'Logo Design Principles', 5, 'video_blob_here', 'Summary of the session', 'Transcript of the session');

-- Course 6: Digital Marketing Strategies
INSERT INTO sessions (course_id, name, `order`, video, summary, transcript) 
VALUES 
(6, 'Introduction to Digital Marketing', 1, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(6, 'Content Marketing', 2, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(6, 'Social Media Marketing', 3, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(6, 'Search Engine Optimization', 4, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(6, 'Email Marketing Strategies', 5, 'video_blob_here', 'Summary of the session', 'Transcript of the session');

-- Course 7: Financial Planning and Analysis
INSERT INTO sessions (course_id, name, `order`, video, summary, transcript) 
VALUES 
(7, 'Introduction to Financial Planning', 1, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(7, 'Budgeting and Forecasting', 2, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(7, 'Financial Statement Analysis', 3, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(7, 'Investment Strategies', 4, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(7, 'Risk Management', 5, 'video_blob_here', 'Summary of the session', 'Transcript of the session');

-- Course 8: English Literature: A Journey Through Time
INSERT INTO sessions (course_id, name, `order`, video, summary, transcript) 
VALUES 
(8, 'Introduction to English Literature', 1, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(8, 'Shakespearean Literature', 2, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(8, 'Romantic Poetry', 3, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(8, 'Modernist Literature', 4, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(8, 'Contemporary Fiction', 5, 'video_blob_here', 'Summary of the session', 'Transcript of the session');

-- Course 9: History of Ancient Civilizations
INSERT INTO sessions (course_id, name, `order`, video, summary, transcript) 
VALUES 
(9, 'Introduction to Ancient Civilizations', 1, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(9, 'Mesopotamian Civilization', 2, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(9, 'Ancient Egyptian Civilization', 3, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(9, 'Ancient Greek Civilization', 4, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(9, 'Ancient Roman Civilization', 5, 'video_blob_here', 'Summary of the session', 'Transcript of the session');

-- Course 10: Introduction to Psychology
INSERT INTO sessions (course_id, name, `order`, video, summary, transcript) 
VALUES 
(10, 'Introduction to Psychology', 1, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(10, 'Biological Psychology', 2, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(10, 'Cognitive Psychology', 3, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(10, 'Social Psychology', 4, 'video_blob_here', 'Summary of the session', 'Transcript of the session'),
(10, 'Developmental Psychology', 5, 'video_blob_here', 'Summary of the session', 'Transcript of the session');

-- CREATE COMMENTS FOR SESSIONS
-- Comments for sessions of Course 1: Introduction to Python Programming
-- Session 1: Python Basics
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(1, 1, 'This session was very informative!', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 1, 'I had some trouble understanding the concept of loops.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 1, 'Could you provide more examples of string manipulation?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 2: Control Flow and Loops
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(4, 2, 'The explanation of conditional statements was clear.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 2, 'I struggled with understanding nested loops.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 2, 'Can you explain how to use break and continue statements?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 3: Functions and Modules
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(7, 3, 'I found the explanation of functions very helpful.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 3, 'How do I import modules from external files?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 3, 'Could you provide more examples of lambda functions?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 4: Data Structures
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(10, 4, 'The explanation of lists and dictionaries was great!', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 4, 'I''m having trouble understanding tuples.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 4, 'How do I manipulate sets in Python?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 5: File Handling
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(3, 5, 'The explanation of file modes was very clear.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 5, 'I''m struggling with file reading and writing.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 5, 'Could you provide more examples of file manipulation?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Comments for sessions of Course 2: Data Science Fundamentals
-- Session 1: Introduction to Data Science
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(6, 6, 'This session provided a good overview of data science concepts.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 6, 'I found the explanation of data preprocessing very useful.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 6, 'Can you recommend any resources for further learning?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 2: Data Analysis with Python
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(9, 7, 'The examples provided helped me understand data analysis better.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 7, 'I''m having trouble with pandas dataframes.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 7, 'Could you explain more about data visualization libraries?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 3: Data Visualization
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(2, 8, 'The session on data visualization was informative.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 8, 'I''m struggling to choose the right visualization for my data.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 8, 'How do I customize plots in matplotlib?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 4: Machine Learning Basics
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(5, 9, 'The introduction to machine learning was well-paced.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 9, 'I need more practice with scikit-learn.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 9, 'Can you recommend any beginner-friendly machine learning projects?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 5: Big Data Analytics
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(8, 10, 'The session on big data analytics was insightful.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 10, 'I''m interested in learning more about Hadoop and Spark.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 10, 'Could you provide examples of big data projects?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Comments for sessions of Course 3: Web Development with JavaScript
-- Session 1: Introduction to Web Development
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(1, 11, 'The session provided a good introduction to web development concepts.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 11, 'I found the explanation of HTML tags very clear.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 11, 'Can you recommend any resources for learning CSS?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 2: HTML and CSS Basics
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(4, 12, 'I''m having trouble understanding CSS selectors.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 12, 'The explanation of CSS layout techniques was helpful.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 12, 'Could you explain more about CSS Flexbox?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 3: JavaScript Fundamentals
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(6, 13, 'The session on JavaScript basics was informative.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 13, 'I''m having difficulty understanding functions in JavaScript.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 13, 'Can you provide more examples of JavaScript events?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 4: DOM Manipulation
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(9, 14, 'The explanation of DOM manipulation techniques was clear.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 14, 'I need more practice with DOM traversal.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 14, 'Could you explain how to handle events in the DOM?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 5: AJAX and APIs
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(2, 15, 'The session on AJAX and APIs provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 15, 'I''m interested in learning more about RESTful APIs.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 15, 'Could you provide examples of using AJAX with different APIs?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Comments for sessions of Course 4: Machine Learning Basics
-- Session 1: Introduction to Machine Learning
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(5, 16, 'The session provided a good overview of machine learning concepts.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 16, 'I found the explanation of supervised learning very clear.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 16, 'Can you recommend any beginner-friendly machine learning datasets?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 2: Regression Analysis
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(8, 17, 'The explanation of linear regression was helpful.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 17, 'I''m having difficulty understanding polynomial regression.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 17, 'Could you provide examples of real-world regression problems?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 3: Classification Algorithms
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(1, 18, 'The session on classification algorithms was informative.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 18, 'I''m struggling with understanding decision trees.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 18, 'Can you explain more about ensemble methods?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 4: Clustering Techniques
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(4, 19, 'The explanation of k-means clustering was clear.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 19, 'I need more practice with hierarchical clustering.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 19, 'Could you provide examples of clustering applications?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 5: Neural Networks
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(7, 20, 'The session on neural networks provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 20, 'I''m interested in learning more about deep learning.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 20, 'Could you recommend any beginner-friendly neural network libraries?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Comments for sessions of Course 5: Graphic Design Essentials
-- Session 1: Introduction to Graphic Design
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(10, 21, 'The session provided a good overview of graphic design principles.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 21, 'I found the explanation of design elements very clear.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 21, 'Can you recommend any resources for learning design software?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 2: Typography Basics
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(3, 22, 'I''m struggling to understand different font types.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 22, 'The session on typography was informative.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 22, 'Could you provide examples of typography in branding?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 3: Color Theory
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(6, 23, 'The explanation of color theory was helpful.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 23, 'I''m having difficulty understanding complementary colors.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 23, 'Can you recommend any resources for learning color psychology?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 4: Layout and Composition
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(9, 24, 'The session on layout and composition provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 24, 'I''m interested in learning more about grid systems.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 24, 'Could you provide examples of effective layouts?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 5: Logo Design Principles
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(2, 25, 'The session on logo design was informative.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 25, 'I need more practice with vector graphics software.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 25, 'Can you recommend any beginner-friendly logo design projects?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Comments for sessions of Course 6: Digital Marketing Strategies
-- Session 1: Introduction to Digital Marketing
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(5, 26, 'The session provided a good overview of digital marketing concepts.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 26, 'I found the explanation of online advertising very clear.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 26, 'Can you recommend any resources for learning SEO?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 2: Content Marketing
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(8, 27, 'The explanation of content marketing strategies was helpful.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 27, 'I''m struggling with creating engaging content.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 27, 'Could you provide examples of successful content marketing campaigns?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 3: Social Media Marketing
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(1, 28, 'The session on social media marketing provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 28, 'I''m interested in learning more about influencer marketing.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 28, 'Can you recommend any tools for social media analytics?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 4: Search Engine Optimization
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(4, 29, 'The explanation of SEO techniques was clear.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 29, 'I need more practice with keyword research.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 29, 'Could you provide examples of on-page SEO optimization?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 5: Email Marketing Strategies
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(7, 30, 'The session on email marketing provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 30, 'I''m interested in learning more about email automation.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 30, 'Can you recommend any best practices for email campaign optimization?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);


-- Comments for sessions of Course 7: Financial Planning and Analysis
-- Session 1: Introduction to Financial Planning
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(10, 31, 'The session provided a good overview of financial planning concepts.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 31, 'I found the explanation of budgeting very clear.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 31, 'Can you recommend any resources for learning investment strategies?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 2: Budgeting and Forecasting
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(3, 32, 'The explanation of budgeting techniques was helpful.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 32, 'I''m struggling with financial forecasting methods.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 32, 'Could you provide examples of budgeting in personal finance?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 3: Financial Statement Analysis
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(6, 33, 'The session on financial statement analysis provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 33, 'I''m interested in learning more about ratio analysis.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 33, 'Can you recommend any tools for financial data visualization?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 4: Investment Strategies
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(9, 34, 'The explanation of investment strategies was clear.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 34, 'I need more practice with portfolio management.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 34, 'Could you provide examples of risk management in investments?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 5: Retirement Planning
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(2, 35, 'The session on retirement planning provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 35, 'I''m interested in learning more about tax-efficient retirement strategies.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 35, 'Can you recommend any resources for retirement income planning?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Comments for sessions of Course 8: English Literature: A Journey Through Time
-- Session 1: The Renaissance Period
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(5, 36, 'The session provided a good overview of literature during the Renaissance.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 36, 'I found the explanation of Shakespearean works very clear.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 36, 'Can you recommend any resources for understanding Renaissance poetry?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 2: Romanticism
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(8, 37, 'The explanation of Romantic literature was helpful.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 37, 'I''m struggling with understanding the themes of Romantic poetry.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 37, 'Could you provide examples of Romantic novels?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 3: Victorian Literature
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(1, 38, 'The session on Victorian literature provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 38, 'I''m interested in learning more about the works of Charles Dickens.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 38, 'Can you recommend any resources for understanding Victorian novels?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 4: Modernist Movement
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(4, 39, 'The explanation of modernist literature was clear.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 39, 'I need more practice with analyzing modernist poetry.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 39, 'Could you provide examples of modernist short stories?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 5: Contemporary Literature
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(7, 40, 'The session on contemporary literature provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 40, 'I''m interested in learning more about contemporary authors.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 40, 'Can you recommend any recent works of fiction?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Comments for sessions of Course 9: History of Ancient Civilizations
-- Session 1: Mesopotamia
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(2, 41, 'The session provided a good overview of ancient Mesopotamian civilization.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 41, 'I found the explanation of Sumerian culture very clear.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 41, 'Can you recommend any resources for understanding Mesopotamian art?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 2: Ancient Egypt
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(5, 42, 'The explanation of ancient Egyptian history was helpful.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 42, 'I''m struggling with understanding the religious beliefs of ancient Egyptians.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 42, 'Could you provide examples of Egyptian hieroglyphics?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 3: Ancient Greece
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(8, 43, 'The session on ancient Greek civilization provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 43, 'I''m interested in learning more about Greek mythology.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 43, 'Can you recommend any resources for understanding ancient Greek philosophy?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 4: Ancient Rome
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(1, 44, 'The explanation of ancient Roman history was clear.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 44, 'I need more practice with analyzing Roman architecture.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 44, 'Could you provide examples of Roman literature?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 5: Ancient China
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(4, 45, 'The session on ancient Chinese civilization provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 45, 'I''m interested in learning more about the Great Wall of China.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 45, 'Can you recommend any resources for understanding Chinese dynasties?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Comments for sessions of Course 10: Introduction to Psychology
-- Session 1: History and Perspectives of Psychology
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(7, 46, 'The session provided a good overview of the history of psychology.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 46, 'I found the explanation of different psychological perspectives very clear.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 46, 'Can you recommend any resources for understanding the evolution of psychology?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 2: Research Methods in Psychology
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(10, 47, 'The explanation of research methods was helpful.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 47, 'I''m struggling with understanding experimental design.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 47, 'Could you provide examples of psychological research studies?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 3: Biological Bases of Behavior
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(3, 48, 'The session on biological bases of behavior provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 48, 'I''m interested in learning more about the structure of the brain.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 48, 'Can you recommend any resources for understanding neurotransmitters?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 4: Sensation and Perception
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(6, 49, 'The explanation of sensation and perception was clear.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 49, 'I need more practice with understanding sensory processing.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 49, 'Could you provide examples of perceptual illusions?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Session 5: Learning and Memory
INSERT INTO comments (created_by, session_id, content, time_created) 
VALUES 
(9, 50, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 50, 'I''m interested in learning more about long-term memory.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 50, 'Can you recommend any resources for improving memory retention?', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Insert likes
INSERT INTO likes (created_by, comment_id, time_created)
VALUES 
(1, 1, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 1, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 2, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 2, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 3, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 3, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 4, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 4, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 5, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 5, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 6, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 6, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 7, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 7, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 8, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 8, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 9, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 9, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 10, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 10, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 11, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 11, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 12, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 12, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 13, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 13, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 14, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 14, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 15, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 15, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 16, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 16, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 17, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 17, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 18, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 18, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 19, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 19, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 20, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 20, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 21, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 21, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 22, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 22, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 23, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 23, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 24, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 24, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 25, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 25, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 26, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 26, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 27, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 27, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 28, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 28, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 29, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 29, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 30, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 30, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 31, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 31, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 32, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 32, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 33, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 33, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 34, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 34, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 35, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 35, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 36, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 36, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 37, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 37, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 38, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 38, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 39, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 39, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 40, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 40, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 41, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 41, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 42, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 42, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 43, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 43, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 44, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 44, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 45, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 45, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 46, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 46, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 47, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 47, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 48, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 48, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 49, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 49, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 50, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 50, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 51, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 51, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 52, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 52, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 53, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 53, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 54, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 54, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 55, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 55, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 56, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 56, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 57, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 57, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 58, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 58, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 59, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 59, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 60, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 60, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 61, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 61, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 62, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 62, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 63, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 63, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 64, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 64, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 65, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 65, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 66, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 66, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 67, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 67, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 68, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 68, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 69, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 69, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 70, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 70, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 71, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 71, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 72, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 72, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 73, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 73, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 74, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 74, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 75, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 75, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 76, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 76, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 77, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 77, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 78, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 78, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 79, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 79, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 80, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 80, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 81, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 81, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 82, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 82, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 83, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 83, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 84, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 84, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 85, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 85, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 86, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 86, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 87, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 87, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 88, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 88, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 89, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 89, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 90, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 90, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 91, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 91, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 92, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 92, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 93, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 93, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 94, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 94, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 95, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 95, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 96, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 96, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 97, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 97, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 98, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 98, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 99, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 99, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 100, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 100, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 101, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 101, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 102, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 102, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 103, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 103, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 104, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 104, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 105, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 105, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 106, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 106, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 107, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 107, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 108, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 108, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 109, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 109, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 110, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 110, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 111, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 111, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 112, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 112, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 113, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 113, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 114, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 114, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 115, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 115, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 116, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 116, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 117, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 117, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 118, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 118, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 119, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 119, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 120, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 120, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 121, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 121, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 122, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 122, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 123, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 123, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 124, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 124, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 125, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 125, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 126, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 126, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 127, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 127, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 128, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 128, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 129, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 129, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 130, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 130, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 131, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 131, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 132, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 132, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 133, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 133, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 134, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 134, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 135, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 135, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 136, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 136, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 137, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 137, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 138, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 138, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 139, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 139, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 140, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 140, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 141, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 141, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 142, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 142, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 143, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 143, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 144, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 144, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 145, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 145, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 146, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 146, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 147, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 147, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 148, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 148, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 149, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 149, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 150, NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 150, NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Insert replies
INSERT INTO replies (created_by, comment_id, content, time_created)
VALUES 
(1, 1, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 1, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 2, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 2, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 3, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 3, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 4, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 4, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 5, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 5, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 6, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 6, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 7, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 7, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 8, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 8, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 9, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 9, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 10, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 10, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 11, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 11, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 12, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 12, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 13, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 13, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 14, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 14, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 15, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(1, 15, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 16, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 16, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 17, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 17, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 18, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 18, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 19, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 19, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 20, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 20, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 21, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 21, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 22, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 22, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 23, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 23, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 24, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 24, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 25, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 25, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 26, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 26, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 27, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 27, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 28, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 28, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 29, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 29, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 30, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(2, 30, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 31, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 31, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 32, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 32, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 33, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 33, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 34, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 34, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 35, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 35, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 36, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 36, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 37, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 37, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 38, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 38, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 39, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 39, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 40, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 40, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 41, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 41, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 42, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 42, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 43, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 43, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 44, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 44, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 45, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(3, 45, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 46, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 46, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 47, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 47, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 48, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 48, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 49, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 49, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 50, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 50, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 51, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 51, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 52, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 52, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 53, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 53, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 54, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 54, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 55, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 55, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 56, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 56, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 57, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 57, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 58, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 58, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 59, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 59, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 60, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(4, 60, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 61, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 61, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 62, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 62, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 63, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 63, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 64, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 64, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 65, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 65, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 66, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 66, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 67, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 67, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 68, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 68, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 69, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 69, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 70, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 70, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 71, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 71, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 72, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 72, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 73, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 73, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 74, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 74, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 75, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(5, 75, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 76, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 76, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 77, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 77, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 78, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 78, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 79, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 79, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 80, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 80, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 81, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 81, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 82, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 82, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 83, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 83, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 84, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 84, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 85, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 85, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 86, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 86, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 87, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 87, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 88, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 88, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 89, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 89, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 90, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(6, 90, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 91, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 91, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 92, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 92, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 93, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 93, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 94, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 94, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 95, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 95, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 96, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 96, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 97, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 97, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 98, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 98, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 99, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 99, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 100, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 100, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 101, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 101, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 102, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 102, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 103, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 103, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 104, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 104, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 105, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(7, 105, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 106, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 106, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 107, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 107, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 108, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 108, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 109, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 109, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 110, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 110, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 111, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 111, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 112, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 112, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 113, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 113, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 114, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 114, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 115, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 115, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 116, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 116, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 117, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 117, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 118, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 118, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 119, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 119, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 120, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(8, 120, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 121, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 121, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 122, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 122, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 123, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 123, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 124, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 124, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 125, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 125, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 126, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 126, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 127, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 127, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 128, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 128, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 129, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 129, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 130, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 130, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 131, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 131, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 132, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 132, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 133, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 133, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 134, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 134, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 135, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(9, 135, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 136, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 136, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 137, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 137, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 138, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 138, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 139, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 139, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 140, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 140, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 141, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 141, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 142, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 142, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 143, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 143, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 144, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 144, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 145, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 145, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 146, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 146, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 147, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 147, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 148, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 148, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 149, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 149, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 150, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY),
(10, 150, 'The session on learning and memory provided valuable insights.', NOW() - INTERVAL FLOOR(RAND() * 30) DAY);

-- Insert resources
INSERT INTO resources (session_id, file)
VALUES 
(1, 'fileName1'),
(1, 'fileName2'),
(2, 'fileName3'),
(2, 'fileName4'),
(3, 'fileName5'),
(3, 'fileName6'),
(4, 'fileName7'),
(4, 'fileName8'),
(5, 'fileName9'),
(5, 'fileName10'),
(6, 'fileName11'),
(6, 'fileName12'),
(7, 'fileName13'),
(7, 'fileName14'),
(8, 'fileName15'),
(8, 'fileName16'),
(9, 'fileName17'),
(9, 'fileName18'),
(10, 'fileName19'),
(10, 'fileName20'),
(11, 'fileName21'),
(11, 'fileName22'),
(12, 'fileName23'),
(12, 'fileName24'),
(13, 'fileName25'),
(13, 'fileName26'),
(14, 'fileName27'),
(14, 'fileName28'),
(15, 'fileName29'),
(15, 'fileName30'),
(16, 'fileName31'),
(16, 'fileName32'),
(17, 'fileName33'),
(17, 'fileName34'),
(18, 'fileName35'),
(18, 'fileName36'),
(19, 'fileName37'),
(19, 'fileName38'),
(20, 'fileName39'),
(20, 'fileName40'),
(21, 'fileName41'),
(21, 'fileName42'),
(22, 'fileName43'),
(22, 'fileName44'),
(23, 'fileName45'),
(23, 'fileName46'),
(24, 'fileName47'),
(24, 'fileName48'),
(25, 'fileName49'),
(25, 'fileName50'),
(26, 'fileName51'),
(26, 'fileName52'),
(27, 'fileName53'),
(27, 'fileName54'),
(28, 'fileName55'),
(28, 'fileName56'),
(29, 'fileName57'),
(29, 'fileName58'),
(30, 'fileName59'),
(30, 'fileName60'),
(31, 'fileName61'),
(31, 'fileName62'),
(32, 'fileName63'),
(32, 'fileName64'),
(33, 'fileName65'),
(33, 'fileName66'),
(34, 'fileName67'),
(34, 'fileName68'),
(35, 'fileName69'),
(35, 'fileName70'),
(36, 'fileName71'),
(36, 'fileName72'),
(37, 'fileName73'),
(37, 'fileName74'),
(38, 'fileName75'),
(38, 'fileName76'),
(39, 'fileName77'),
(39, 'fileName78'),
(40, 'fileName79'),
(40, 'fileName80'),
(41, 'fileName81'),
(41, 'fileName82'),
(42, 'fileName83'),
(42, 'fileName84'),
(43, 'fileName85'),
(43, 'fileName86'),
(44, 'fileName87'),
(44, 'fileName88'),
(45, 'fileName89'),
(45, 'fileName90'),
(46, 'fileName91'),
(46, 'fileName92'),
(47, 'fileName93'),
(47, 'fileName94'),
(48, 'fileName95'),
(48, 'fileName96'),
(49, 'fileName97'),
(49, 'fileName98'),
(50, 'fileName99'),
(50, 'fileName100');

-- Sample data for completedSessions table
-- Assuming we have 10 students with IDs from 1 to 10
-- Generating completion data for each student

-- Student 1
INSERT INTO completedSessions (student_id, session_id)
SELECT 1, session_id
FROM sessions
ORDER BY RAND()
LIMIT 3;

-- Student 2
INSERT INTO completedSessions (student_id, session_id)
SELECT 2, session_id
FROM sessions
ORDER BY RAND()
LIMIT 3;

-- Student 4
INSERT INTO completedSessions (student_id, session_id)
SELECT 4, session_id
FROM sessions
ORDER BY RAND()
LIMIT 3;

-- Student 5
INSERT INTO completedSessions (student_id, session_id)
SELECT 5, session_id
FROM sessions
ORDER BY RAND()
LIMIT 3;

