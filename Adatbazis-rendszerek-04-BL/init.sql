DROP DATABASE IF EXISTS ChampionsLeague;
CREATE DATABASE ChampionsLeague;
USE ChampionsLeague;
-- -----------------------------------------------------
-- Table `Club`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club` ;

CREATE  TABLE IF NOT EXISTS `Club` (
  `championship` INT(11) NULL DEFAULT NULL ,
  `name` VARCHAR(30) NOT NULL ,
  `city` VARCHAR(30) NOT NULL ,
  `nationality` CHAR(3) NOT NULL ,
  `stadium` VARCHAR(30) NOT NULL ,
  `foundationYear` VARCHAR(4) NOT NULL ,
  `owner` VARCHAR(30) NULL DEFAULT NULL ,
  `capital` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`name`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Result`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `Result` ;

CREATE  TABLE IF NOT EXISTS `Result` (
  `turn` INT(11) NOT NULL ,
  `clubHome` VARCHAR(30) NOT NULL ,
  `clubGuest` VARCHAR(30) NULL DEFAULT NULL ,
  `goalHome` INT(11) UNSIGNED NULL DEFAULT NULL ,
  `goalGuest` INT(11) UNSIGNED NULL DEFAULT NULL ,
  `goalHomeHalftime` INT(11) UNSIGNED NULL DEFAULT NULL ,
  `goalGuestHalftime` INT(11) UNSIGNED NULL DEFAULT NULL ,
  `judge` VARCHAR(30) NULL DEFAULT NULL ,
  `matchDate` DATE NULL DEFAULT NULL ,
  PRIMARY KEY (`turn`, `clubHome`) ,
  INDEX `clubHomeIndex` USING BTREE (`clubHome` ASC) ,
  INDEX `clubGuestIndex` USING BTREE (`clubGuest` ASC) ,
  INDEX `clubHomeForeignKey` (`clubHome` ASC) ,
  INDEX `clubGuestForeignKey` (`clubGuest` ASC) ,
  CONSTRAINT `clubHomeForeignKey`
    FOREIGN KEY (`clubHome` )
    REFERENCES `Club` (`name` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `clubGuestForeignKey`
    FOREIGN KEY (`clubGuest` )
    REFERENCES `Club` (`name` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------------
-- Inserting into Club
-- -----------------------------------------------------------
INSERT INTO `Club` 
(`championship`, `name`, `city`, `nationality`, `stadium`, `foundationYear`, `owner`, `capital`) 
VALUES
(5, 'DVSC', 'Debrecen', 'HU', 'Nagyerdei', '1902', 'Szita Gábor', 700000),
(3, 'Győri ETO', 'Győr', 'HU', 'Rábaparti', '1901', 'Aud Imre', 1000000),
(16, 'Austria Wien', 'Wien', 'A', 'Prater', '1898', 'Rudolf Schlossmayer', 4000000),
(0, 'FC Bonchida', 'Bonchida', 'RO', 'Legényes', '1921', 'Alois Picurca', 20000),
(1, 'Sturm Graz', 'Graz', 'A', 'Sturm', '1914', 'Robert Schumacher', 3000000),
(1, 'ZTE', 'Zalaegerszeg', 'HU', 'Őrségi', '1927', 'Sörös Imre', 600000);

-- -----------------------------------------------------------
-- Inserting into FootballMatch
-- -----------------------------------------------------------
INSERT INTO `Result` 
(`turn`, `clubHome`, `clubGuest`, `goalHome`, `goalGuest`, `goalHomeHalftime`, `goalGuestHalftime`, `judge`, `matchDate`) 
VALUES
(1, 'Sturm Graz', 'Győri ETO', 3, 0, 1, 0, 'Kassai', '2012-03-06'),
(1, 'Austria Wien', 'ZTE', 2, 2, 1, 0, 'Palotai', '2012-03-06'),
(1, 'DVSC', 'FC Bonchida', 1, 1, 1, 0, 'Bundás', '2012-03-06'),
(2, 'Sturm Graz', 'DVSC', 0, 1, 0, 0, 'SchwarzArbeiter', '2012-03-09'),
(2, 'FC Bonchida', 'Austria Wien', 2, 1, 2, 0, 'Palotai', '2012-03-09'),
(2, 'ZTE', 'Győri ETO', 1, 3, 1, 1, 'Kassai', '2012-03-10');
