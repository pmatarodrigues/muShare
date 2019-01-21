-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 22, 2019 at 12:36 AM
-- Server version: 5.7.24-0ubuntu0.18.04.1
-- PHP Version: 7.2.10-0ubuntu0.18.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `muShare`
--

-- --------------------------------------------------------

--
-- Table structure for table `music`
--

CREATE TABLE `music` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_bin NOT NULL,
  `duration` decimal(50,2) DEFAULT NULL,
  `user` int(11) NOT NULL,
  `music` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `dateUpload` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `music`
--

INSERT INTO `music` (`id`, `name`, `duration`, `user`, `music`, `dateUpload`) VALUES
(66, 'Mac Miller', '3.00', 32, 'mac.mp3', '2019-01-21 23:14:51'),
(67, 'Tyler, The', '3.00', 28, 'tyler.mp3', '2019-01-21 16:21:00'),
(68, 'Death', '3.00', 32, 'death.mp3', '2019-01-21 23:14:51'),
(69, 'Ultimate.mp3', NULL, 28, 'Ultimate.mp3', '2019-01-21 18:20:51'),
(70, 'Jonas Blue.mp3', NULL, 32, 'Jonas Blue.mp3', '2019-01-21 23:12:54'),
(71, 'Masego.mp3', NULL, 28, 'Masego.mp3', '2019-01-21 23:16:21');

-- --------------------------------------------------------

--
-- Table structure for table `playlist`
--

CREATE TABLE `playlist` (
  `id` int(11) NOT NULL,
  `name` varchar(200) COLLATE utf8_bin NOT NULL,
  `uploader` int(11) NOT NULL,
  `private` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `playlist_music`
--

CREATE TABLE `playlist_music` (
  `playlist` int(11) NOT NULL,
  `music` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `sid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `session` text COLLATE utf8_unicode_ci NOT NULL,
  `expires` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`sid`, `session`, `expires`) VALUES
('2y81eZaeUUy0rDdmu8Q3mrlH1SIkTHLJ', '{\"cookie\":{\"originalMaxAge\":60000,\"expires\":\"2019-01-09T15:43:17.479Z\",\"httpOnly\":true,\"path\":\"/\"},\"passport\":{\"user\":2}}', 1547048597),
('fJ3hNlsKwIAcSijvY_L79Y-SsZDtqtwf', '{\"cookie\":{\"originalMaxAge\":60000,\"expires\":\"2019-01-09T15:43:27.895Z\",\"httpOnly\":true,\"path\":\"/\"},\"passport\":{\"user\":1}}', 1547048608),
('HPK1uzH3-MsWn4dcsacPllOKgFyBIlrK', '{\"cookie\":{\"originalMaxAge\":60000,\"expires\":\"2019-01-09T15:43:39.051Z\",\"httpOnly\":true,\"path\":\"/\"}}', 1547048619),
('LDLEdfQv-PuomifVZrLaWny3Cb7T3Vk-', '{\"cookie\":{\"originalMaxAge\":60000,\"expires\":\"2019-01-09T14:58:50.513Z\",\"httpOnly\":true,\"path\":\"/\"},\"passport\":{\"user\":1}}', 1547045931);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(50) COLLATE utf8_bin NOT NULL,
  `password` varchar(200) COLLATE utf8_bin NOT NULL,
  `pic` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `bio` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `login` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `pic`, `bio`, `login`) VALUES
(28, 'benjamim', '$2b$05$Pmni.bWoxzCY64Yp2W0sTuuKKuuKyQg74DIeKke9V6wRmkVaHKj/q', 'benjamim.jpg', 'i', 0),
(32, 'pedro', '$2b$05$Q14Mp2IIczz2vGh9vmPOj./kvx.d4zEd2dZIcaOjdDMsxoevELpyK', 'pedro.jpg', 'i', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `music`
--
ALTER TABLE `music`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `playlist`
--
ALTER TABLE `playlist`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `playlist_music`
--
ALTER TABLE `playlist_music`
  ADD PRIMARY KEY (`playlist`,`music`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`sid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `music`
--
ALTER TABLE `music`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;
--
-- AUTO_INCREMENT for table `playlist`
--
ALTER TABLE `playlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;
DELIMITER $$
--
-- Events
--
CREATE DEFINER=`benjamim`@`localhost` EVENT `sess_cleanup` ON SCHEDULE EVERY 15 MINUTE STARTS '2019-01-09 14:57:37' ON COMPLETION NOT PRESERVE ENABLE DO DELETE FROM `sessions` WHERE id IN (SELECT temp.id FROM (SELECT `id` FROM `sessions` WHERE `expires` > 0 AND `expires` < UNIX_TIMESTAMP()) AS temp)$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
