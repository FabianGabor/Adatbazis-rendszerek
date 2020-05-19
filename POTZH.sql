CREATE OR REPLACE TABLE `osztaly` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nev` char(20)  
);

CREATE OR REPLACE TABLE `dolgozo` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `osztalykod` int(11),
  `ferfie` tinyint(1),
  FOREIGN KEY (osztalykod) REFERENCES osztaly(id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

INSERT INTO `osztaly` (`nev`) VALUES
('osztaly csak ferfi'),
('osztaly vegyes'),
('osztaly csak no');

INSERT INTO `dolgozo` (`osztalykod`, `ferfie`) VALUES
(1, 1),
(1, 1),
(2, 0),
(2, 1),
(3, 0),
(3, 0);
