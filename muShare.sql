-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 17/01/2019 às 12:32
-- Versão do servidor: 10.1.34-MariaDB
-- Versão do PHP: 7.2.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `muShare`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `music`
--

CREATE TABLE `music` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_bin NOT NULL,
  `duration` decimal(50,2) DEFAULT NULL,
  `user` int(11) NOT NULL,
  `dateUpload` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Fazendo dump de dados para tabela `music`
--

INSERT INTO `music` (`id`, `name`, `duration`, `user`, `dateUpload`) VALUES
(55, 'Hino ESTG', '4.21', 26, '2019-01-14 16:05:33'),
(56, 'Salvador Sobral', '3.52', 26, '2019-01-14 16:05:50'),
(57, 'Qualquer cosa', '2.12', 26, '2019-01-15 15:05:45'),
(58, 'coćo', '2.00', 26, '2019-01-15 15:05:59'),
(59, 'cocó', '45.00', 26, '2019-01-17 11:09:28'),
(60, 'musica', '1.24', 26, '2019-01-17 11:09:49');

-- --------------------------------------------------------

--
-- Estrutura para tabela `playlist`
--

CREATE TABLE `playlist` (
  `id` int(11) NOT NULL,
  `name` varchar(200) COLLATE utf8_bin NOT NULL,
  `uploader` int(11) NOT NULL,
  `private` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estrutura para tabela `playlist_music`
--

CREATE TABLE `playlist_music` (
  `playlist` int(11) NOT NULL,
  `music` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estrutura para tabela `sessions`
--

CREATE TABLE `sessions` (
  `sid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `session` text COLLATE utf8_unicode_ci NOT NULL,
  `expires` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Fazendo dump de dados para tabela `sessions`
--

INSERT INTO `sessions` (`sid`, `session`, `expires`) VALUES
('2y81eZaeUUy0rDdmu8Q3mrlH1SIkTHLJ', '{\"cookie\":{\"originalMaxAge\":60000,\"expires\":\"2019-01-09T15:43:17.479Z\",\"httpOnly\":true,\"path\":\"/\"},\"passport\":{\"user\":2}}', 1547048597),
('fJ3hNlsKwIAcSijvY_L79Y-SsZDtqtwf', '{\"cookie\":{\"originalMaxAge\":60000,\"expires\":\"2019-01-09T15:43:27.895Z\",\"httpOnly\":true,\"path\":\"/\"},\"passport\":{\"user\":1}}', 1547048608),
('HPK1uzH3-MsWn4dcsacPllOKgFyBIlrK', '{\"cookie\":{\"originalMaxAge\":60000,\"expires\":\"2019-01-09T15:43:39.051Z\",\"httpOnly\":true,\"path\":\"/\"}}', 1547048619),
('LDLEdfQv-PuomifVZrLaWny3Cb7T3Vk-', '{\"cookie\":{\"originalMaxAge\":60000,\"expires\":\"2019-01-09T14:58:50.513Z\",\"httpOnly\":true,\"path\":\"/\"},\"passport\":{\"user\":1}}', 1547045931);

-- --------------------------------------------------------

--
-- Estrutura para tabela `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(50) COLLATE utf8_bin NOT NULL,
  `password` varchar(200) COLLATE utf8_bin NOT NULL,
  `pic` varchar(200) COLLATE utf8_bin NOT NULL,
  `bio` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `login` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Fazendo dump de dados para tabela `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `pic`, `bio`, `login`) VALUES
(26, 'ipvc', '$2b$05$bkFDzOsAjJowKFVZGJsglem8HzFng9ILNvQUxwThfCpWjV2Jal3bu', '054058_1_1205_ipvc-300x300.jpg', ' ', 0),
(27, 'teste', '$2b$05$gVkyGwUQYWFfLfnbiuC41egctv/TKbP8VuxiDmDwfr/Kj/n6P9x.G', '054058_1_1205_ipvc-300x300.jpg', ' ', 0);

--
-- Índices de tabelas apagadas
--

--
-- Índices de tabela `music`
--
ALTER TABLE `music`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `playlist`
--
ALTER TABLE `playlist`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `playlist_music`
--
ALTER TABLE `playlist_music`
  ADD PRIMARY KEY (`playlist`,`music`);

--
-- Índices de tabela `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`sid`);

--
-- Índices de tabela `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas apagadas
--

--
-- AUTO_INCREMENT de tabela `music`
--
ALTER TABLE `music`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT de tabela `playlist`
--
ALTER TABLE `playlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

DELIMITER $$
--
-- Eventos
--
CREATE DEFINER=`pedro`@`localhost` EVENT `sess_cleanup` ON SCHEDULE EVERY 15 MINUTE STARTS '2019-01-09 14:57:37' ON COMPLETION NOT PRESERVE ENABLE DO DELETE FROM `sessions` WHERE id IN (SELECT temp.id FROM (SELECT `id` FROM `sessions` WHERE `expires` > 0 AND `expires` < UNIX_TIMESTAMP()) AS temp)$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
