-- After the student click a course in his/her course list, the system return the enrollment_id
-- We will use this enrollment_id, student_id and course_id associated with it to query
-- Assume the enrollment_id = 2, we have student_id = 1 and course_id = 2

-- Query to display the course's name, teacher, rating
SELECT 
	c.name AS course_name, 
    u.name AS teacher_name, 
    ROUND(AVG(e.rating)) AS average_rating, 
    COUNT(e.review) AS review_number
FROM 
	courses c JOIN enrollments e ON c.course_id = e.course_id
    JOIN teachingallocations ta ON c.course_id = ta.course_id
    JOIN teachers t ON ta.teacher_id = t.teacher_id
    JOIN users u ON t.user_id = u.user_id
WHERE c.course_id = 2
GROUP BY c.course_id, u.user_id;

-- Query to get the progress of the student (current completed sessions)
SELECT s.session_id,
       s.name AS session_name,
       CASE WHEN cs.complete_id IS NOT NULL THEN 1 ELSE 0 END AS completed
FROM sessions s
LEFT JOIN completedSessions cs ON s.session_id = cs.session_id AND cs.student_id = 1
WHERE s.course_id = 2
ORDER BY s.order;

-- Query to get the comments, number of likes of each comment of a session (Assume the current session_id = 6)
SELECT 
	u.name AS created_by_person, 
    c.content AS comment_content, 
    COUNT(l.like_id) AS number_of_likes
FROM 
	comments c JOIN users u ON c.created_by = u.user_id 
    JOIN likes l ON c.comment_id = l.comment_id
WHERE session_id = 6
GROUP BY c.comment_id;

-- Query to get the replies of all the comments in the session with id = 6
SELECT c.comment_id,
       r.reply_id,
       r.created_by AS replier_id,
       r.content AS reply_content,
       r.time_created AS reply_time_created
FROM comments c
JOIN replies r ON c.comment_id = r.comment_id
WHERE c.session_id = 6;

-- Query to get the documents of the session with id = 6
SELECT resource_id, file
FROM resources
WHERE session_id = 6;







