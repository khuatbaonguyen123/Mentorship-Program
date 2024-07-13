CREATE DATABASE runner_event;

USE runner_event;

CREATE TABLE `runner` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `main_distance` int,
  `age` int,
  `is_female` boolean
);

CREATE TABLE `event` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `start_date` date,
  `city` varchar(255)
);

CREATE TABLE `runner_event` (
  `runner_id` int,
  `event_id` int,
  PRIMARY KEY (runner_id, event_id)
);

ALTER TABLE `runner_event` ADD FOREIGN KEY (`runner_id`) REFERENCES `runner` (`id`);

ALTER TABLE `runner_event` ADD FOREIGN KEY (`event_id`) REFERENCES `event` (`id`);

INSERT INTO runner (name, main_distance, age, is_female) VALUES
('John Doe', 5000, 25, 0),
('Jane Smith', 10000, 30, 1),
('Emily Davis', 5000, 22, 1),
('Michael Johnson', 1500, 18, 0);

INSERT INTO event (name, start_date, city) VALUES
('London Marathon', '2024-04-21', 'London'),
('Warsaw Runs', '2024-06-15', 'Warsaw'),
('New Year Run', '2024-01-01', 'New York');

INSERT INTO runner_event (runner_id, event_id) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(1, 2),
(2, 2),
(3, 2),
(4, 2),
(1, 3),
(3, 3);

