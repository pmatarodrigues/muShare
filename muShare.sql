-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 21, 2019 at 01:49 AM
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
(55, 'Hino ESTG', '4.21', 26, NULL, '2019-01-14 16:05:33'),
(56, 'Salvador Sobral', '3.52', 26, NULL, '2019-01-14 16:05:50'),
(57, 'Qualquer cosa', '2.12', 26, NULL, '2019-01-15 15:05:45'),
(58, 'coćo', '2.00', 26, NULL, '2019-01-15 15:05:59'),
(59, 'cocó', '45.00', 26, NULL, '2019-01-17 11:09:28'),
(60, 'musica', '1.24', 26, NULL, '2019-01-17 11:09:49'),
(61, 'fvgbhnj', '123.00', 28, 'benjamim.jpg', '2019-01-18 18:40:09'),
(62, 'setidez', '7.10', 28, 'ficheiro.jpg', '2019-01-18 19:11:01'),
(63, 'qwe', '123.00', 28, 'undefined', '2019-01-19 15:48:07'),
(64, 'Boombible', '2.00', 28, 'undefined', '2019-01-19 18:49:09'),
(65, 'Boombiple', '2.30', 28, 'boombiple.wav', '2019-01-19 18:50:52');

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
(26, 'ipvc', '$2b$05$bkFDzOsAjJowKFVZGJsglem8HzFng9ILNvQUxwThfCpWjV2Jal3bu', '054058_1_1205_ipvc-300x300.jpg', ' ', 0),
(27, 'teste', '$2b$05$gVkyGwUQYWFfLfnbiuC41egctv/TKbP8VuxiDmDwfr/Kj/n6P9x.G', '054058_1_1205_ipvc-300x300.jpg', ' ', 0),
(28, 'benjamim', '$2b$05$Pmni.bWoxzCY64Yp2W0sTuuKKuuKyQg74DIeKke9V6wRmkVaHKj/q', 'benjamim.jpg', 'i', 0);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;
--
-- AUTO_INCREMENT for table `playlist`
--
ALTER TABLE `playlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
DELIMITER $$
--
-- Events
--
CREATE DEFINER=`benjamim`@`localhost` EVENT `sess_cleanup` ON SCHEDULE EVERY 15 MINUTE STARTS '2019-01-09 14:57:37' ON COMPLETION NOT PRESERVE ENABLE DO DELETE FROM `sessions` WHERE id IN (SELECT temp.id FROM (SELECT `id` FROM `sessions` WHERE `expires` > 0 AND `expires` < UNIX_TIMESTAMP()) AS temp)$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
