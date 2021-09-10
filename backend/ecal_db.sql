SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*Without foreign keys*/

CREATE TABLE `roles` (
 `role_id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `name` varchar(255) NOT NULL,
 `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
INSERT INTO `roles` (`role_id`, `name`, `description`) VALUES
(1, 'person', 'can: visit events, create events, follow other protagonists'),
(2, 'location', 'can: create events, be tagged in events, be followed'),
(3, 'artist', 'can: create events, be tagged in events, be followed');


CREATE TABLE `permissions` (
 `permission_id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `name` varchar(255) NOT NULL UNIQUE KEY,
 `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `addresses` (
  `address_id` int(11) NOT NULL PRIMARY KEY,
  `street` varchar(200) NOT NULL,
  `house_number` varchar(10) NOT NULL,
  `city_code` varchar(5) NOT NULL,
  `city` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL PRIMARY KEY,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `contacts` (
  `contact_id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `web` varchar(300) DEFAULT NULL,
  `mail` varchar(100) DEFAULT NULL,
  `others` varchar(300) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `contact_person` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `groups` (
  `group_id` int(11) NOT NULL PRIMARY KEY,
  `name` varchar(200) NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `description` text DEFAULT NULL,
  `picture` varchar(500) DEFAULT NULL,
  `privacy` enum('public','private') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*#######################
With foreign keys
#######################*/
CREATE TABLE `locations` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `protagonist_id` int(11) NOT NULL,
  `address_id` int(11) NOT NULL,
  `contact_id` int(11) DEFAULT NULL,
  `name` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `picture` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE `locations`
  ADD KEY `ADDRESS_LOC` (`address_id`),
  ADD KEY `CONTACT_LOC` (`contact_id`),
  ADD KEY `PROTAGONIST_LOC` (`protagonist_id`);

CREATE TABLE `rooms` (
  `room_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `descripton` text DEFAULT NULL,
  `location_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`room_id`),
  ADD KEY `LOCATION` (`location_id`);


CREATE TABLE `users`(
    `user_id` INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `protagonist_id` INT(11) UNIQUE NOT NULL,
    `username` VARCHAR(255) UNIQUE NOT NULL,
    `email` VARCHAR(255) UNIQUE NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `user_id_cookie` VARCHAR(255) DEFAULT NULL,
    `session_cookie` VARCHAR(255) DEFAULT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
    KEY `Protagonist_user` (`protagonist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `protagonists`(
    `protagonist_id` INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `role_id` INT(11) DEFAULT NULL,
    CONSTRAINT `PROTAGONIST_ROLE` FOREIGN KEY(`role_id`) REFERENCES `roles`(`role_id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `artists` (
  `artist_id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `protagonist_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `genre` varchar(200) DEFAULT NULL,
  `contact_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE `artists`
  ADD KEY `CONTACT_ART` (`contact_id`),
  ADD KEY `PROTAGONIST_ART` (`protagonist_id`);

CREATE TABLE `persons` (
    `person_id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `protagonist_id` int(11) NOT NULL,
    `contact_id` int(11) DEFAULT NULL,
    `name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE `persons`
    ADD KEY `CONTACT_PERS` (`contact_id`),
    ADD KEY `PROTAGONIST_PERS` (`protagonist_id`);

CREATE TABLE `events` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `room_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime DEFAULT NULL,
  `description` text DEFAULT NULL,
  `picture` varchar(500) DEFAULT NULL,
  `privacy` enum('public','private') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE `events`
  ADD KEY `ROOM_EV` (`room_id`),
  ADD KEY `CATEGORY_EV` (`category_id`),
  ADD KEY `LOCATION_EV` (`location_id`);


/*many to many handling*/
CREATE TABLE `permission_role` (
 `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
 `role_id` int(11) NOT NULL,
 `permission_id` int(11) NOT NULL,
 KEY `role_id` (`role_id`),
 KEY `permission_id` (`permission_id`),
 CONSTRAINT `permission_role_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `permission_role_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `protagonist_follows_protagonist` (
    `protagonist_follows_protagonist_id` int(11) NOT NULL,
    `protagonist_id` int(11) NOT NULL,
    `followed_protagonist_id` int(11) NOT NULL,
    PRIMARY KEY (`protagonist_follows_protagonist_id`),
    KEY `FOLLOWER` (`protagonist_id`),
    KEY `FOLLOWED` (`followed_protagonist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `artist_in_event` (
  `artist_in_event_id` int(11) NOT NULL,
  `artist_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE `artist_in_event`
  ADD PRIMARY KEY (`artist_in_event_id`),
  ADD KEY `ARTIST_EA` (`artist_id`),
  ADD KEY `EVENT_EA` (`event_id`);

CREATE TABLE `user_bookmarked_event` (
    `bookmark_id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id` int(11) NOT NULL,
    `event_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE `user_bookmarked_event`
    ADD KEY `USER_UE` (`user_id`),
    ADD KEY `EVENT_UE` (`event_id`);

CREATE TABLE `group_event` (
    `group_event_id` int(11) NOT NULL,
    `group_id` int(11) NOT NULL,
    `event_id` int(11) NOT NULL
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE `group_event`
  ADD PRIMARY KEY (`group_event_id`),
  ADD KEY `GROUP` (`group_id`),
  ADD KEY `EVENT` (`event_id`);
