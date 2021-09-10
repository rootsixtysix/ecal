-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 09. Feb 2020 um 22:08
-- Server-Version: 10.4.11-MariaDB
-- PHP-Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `events_db`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `addresses`
--

CREATE TABLE `addresses` (
  `address_id` int(11) NOT NULL,
  `street` varchar(200) NOT NULL,
  `house_number` varchar(10) NOT NULL,
  `city_code` varchar(5) NOT NULL,
  `city` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `addresses`
--

INSERT INTO `addresses` (`address_id`, `street`, `house_number`, `city_code`, `city`) VALUES
(1, 'Kochstraße', '132', '04277', 'Leipzig'),
(2, 'Augustusplatz', '12', '04109', 'Leipzig'),
(3, 'Karl-Liebknecht-Straße', '132', '04277', 'Leipzig');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `artists`
--

CREATE TABLE `artists` (
  `artist_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `genre` varchar(200) DEFAULT NULL,
  `contact_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `artists`
--

INSERT INTO `artists` (`artist_id`, `name`, `genre`, `contact_id`) VALUES
(1, 'Gewandhausorchester', 'Klassik', 1),
(2, 'Parov Stelar Band', 'Electro Swing', 2),
(3, 'Die Vorband', 'Pop', 5);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `artist_event`
--

CREATE TABLE `artist_event` (
  `artist_event_id` int(11) NOT NULL,
  `artist_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `artist_event`
--

INSERT INTO `artist_event` (`artist_event_id`, `artist_id`, `event_id`) VALUES
(1, 2, 3),
(2, 1, 4),
(3, 3, 3),
(4, 2, 7);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `category`
--

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `category`
--

INSERT INTO `category` (`category_id`, `name`) VALUES
(1, 'Konzert'),
(2, 'Literatur'),
(3, 'Ausstellung'),
(4, 'Vortrag'),
(5, 'Workshop'),
(6, 'Diskussion'),
(7, 'Film');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `contact`
--

CREATE TABLE `contact` (
  `contact_id` int(11) NOT NULL,
  `web` varchar(300) DEFAULT NULL,
  `mail` varchar(100) DEFAULT NULL,
  `others` varchar(300) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `contact_person` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `contact`
--

INSERT INTO `contact` (`contact_id`, `web`, `mail`, `others`, `phone`, `contact_person`) VALUES
(1, 'gewandhausorchester.de', 'gwhdir@gewandhaus.de', 'www.twitter.com/gewandhaus', '+4934112700', 'Karl Anders'),
(2, 'parovstelar.com', NULL, 'https://m.facebook.com/pg/parovstelar/about/', NULL, 'Jules de Lattre'),
(3, 'werk-2.de', 'info@werk-2.de', NULL, '+493413080140', 'Anika Fraaß'),
(4, 'www.oper-leipzig.de', NULL, NULL, ' + 49 (0)341-12 61 514', 'Lotta Hüneke'),
(5, 'dievorband.de', 'info@dievorband.de', NULL, NULL, 'Dieter Vorbandus');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `events`
--

CREATE TABLE `events` (
  `event_id` int(11) NOT NULL,
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

--
-- Daten für Tabelle `events`
--

INSERT INTO `events` (`event_id`, `room_id`, `category_id`, `location_id`, `title`, `start`, `end`, `description`, `picture`, `privacy`) VALUES
(1, 7, 4, 2, 'Grüner studieren', '2020-02-03 10:00:00', '2020-02-03 11:30:00', 'Was kann ich als Student für unsere Umwelt tun? Welche Möglichkeiten bieten meine Hochschule und die Stadt? Welchen Einfluss haben die einzelnen Professoren und der Stura?', 'https://images.unsplash.com/photo-1472722266948-a898ab5ff257', 'public'),
(2, 4, 7, 2, '\"Hans Wurst\"', '2020-02-03 16:30:00', '2020-02-03 17:30:00', 'Dokumentation  - Wie unser Fleischkonsum die Welt beeinflusst.', 'https://images.unsplash.com/photo-1531097023973-44a8761c85e1', 'public'),
(3, 3, 1, 1, 'Parov Stelar @ Werk II', '2020-02-14 19:00:00', NULL, 'Liebe Gäste, plant eure Hüft-OPs schon einmal vor, denn hier wird geswingt was das Zeug hält!\r\nMit ihrem Blechensemble und den fetten Beats heizen Parov Stelar und Band bei uns die Halle ein.', 'https://images.unsplash.com/photo-1543704735-dcb21177026f', 'public'),
(4, 8, 1, 3, 'Rusalka', '2020-01-25 18:00:00', NULL, '>>Rusalka<< ist ein Märchen für Erwachsene von der Sehnsucht nach einer anderen Welt. Dvorak und sein ­Librettist Kvapil ließen sich von slawischen ­Mythen, Märchenfiguren wie de la Motte Fouqués >>Undine<< und ­Andersens >>Kleiner Seejungfrau<< sowie der ­Melusinensage inspirieren. Die Geschichte wird aus der Sicht der Naturgeister erzählt, in deren Welt der Mensch rücksichtslos hereinbricht. Die Oper erlebte seit ihrer Uraufführung im Jahr 1901 einen weltweiten Erfolgszug und zählt heute zu den bekanntesten tschechischen Opern. Nicht nur im berühmten >>Lied an den Mond<< entführt Dvořáks Musik in faszinierende Klangwelten voll Magie und zerbrechlicher Schönheit.<br><br>\r\n\r\nLeitung:<br>\r\nMusikalische Leitung Christoph Gedschold,<br>\r\nInszenierung Michiel Dijkema,<br>\r\nBühne Michiel Dijkema,<br>\r\nKostüme Jula Reindell,<br>\r\nLicht Michael Fischer,<br>\r\nChoreinstudierung Alexander Stessin,<br>\r\nDramaturgie Nele Winter,<br>\r\nOpernchor,<br>\r\nKomparserie,<br>\r\nGewandhausorchester<br><br>\r\n\r\nMitwirkende:<br>\r\n    Rusalka Gal James<br>\r\n    Jezibaba Karin Lovelius<br>\r\n    Fremde Fürstin Kathrin Göring<br>\r\n    Küchenjunge Mirjam Neururer<br>\r\n    1. Waldelfe Lenka Pavlovič<br>\r\n    2. Waldelfe Julia Moorman<br>\r\n    3. Waldelfe Sandra Janke<br>\r\n    Prinz Patrick Vogel<br>\r\n    Der Wassermann Tuomas Pursio<br>\r\n    Der Heger Jonathan Michie<br>\r\n    Jäger Dan Karlström<br>\r\n\r\n', 'https://images.unsplash.com/photo-1471927866530-2b87d315d8b2', 'public'),
(5, 4, 7, 2, 'Animationsfilmreihe zur grünen Woche', '2020-02-03 12:30:00', '2020-02-03 14:00:00', NULL, 'https://images.unsplash.com/photo-1485846234645-a62644f84728', 'public'),
(6, 5, 5, 2, 'Ecosia was?', '2020-02-03 14:30:00', '2020-02-03 16:00:00', 'Wir zeigen euch, was Ecosia ist, wie man es nutzt und welche enormen Vorteile es für uns und unsere umwelt bietet.', 'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09', 'public'),
(7, 1, 1, 1, 'Album Tour', '2021-01-08 19:00:00', NULL, 'Parov Stelar gehen auf Tour und du bist live mit dabei. Kaufe deine Karte am 31.2. und du erhältst 100% Rabatt.', 'https://gfx67.decks.de/decks/gfx/co_raw/front/end_q/ccj-1q.jpg', 'public');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `groups`
--

CREATE TABLE `groups` (
  `group_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `description` text DEFAULT NULL,
  `picture` varchar(500) DEFAULT NULL,
  `privacy` enum('public','private') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `groups`
--

INSERT INTO `groups` (`group_id`, `name`, `start`, `end`, `description`, `picture`, `privacy`) VALUES
(1, 'Die Grüne Woche der HTWK Leipzig', '2020-02-03 00:00:00', '2020-02-07 23:59:59', 'Die Grüne Woche der HTWK, meist kurz Grüne Woche genannt, ist eine Veranstaltungsreihe der Hochschule für Technik, Wirtschaft und Kultur in Leipzig, auf der umweltfreundliche Programme, Initiativen und Software von Vereinen, Herstellern und Vermarktern der weltweiten Industrie präsentiert werden und die nicht nur Fachbesuchern, sondern auch dem allgemeinen Publikum offensteht.', NULL, 'public'),
(2, 'Parov Stelar on Tour', '2020-01-01 19:00:00', '2021-01-31 23:00:00', 'Parov Stelar geht auf Europatour und nimmt sich viel Zeit um seine Fans zu begeistern.\r\nSei dabei und lass dich mitnehmen.', 'https://gfx67.decks.de/decks/gfx/co_raw/front/end_q/ccj-1q.jpg', 'public');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `group_event`
--

CREATE TABLE `group_event` (
  `group_event_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `group_event`
--

INSERT INTO `group_event` (`group_event_id`, `group_id`, `event_id`) VALUES
(1, 1, 5),
(2, 1, 6),
(3, 1, 1),
(4, 2, 7),
(5, 2, 3);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `locations`
--

CREATE TABLE `locations` (
  `location_id` int(11) NOT NULL,
  `address_id` int(11) NOT NULL,
  `contact_id` int(11) DEFAULT NULL,
  `name` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `picture` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `locations`
--

INSERT INTO `locations` (`location_id`, `address_id`, `contact_id`, `name`, `description`, `picture`) VALUES
(1, 1, 3, 'Werk 2 - Kulturfabrik', 'Euer Standort für Konzerte, Workshops und Austausch im Süden Leipzigs.', 'https://magazin.adticket.de/wp-content/uploads/2019/02/Werk2_AD_Beitrag-1.jpg'),
(2, 3, NULL, 'HTWK Leipzig', 'Die Hochschule für alle. die mal was werden wollen.', 'https://www.awb-architekten.de/files/awb/projekte/4610%20LE/Leipzig.HTWK-1_13.jpg'),
(3, 2, 4, 'Oper Leipzig', 'so\'n großes Haus auf dem Augustusplatz. nicht zu verwchseln mit den andern zwei größeren Häusern auf dem Augustusplatz. also ich sag mal so, wenn de in der Uni stehst, biste falsch', 'https://www.oper-leipzig.de/media/filer_public_thumbnails/filer_public/8f/07/8f07760d-ddab-43da-8f7e-0b32fbc140e3/wagner_atmokirstennijhof_kcn6073.jpg__1808x1106_q85_autocrop_crop-smart_cropper-slideshow_large-_subsampling-2.jpg');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `rooms`
--

CREATE TABLE `rooms` (
  `room_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `descripton` text DEFAULT NULL,
  `location_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `rooms`
--

INSERT INTO `rooms` (`room_id`, `name`, `descripton`, `location_id`) VALUES
(1, 'Halle D', 'Zum Haupteingang rein und gleich rechts', 1),
(2, 'Halle 5', 'Bitte rechts am Haupteingang vorbei und einmal um das Gebäude rum laufen. Auf der Rückseite findet ihr unsere Halle 5.', 1),
(3, 'Halle A', 'Unsere größte Halle findet ihr geradezu nachdem ihr durch den Haupteingang getreten seid.', 1),
(4, 'N001', 'Hörsaal im Nieperbau', 2),
(5, 'Li107', 'Computerpool im Lipsiusbau', 2),
(7, 'G119', 'Hörsaal im Geutebrückbau', 2),
(8, 'Großer Saal', NULL, 3);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`address_id`);

--
-- Indizes für die Tabelle `artists`
--
ALTER TABLE `artists`
  ADD PRIMARY KEY (`artist_id`),
  ADD KEY `CONTACT_ART` (`contact_id`);

--
-- Indizes für die Tabelle `artist_event`
--
ALTER TABLE `artist_event`
  ADD PRIMARY KEY (`artist_event_id`),
  ADD KEY `ARTIST_EA` (`artist_id`),
  ADD KEY `EVENT_EA` (`event_id`);

--
-- Indizes für die Tabelle `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indizes für die Tabelle `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`contact_id`);

--
-- Indizes für die Tabelle `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `ROOM_EV` (`room_id`),
  ADD KEY `CATEGORY_EV` (`category_id`),
  ADD KEY `LOCATION_EV` (`location_id`);

--
-- Indizes für die Tabelle `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`group_id`);

--
-- Indizes für die Tabelle `group_event`
--
ALTER TABLE `group_event`
  ADD PRIMARY KEY (`group_event_id`),
  ADD KEY `GROUP` (`group_id`),
  ADD KEY `EVENT` (`event_id`);

--
-- Indizes für die Tabelle `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`location_id`),
  ADD KEY `ADDRESS_LOC` (`address_id`),
  ADD KEY `CONTACT_LOC` (`contact_id`);

--
-- Indizes für die Tabelle `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`room_id`),
  ADD KEY `LOCATION` (`location_id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `addresses`
--
ALTER TABLE `addresses`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `artists`
--
ALTER TABLE `artists`
  MODIFY `artist_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `artist_event`
--
ALTER TABLE `artist_event`
  MODIFY `artist_event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT für Tabelle `contact`
--
ALTER TABLE `contact`
  MODIFY `contact_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `events`
--
ALTER TABLE `events`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT für Tabelle `groups`
--
ALTER TABLE `groups`
  MODIFY `group_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `group_event`
--
ALTER TABLE `group_event`
  MODIFY `group_event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `locations`
--
ALTER TABLE `locations`
  MODIFY `location_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `rooms`
--
ALTER TABLE `rooms`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `artists`
--
ALTER TABLE `artists`
  ADD CONSTRAINT `CONTACT_ART` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`contact_id`) ON UPDATE CASCADE;

--
-- Constraints der Tabelle `artist_event`
--
ALTER TABLE `artist_event`
  ADD CONSTRAINT `ARTIST_EA` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`artist_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `EVENT_EA` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `CATEGORY_EV` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `LOCATION_EV` FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ROOM_EV` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints der Tabelle `group_event`
--
ALTER TABLE `group_event`
  ADD CONSTRAINT `EVENT` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `GROUP` FOREIGN KEY (`group_id`) REFERENCES `groups` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `locations`
--
ALTER TABLE `locations`
  ADD CONSTRAINT `ADDRESS_LOC` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `CONTACT_LOC` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`contact_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints der Tabelle `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `LOCATION` FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
