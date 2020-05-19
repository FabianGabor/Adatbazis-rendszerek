-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 13, 2020 at 10:17 AM
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

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`dirtyred`@`localhost` PROCEDURE `AlapanyagArMegemelese` (IN `keresettSzoveg` VARCHAR(30))  NO SQL
BEGIN    
    UPDATE alapanyag.ar SET price = (price * 1.5) WHERE alapanyag.nev LIKE '%'+keresettSzoveg+'%';
END$$

--
-- Functions
--
CREATE DEFINER=`dirtyred`@`localhost` FUNCTION `alapanyagHanyReceptben` (`alapanyagID` INT(4)) RETURNS INT(11) BEGIN    
	DECLARE keresettID int(4);
    DECLARE szamlalo int(4);
    DECLARE c CURSOR FOR SELECT alapanyag.ID,COUNT(igeny.recept) AS szamlal FROM alapanyag JOIN igeny ON igeny.alapanyag = alapanyag.ID JOIN recept ON recept.ID = igeny.recept GROUP BY alapanyag.nev HAVING alapanyag.ID = alapanyagID;
    OPEN c;
    FETCH c INTO keresettID,szamlalo;
    CLOSE c;
    RETURN szamlalo;    
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `alapanyag`
--

CREATE TABLE `alapanyag` (
  `ID` int(11) NOT NULL,
  `nev` varchar(45) DEFAULT NULL,
  `mertekegyseg` varchar(4) DEFAULT 'dkg',
  `egysegar` int(11) DEFAULT NULL CHECK (`egysegar` between 1 and 999999),
  `romlando` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `alapanyag`
--

INSERT INTO `alapanyag` (`ID`, `nev`, `mertekegyseg`, `egysegar`, `romlando`) VALUES
(1, 'só', 'dkg', 1, 0),
(2, 'bors', 'g', 10, NULL),
(3, 'csemege paprika', 'g', 12, NULL),
(4, 'erős paprika', 'g', 20, 1),
(5, 'paradicsom', 'kg', 300, 1),
(6, 'kenyér', 'kg', 300, 1),
(7, 'vaj', 'dkg', 30, 1),
(8, 'paprika lédig', 'kg', 700, 1),
(9, 'krumpli', 'kg', 300, 1),
(10, 'rizs', 'kg', 300, 0),
(11, 'tojás', 'db', 35, 1),
(12, 'liszt', 'kg', 160, 1),
(13, 'krumpli', 'kg', 300, 1),
(14, 'csirkehús', 'kg', 700, 1),
(15, 'sertéshús', 'kg', 1200, 1),
(16, 'tej', 'l', 230, 1),
(17, 'joghurt', 'l', 400, 1),
(18, 'májkrém', 'dkg', 7, 0),
(19, 'vereshagyma', 'kg', 200, 0),
(20, 'zsír', 'dkg', 5, 0);

-- --------------------------------------------------------

--
-- Table structure for table `igeny`
--

CREATE TABLE `igeny` (
  `alapanyag` int(11) NOT NULL,
  `recept` int(11) NOT NULL,
  `mennyiseg` float DEFAULT NULL
) ;

--
-- Dumping data for table `igeny`
--

INSERT INTO `igeny` (`alapanyag`, `recept`, `mennyiseg`) VALUES
(1, 2, 2),
(1, 3, 3),
(1, 4, 3),
(1, 5, 2),
(4, 2, 1),
(5, 2, 0.4),
(6, 1, 0.05),
(7, 1, 1),
(8, 2, 0.4),
(11, 6, 2),
(11, 7, 2),
(12, 6, 0.5),
(12, 7, 0.5),
(13, 5, 1),
(14, 3, 0.5),
(15, 4, 0.5),
(16, 6, 0.5),
(16, 7, 0.1),
(19, 3, 0.3),
(19, 4, 0.3),
(20, 2, 5),
(20, 3, 5),
(20, 4, 5);

-- --------------------------------------------------------

--
-- Stand-in structure for view `n10`
-- (See below for the actual view)
--
CREATE TABLE `n10` (
`alapanyag` int(11)
);

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
(1, 'vajaskenyér', 'előétel', 10),
(2, 'lecsó', 'vega', 20),
(3, 'csirkepörkölt', 'húsétel', 10),
(4, 'disznópörkölt', 'húsétel', 10),
(5, 'krumplipüré', 'köret', 10),
(6, 'palacsinta', 'vega', 30),
(7, 'lángos', 'vega', 30);

--
-- Triggers `recept`
--
DELIMITER $$
CREATE TRIGGER `Haszonkulcs20` BEFORE INSERT ON `recept` FOR EACH ROW UPDATE haszonkulcs SET haszonkulcs = 20 WHERE new.haszonkulcs < 20
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure for view `n10`
--
DROP TABLE IF EXISTS `n10`;

CREATE ALGORITHM=UNDEFINED DEFINER=`dirtyred`@`localhost` SQL SECURITY DEFINER VIEW `n10`  AS  select `igeny`.`alapanyag` AS `alapanyag` from (`igeny` join `alapanyag` on(`igeny`.`alapanyag` = `alapanyag`.`ID`)) where 1 group by `igeny`.`alapanyag` having count(0) > 10 ;

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
