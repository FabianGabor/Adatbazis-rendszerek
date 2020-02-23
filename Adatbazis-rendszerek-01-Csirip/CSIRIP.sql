-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 13, 2020 at 04:48 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `csirip`
--
CREATE DATABASE IF NOT EXISTS `csirip` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `csirip`;

-- --------------------------------------------------------

--
-- Table structure for table `csirip`
--

DROP TABLE IF EXISTS `csirip`;
CREATE TABLE IF NOT EXISTS `csirip` (
  `ID` int(11) NOT NULL,
  `szoveg` varchar(160) DEFAULT NULL,
  `felkuldo` varchar(30) DEFAULT NULL,
  `datum` date DEFAULT NULL,
  `visszavonvaE` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `felkuldo` (`felkuldo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- RELATIONSHIPS FOR TABLE `csirip`:
--   `felkuldo`
--       `felhasznalo` -> `nev`
--

-- --------------------------------------------------------

--
-- Table structure for table `felhasznalo`
--

DROP TABLE IF EXISTS `felhasznalo`;
CREATE TABLE IF NOT EXISTS `felhasznalo` (
  `nev` varchar(30) NOT NULL,
  `keresztnev` varchar(30) DEFAULT NULL,
  `vezeteknev` varchar(30) DEFAULT NULL,
  `regDatum` date DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `szulEv` int(11) DEFAULT NULL,
  `varos` varchar(30) DEFAULT NULL,
  `noE` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`nev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- RELATIONSHIPS FOR TABLE `felhasznalo`:
--

-- --------------------------------------------------------

--
-- Table structure for table `kedvel`
--

DROP TABLE IF EXISTS `kedvel`;
CREATE TABLE IF NOT EXISTS `kedvel` (
  `ki` varchar(30) DEFAULT NULL,
  `mit` int(11) DEFAULT NULL,
  `mikor` date DEFAULT NULL,
  KEY `mit` (`mit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- RELATIONSHIPS FOR TABLE `kedvel`:
--   `mit`
--       `csirip` -> `ID`
--

-- --------------------------------------------------------

--
-- Table structure for table `kovet`
--

DROP TABLE IF EXISTS `kovet`;
CREATE TABLE IF NOT EXISTS `kovet` (
  `ki` varchar(30) DEFAULT NULL,
  `kit` varchar(30) DEFAULT NULL,
  `mikor` date DEFAULT NULL,
  KEY `ki` (`ki`),
  KEY `kit` (`kit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- RELATIONSHIPS FOR TABLE `kovet`:
--   `ki`
--       `felhasznalo` -> `nev`
--   `kit`
--       `felhasznalo` -> `nev`
--

--
-- Constraints for dumped tables
--

--
-- Constraints for table `csirip`
--
ALTER TABLE `csirip`
  ADD CONSTRAINT `csirip_ibfk_1` FOREIGN KEY (`felkuldo`) REFERENCES `felhasznalo` (`nev`);

--
-- Constraints for table `kedvel`
--
ALTER TABLE `kedvel`
  ADD CONSTRAINT `kedvel_ibfk_1` FOREIGN KEY (`mit`) REFERENCES `csirip` (`ID`);

--
-- Constraints for table `kovet`
--
ALTER TABLE `kovet`
  ADD CONSTRAINT `kovet_ibfk_1` FOREIGN KEY (`ki`) REFERENCES `felhasznalo` (`nev`),
  ADD CONSTRAINT `kovet_ibfk_2` FOREIGN KEY (`kit`) REFERENCES `felhasznalo` (`nev`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
