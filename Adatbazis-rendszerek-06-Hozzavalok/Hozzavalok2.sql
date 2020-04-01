-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 31, 2020 at 08:09 PM
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
-- Database: `Hozzavalok2`
--

-- --------------------------------------------------------

--
-- Table structure for table `alapanyag`
--

CREATE TABLE `alapanyag` (
  `ID` int(11) NOT NULL,
  `nev` varchar(45) NOT NULL,
  `mertekegyseg` varchar(5) DEFAULT NULL,
  `egysegar` int(10) UNSIGNED DEFAULT NULL CHECK (`egysegar` < 1000000),
  `romlando` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `alapanyag`
--

INSERT INTO `alapanyag` (`ID`, `nev`, `mertekegyseg`, `egysegar`, `romlando`) VALUES
(1, 'Só', 'dkg', 215, 0),
(2, 'Bors', 'dkg', 249, 0),
(3, 'Paprika', 'dkg', 350, 1),
(4, 'Krumpli', 'kg', 269, 1),
(5, 'Koriander', 'dkg', 495, 0),
(6, 'Tej', 'liter', 199, 1),
(7, 'Cukor', 'kg', 259, 0),
(8, 'Vanilia', 'g', 200, 0);

-- --------------------------------------------------------

--
-- Table structure for table `igeny`
--

CREATE TABLE `igeny` (
  `alapanyag` int(11) NOT NULL,
  `recept` int(11) NOT NULL,
  `mennyiseg` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `igeny`
--

INSERT INTO `igeny` (`alapanyag`, `recept`, `mennyiseg`) VALUES
(1, 1, 1),
(2, 1, 1),
(3, 1, 4),
(3, 3, 3),
(4, 1, 2),
(4, 4, 1),
(5, 2, 2),
(6, 4, 1);

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
(1, 'bográncsgulyás', 'magyaros', 300),
(2, 'Recept 1', 'Tipus 1', 200),
(3, 'Recept 2', 'Tipus 2', 240),
(4, 'Recept 3', 'Tipus 3', 100);

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
  ADD KEY `fk_recept` (`recept`);

--
-- Indexes for table `recept`
--
ALTER TABLE `recept`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `alapanyag`
--
ALTER TABLE `alapanyag`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `recept`
--
ALTER TABLE `recept`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `igeny`
--
ALTER TABLE `igeny`
  ADD CONSTRAINT `fk_alapanyag` FOREIGN KEY (`alapanyag`) REFERENCES `alapanyag` (`ID`),
  ADD CONSTRAINT `fk_recept` FOREIGN KEY (`recept`) REFERENCES `recept` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
