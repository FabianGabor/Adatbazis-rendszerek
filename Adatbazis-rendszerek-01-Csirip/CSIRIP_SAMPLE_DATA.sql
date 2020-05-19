-- Csirip adatbázis eldobása, létrehozása és használata

DROP DATABASE Csirip;


CREATE DATABASE Csirip DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;
USE Csirip;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `felhasznalo`
--

CREATE OR REPLACE TABLE `felhasznalo` (
  `nev` VARCHAR(30) NOT NULL,
  `keresztNev` VARCHAR(30)  DEFAULT NULL,
  `vezetekNev` VARCHAR(30)  DEFAULT NULL,
  `regDatum` DATE NOT NULL,
  `email` VARCHAR(60) NOT NULL,
  `szulEv` INTEGER DEFAULT NULL,
  `varos` VARCHAR(30) DEFAULT NULL,
  `noE` BOOLEAN DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `felhasznalo`
--

INSERT INTO `felhasznalo` (`nev`, `keresztNev`, `vezetekNev`, `regDatum`, `email`, `szulEv`, `varos`, `noE`) VALUES
('dirtyred', 'Gábor', 'Fábián', '2007-11-26', 'info@fabiangabor.com', 1987, 'Marosvásárhely', 0),
('america1', 'Donald', 'Rumpt', '2018-01-01', 'rump@usagov.com', 1930, 'Debrecen', 0),
('bb', 'Béla', 'Bartók', '2018-01-10', 'bb@gmail.com', 1881, 'Nyíregyháza', 0),
('Dr', 'Doctor', 'Rey', '2018-01-04', 'dr@gmail.com', 1989, 'Nyíregyháza', 0),
('gabi', 'Gabi', 'Kiss', '2018-02-01', 'gabi@gabi.hu', 2001, 'Nyíregyháza', NULL),
('GunnerofGod', 'Gunner', 'ofGod', '2018-03-01', 'gunnerofgod@gmail.com', 1997, 'Nyíregyháza', 0),
('jani', 'János', 'Nagy', '2018-01-20', 'jackie@gmail.com', 1998, 'Nyíregyháza', 0),
('jc', 'Cena', 'John', '2018-03-20', 'jc@gmail.com', 1985, 'Debrecen', 0),
('jdoe', 'Doe', 'John', '2018-02-14', 'johndoe@gmail.com', 1988, 'Miskolc', 0),
('JonnJonzz', 'Vilmos', 'Nagy', '2018-03-09', 'jonn@gmail.com', 1990, 'Nyíregyháza', 0),
('karak2', 'Karak', 'Terek', '2018-02-28', 'karak@gmail.com', 1968, 'Budapest', NULL),
('kerzsi', 'Erzsébet', 'Kovács', '2018-03-07', 'kerzsi@gmail.com', 1998, 'Debrecen', 1),
('krixkrax', 'Lakatos', 'Favágó', '2018-03-02', 'favago007@gmail.com', 1994, 'Nyíregyháza', 0),
('mickey', 'Mickey', 'Mouse', '2018-02-26', 'mickey@gmail.com', 1990, 'Nyíregyháza', NULL),
('miertkell', 'Miertkell', 'Angela', '2018-01-02', 'miertkell@obersturmbahnfuhrerin.de', 1950, 'Miskolc', NULL),
('pok', 'spider', 'man', '2018-01-01', 'spider.man@gmail.com', 1940, 'Nyíregyháza', 0),
('polgarmesterur', 'Jenő', 'Polgár', '2018-03-01', 'jeno@gmail.com', 1980, 'Debrecen', 0),
('r2d2', 'd2', 'r2', '2018-01-01', 'r2d2@falcon.com', 1990, 'Miskolc', 0),
('remlek', 'Elek', 'Remek', '2018-01-02', 'remlek@hotmail.com', 1994, 'Miskolc', 0),
('sbela', 'Béla', 'Savó', '2018-01-31', 'sbela@freemail.hu', 2000, 'Miskolc', 0),
('spongyabob', 'Spongyabob', 'Kockanadrág', '2018-02-02', 'spogyabob@gmail.com', 1981, 'Nyíregyháza', 0),
('vuk', 'Vuk', 'Rókavári', '2018-02-21', 'vuk@hotmail.com', 1980, 'Budapest', 0);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `csirip`
--


CREATE OR REPLACE TABLE `csirip` (
  `ID` int(11) NOT NULL,
  `szoveg` varchar(160) NOT NULL,
  `felkuldo` VARCHAR(30) NOT NULL,
  `datum` DATE NOT NULL,
  `visszavonvaE` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `csirip`
--

INSERT INTO `csirip` (`ID`, `szoveg`, `felkuldo`, `datum`, `visszavonvaE`) VALUES
(1, 'péntek', 'kerzsi', '2018-03-09', NULL),
(2, 'szombat', 'sbela', '2018-03-09', NULL),
(3, 'helló', 'kerzsi', '2018-03-09', NULL),
(4, 'Féljétek nevem', 'GunnerofGod', '2018-03-09', NULL),
(5, 'vasárnap', 'bb', '2018-03-02', NULL),
(6, 'and his name is John Cena', 'jc', '2018-05-10', NULL),
(7, 'Jani menj ki a szobából!', 'jc', '2018-03-20', NULL),
(8, 'sumbalasumbalabumm', 'krixkrax', '2018-03-08', NULL),
(9, 'Kész vagyok!', 'spongyabob', '2018-03-04', NULL),
(10, 'medúzavadászat', 'spongyabob', '2018-03-07', NULL),
(11, 'Sziasztoook!', 'pok', '2018-03-08', NULL),
(12, 'Vicces', 'karak2', '2018-03-03', NULL),
(13, 'Eltaposott a cipő', 'pok', '2018-03-03', NULL),
(14, 'Fürge rókalábak', 'vuk', '1980-03-01', 0),
(15, 'kis vörös róka', 'vuk', '1980-03-02', 1),
(16, 'karak2 okos', 'vuk', '1980-03-03', NULL),
(17, 'bip', 'r2d2', '2018-02-01', NULL),
(18, 'iiii', 'r2d2', '2018-03-02', NULL),
(19, 'egy szöveg', 'JonnJonzz', '2018-03-09', NULL),
(20, 'BÚZATÁROLÓ', 'jc', '2018-03-29', NULL),
(21, 'Valamikor', 'jani', '2018-03-26', NULL),
(22, 'Haha', 'jani', '2018-03-28', NULL),
(23, 'Sok kell még', 'krixkrax', '2018-03-07', NULL),
(24, 'hakuna matata', 'polgarmesterur', '2018-03-04', NULL),
(25, 'It\'s OOON', 'jani', '2018-04-04', NULL),
(26, 'nem vagyok én pókembör', 'jc', '2018-04-10', NULL),
(27, 'haha', 'Dr', '2018-01-06', NULL),
(28, 'Péntek az én napom', 'JonnJonzz', '2018-03-02', NULL),
(29, 'Széttörtem a csónakmobilt!', 'spongyabob', '2018-03-08', NULL),
(30, '5 perccel később...', 'spongyabob', '2018-03-09', NULL),
(31, 'kizárt dolog mert nem tudom', 'polgarmesterur', '2018-03-04', NULL),
(32, 'Valami', 'mickey', '2018-03-06', NULL),
(33, 'Hol volt, hol nem volt...', 'mickey', '2018-03-09', NULL),
(34, 'Holnap?', 'jani', '2018-04-26', NULL),
(35, 'Ide mit kell írni?!?Help!!', 'jani', '2018-05-06', NULL),
(36, '10:10:10 van :)', 'spongyabob', '2018-03-09', NULL),
(37, 'Hogy hívják a kínai tűzoltót?', 'pok', '2018-03-03', NULL),
(38, 'TELEFONON', 'pok', '2018-03-03', NULL),
(39, 'Legyen', 'GunnerofGod', '2018-03-09', NULL),
(40, 'Tánc', 'GunnerofGod', '2018-03-09', NULL),
(41, 'Jani vagyok..megint', 'jani', '2018-03-03', NULL),
(42, 'Talán', 'jani', '2018-01-29', NULL),
(43, 'Adatbázis jeles a zsebben', 'jani', '2018-05-20', NULL),
(44, 'Hardmode', 'JonnJonzz', '2018-03-05', NULL),
(45, 'Mégsem..', 'jani', '2018-05-21', NULL),
(46, 'Sok kell még?', 'GunnerofGod', '2018-03-09', NULL),
(47, 'De miért?', 'GunnerofGod', '2018-03-01', NULL),
(48, 'Én vagyok, a kasszás Erzsi', 'kerzsi', '2017-05-05', NULL),
(49, 'Hol a vége?', 'kerzsi', '2018-09-05', NULL),
(50, 'Itt a vége', 'mickey', '2018-12-31', NULL),
(51, 'Mivaaaaaan?', 'jc', '2018-05-20', NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kedvel`
--

CREATE OR REPLACE TABLE `kedvel` (
  `ki` VARCHAR(30)  NOT NULL,
  `mit` INTEGER NOT NULL,
  `mikor` DATE DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `kedvel`
--

INSERT INTO `kedvel` (`ki`, `mit`, `mikor`) VALUES
('sbela', 1, '2018-03-09'),
('GunnerofGod', 4, '2018-03-09'),
('GunnerofGod', 9, '2018-03-09'),
('pok', 12, '2018-03-04'),
('spongyabob', 14, '2018-03-09'),
('karak2', 13, '2018-03-05'),
('krixkrax', 7, '2018-03-08'),
('spongyabob', 17, '2018-03-09'),
('Dr', 35, '2018-05-09'),
('r2d2', 4, '2018-03-10'),
('r2d2', 25, '2018-04-05'),
('vuk', 17, '2018-03-09'),
('vuk', 18, '2018-03-09'),
('vuk', 24, '2018-03-09'),
('jani', 34, '2018-05-02'),
('jc', 25, '2018-03-21'),
('jc', 29, '2018-03-21'),
('GunnerofGod', 42, '2018-03-09'),
('spongyabob', 32, '2018-03-09'),
('spongyabob', 35, '2018-03-09'),
('GunnerofGod', 48, '2018-03-09'),
('r2d2', 31, '2018-03-05'),
('jc', 35, '2018-03-22'),
('jc', 50, '2018-03-25'),
('JonnJonzz', 50, '2018-03-01'),
('polgarmesterur', 22, '2018-03-04'),
('Dr', 50, '2018-12-31'),
('jani', 48, '2018-03-09'),
('polgarmesterur', 1, '2018-03-04'),
('spongyabob', 18, '2018-03-03'),
('krixkrax', 20, '2018-03-09'),
('jani', 11, '2018-03-08'),
('mickey', 31, '2018-03-09'),
('mickey', 48, '2018-03-09'),
('mickey', 26, '2018-03-09'),
('JonnJonzz', 27, '2018-03-08'),
('JonnJonzz', 14, '2018-03-09'),
('vuk', 37, '2018-05-05'),
('vuk', 38, '2018-05-05'),
('spongyabob', 38, '2018-03-09'),
('jc', 49, '2018-10-30');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kovet`
--

CREATE OR REPLACE TABLE `kovet` (
  `ki` VARCHAR(30) NOT NULL,
  `kit` VARCHAR(30) NOT NULL,
  `mikor` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `kovet`
--

INSERT INTO `kovet` (`ki`, `kit`, `mikor`) VALUES
('kerzsi', 'sbela', '2018-03-07'),
('vuk', 'karak2', '2018-03-07'),
('vuk', 'remlek', '2018-03-07'),
('vuk', 'spongyabob', '2018-03-07'),
('vuk', 'vuk', '2018-03-07'),
('GunnerofGod', 'GunnerofGod', '2018-03-08'),
('karak2', 'pok', '2018-03-01'),
('bb', 'r2d2', '2018-03-08'),
('jc', 'karak2', '2018-01-01'),
('bb', 'jdoe', '2018-03-05'),
('spongyabob', 'r2d2', '2018-01-01'),
('spongyabob', 'vuk', '2018-02-03'),
('r2d2', 'bb', '2018-01-11'),
('r2d2', 'jc', '2018-03-21'),
('r2d2', 'polgarmesterur', '2018-03-02'),
('krixkrax', 'spongyabob', '2018-03-07'),
('spongyabob', 'krixkrax', '2018-03-07'),
('karak2', 'spongyabob', '2018-03-02'),
('jc', 'vuk', '2018-01-01'),
('karak2', 'vuk', '2018-04-04'),
('jdoe', 'bb', '2018-03-02'),
('GunnerofGod', 'spongyabob', '2018-03-01'),
('jc', 'spongyabob', '2010-01-01'),
('JonnJonzz', 'Dr', '2018-03-01'),
('JonnJonzz', 'r2d2', '2018-02-28'),
('JonnJonzz', 'pok', '2018-03-07'),
('pok', 'karak2', '2015-05-05'),
('Dr', 'pok', '2018-01-05'),
('jc', 'Dr', '2011-11-11'),
('jani', 'r2d2', '2018-02-28'),
('jani', 'spongyabob', '2018-03-03'),
('spongyabob', 'pok', '2018-01-06'),
('mickey', 'vuk', '2018-02-27'),
('mickey', 'spongyabob', '2018-02-28'),
('mickey', 'pok', '2018-03-01'),
('polgarmesterur', 'vuk', '2018-03-03'),
('polgarmesterur', 'spongyabob', '2018-03-04'),
('polgarmesterur', 'r2d2', '2018-03-04'),
('spongyabob', 'polgarmesterur', '2018-03-06');

-- --------------------------------------------------------

ALTER TABLE felhasznalo ADD PRIMARY KEY (nev);
ALTER TABLE csirip ADD PRIMARY KEY (ID);
ALTER TABLE felhasznalo ADD UNIQUE (email);

--ALTER TABLE csirip ADD FOREIGN KEY (felkuldo) REFERENCES felhasznalo(nev) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE csirip ADD FOREIGN KEY (felkuldo) REFERENCES felhasznalo(nev) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE csirip ADD CONSTRAINT `fk_felkuldo` FOREIGN KEY (felkuldo) REFERENCES felhasznalo(nev) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE kovet ADD FOREIGN KEY (ki) REFERENCES felhasznalo(nev)  ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE kovet ADD FOREIGN KEY (kit) REFERENCES felhasznalo(nev) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE kedvel ADD FOREIGN KEY (ki) REFERENCES felhasznalo(nev) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE kedvel ADD FOREIGN KEY (mit) REFERENCES csirip(ID) ON UPDATE CASCADE ON DELETE CASCADE;
