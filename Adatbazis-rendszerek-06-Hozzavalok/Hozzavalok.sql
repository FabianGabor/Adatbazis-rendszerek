-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 30, 2020 at 03:58 PM
-- Server version: 10.3.22-MariaDB-1
-- PHP Version: 7.3.15-3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Hozzavalok`
--

-- --------------------------------------------------------

--
-- Table structure for table `alapanyag`
--

CREATE TABLE `alapanyag` (
  `ID` int(11) NOT NULL,
  `nev` varchar(45) NOT NULL,
  `mertekegyseg` varchar(4) NOT NULL DEFAULT 'dkg',
  `egysegar` int(10) UNSIGNED DEFAULT NULL CHECK (`egysegar` < 1000000),
  `romlando` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `alapanyag`
--

INSERT INTO `alapanyag` (`ID`, `nev`, `mertekegyseg`, `egysegar`, `romlando`) VALUES
(0, 'Só', 'dkg', NULL, NULL),
(1, 'Bors', 'dkg', NULL, NULL),
(2, 'Paprika', 'dkg', NULL, NULL),
(3, 'Koriander', 'dkg', NULL, NULL),
(4, 'Krumpli', 'dkg', NULL, NULL),
(5, 'Kolbász', 'dkg', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `igeny`
--

CREATE TABLE `igeny` (
  `alapanyag` int(11) NOT NULL,
  `recept` int(11) NOT NULL,
  `mennyiseg` int(11) DEFAULT NULL
) ;

--
-- Dumping data for table `igeny`
--

INSERT INTO `igeny` (`alapanyag`, `recept`, `mennyiseg`) VALUES
(0, 0, NULL),
(0, 1, NULL),
(0, 2, NULL),
(1, 0, NULL),
(1, 2, NULL),
(2, 2, NULL),
(4, 2, NULL),
(5, 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `recept`
--

CREATE TABLE `recept` (
  `ID` int(11) NOT NULL,
  `nev` varchar(45) NOT NULL,
  `tipus` varchar(20) DEFAULT NULL,
  `haszonkulcs` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `recept`
--

INSERT INTO `recept` (`ID`, `nev`, `tipus`, `haszonkulcs`) VALUES
(0, 'Recept 1', NULL, NULL),
(1, 'Recept 2', NULL, NULL),
(2, 'bográncsgulyás', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alapanyag`
--
ALTER TABLE `alapanyag`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `igeny`
--
ALTER TABLE `igeny`
  ADD PRIMARY KEY (`alapanyag`,`recept`),
  ADD KEY `recept` (`recept`);

--
-- Indexes for table `recept`
--
ALTER TABLE `recept`
  ADD PRIMARY KEY (`ID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `igeny`
--
ALTER TABLE `igeny`
  ADD CONSTRAINT `igeny_ibfk_1` FOREIGN KEY (`alapanyag`) REFERENCES `alapanyag` (`ID`),
  ADD CONSTRAINT `igeny_ibfk_2` FOREIGN KEY (`recept`) REFERENCES `recept` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
