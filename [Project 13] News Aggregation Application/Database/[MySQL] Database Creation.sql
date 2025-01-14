CREATE DATABASE news_aggregation;

USE news_aggregation;

CREATE TABLE `User` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `full_name` varchar(255),
  `email` varchar(255) UNIQUE,
  `password` varchar(255)
);

CREATE TABLE `News` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(255),
  `description` text,
  `link` varchar(255),
  `guid` varchar(255),
  `pub_date` datetime,
  `rss_id` integer,
  `views_count` integer
);

CREATE TABLE `User_News_Interaction` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `user_id` integer,
  `news_id` integer,
  `type_interaction` enum ('View') DEFAULT 'View'
);

CREATE TABLE `RSS` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(255),
  `link` varchar(255),
  `description` text,
  `language` varchar(255),
  `pub_date` datetime,
  `source_id` integer
);

CREATE TABLE `Rss_Source` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `website_url` varchar(255)
);

CREATE TABLE `Tag` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) UNIQUE,
  `views_count` integer,
  `saves_count` integer
);

CREATE TABLE `User_Tag_Interaction` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `user_id` integer,
  `tag_id` integer,
  `interaction_type` enum ('View', 'Save'),
  `created_at` datetime
);

CREATE TABLE `News_Tag` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `news_id` integer,
  `tag_id` integer
);

ALTER TABLE `News` ADD FOREIGN KEY (`rss_id`) REFERENCES `RSS` (`id`);

ALTER TABLE `User_News_Interaction` ADD FOREIGN KEY (`user_id`) REFERENCES `User` (`id`);

ALTER TABLE `User_News_Interaction` ADD FOREIGN KEY (`news_id`) REFERENCES `News` (`id`);

ALTER TABLE `RSS` ADD FOREIGN KEY (`source_id`) REFERENCES `Rss_Source` (`id`);

ALTER TABLE `User_Tag_Interaction` ADD FOREIGN KEY (`user_id`) REFERENCES `User` (`id`);

ALTER TABLE `User_Tag_Interaction` ADD FOREIGN KEY (`tag_id`) REFERENCES `Tag` (`id`);

ALTER TABLE `News_Tag` ADD FOREIGN KEY (`news_id`) REFERENCES `News` (`id`);

ALTER TABLE `News_Tag` ADD FOREIGN KEY (`tag_id`) REFERENCES `Tag` (`id`);
