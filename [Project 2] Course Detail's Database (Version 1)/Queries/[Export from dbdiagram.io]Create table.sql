CREATE DATABASE elearning;

CREATE TABLE `users` (
  `user_id` int PRIMARY KEY auto_increment,
  `name` text,
  `user_name` varchar(255),
  `email` varchar(255),
  `password_hashed` varchar(255),
  `bio` text,
  `birthday` date
);

CREATE TABLE `students` (
  `student_id` int PRIMARY KEY auto_increment,
  `user_id` int,
  `grade` tinyint
);

CREATE TABLE `teachers` (
  `teacher_id` int PRIMARY KEY auto_increment,
  `user_id` int,
  `description` text
);

CREATE TABLE `courses` (
  `course_id` int PRIMARY KEY auto_increment,
  `name` varchar(255)
);

CREATE TABLE `teachingAllocations` (
  `allocation_id` int PRIMARY KEY auto_increment,
  `teacher_id` int,
  `course_id` int
);

CREATE TABLE `enrollments` (
  `enrollment_id` int PRIMARY KEY auto_increment,
  `student_id` int,
  `course_id` int,
  `rating` tinyint,
  `review` text
);

CREATE TABLE `sessions` (
  `session_id` int PRIMARY KEY auto_increment,
  `course_id` int,
  `name` varchar(255),
  `order` int,
  `video` blob,
  `summary` text,
  `transcript` text
);

CREATE TABLE `completedSessions` (
  `complete_id` int PRIMARY KEY auto_increment,
  `student_id` int,
  `session_id` int
);

CREATE TABLE `comments` (
  `comment_id` int PRIMARY KEY auto_increment,
  `created_by` int,
  `session_id` int,
  `content` text,
  `file` blob,
  `time_created` timestamp
);

CREATE TABLE `likes` (
  `like_id` int PRIMARY KEY auto_increment,
  `created_by` int,
  `comment_id` int,
  `time_created` timestamp
);

CREATE TABLE `replies` (
  `reply_id` int PRIMARY KEY auto_increment,
  `created_by` int,
  `comment_id` int,
  `content` text,
  `time_created` timestamp
);

CREATE TABLE `resources` (
  `resource_id` int PRIMARY KEY auto_increment,
  `session_id` int,
  `file` blob
);

ALTER TABLE `students` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `teachers` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `teachingAllocations` ADD FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`teacher_id`);

ALTER TABLE `teachingAllocations` ADD FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`);

ALTER TABLE `enrollments` ADD FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`);

ALTER TABLE `enrollments` ADD FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`);

ALTER TABLE `sessions` ADD FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`);

ALTER TABLE `completedSessions` ADD FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`);

ALTER TABLE `completedSessions` ADD FOREIGN KEY (`session_id`) REFERENCES `sessions` (`session_id`);

ALTER TABLE `comments` ADD FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

ALTER TABLE `comments` ADD FOREIGN KEY (`session_id`) REFERENCES `sessions` (`session_id`);

ALTER TABLE `likes` ADD FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

ALTER TABLE `likes` ADD FOREIGN KEY (`comment_id`) REFERENCES `comments` (`comment_id`);

ALTER TABLE `replies` ADD FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

ALTER TABLE `replies` ADD FOREIGN KEY (`comment_id`) REFERENCES `comments` (`comment_id`);

ALTER TABLE `resources` ADD FOREIGN KEY (`session_id`) REFERENCES `sessions` (`session_id`);
