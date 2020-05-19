CREATE OR REPLACE TABLE tankonyv (
    sorszam int(11),
    nev varchar(20) not null,
    ar float CHECK (ar>0),
    oldalszam int(11),
    ev int(11)
);

CREATE OR REPLACE TABLE konyvigeny (
    tankonyv int(11),
    tantargy int(11)
);

CREATE OR REPLACE TABLE tantargy (
    id int(11) PRIMARY KEY,
    nev varchar(20),
    kredit int(11),
    gyakOraszam int(11),
    elmOraszam int(11)
);

CREATE OR REPLACE TABLE szak (
    kod int(11) PRIMARY KEY,
    nev varchar(20),
    kreditOsszeg int(11) CHECK (kreditOsszeg>180 OR nev = 'büfé')
);

CREATE OR REPLACE TABLE tanterv (
    targy int(11),
    szak int(11),
    kotelezo tinyint(1),
    CONSTRAINT fk_targy FOREIGN KEY (targy) REFERENCES tantargy(id),
    CONSTRAINT fk_szak FOREIGN KEY (szak) REFERENCES szak(kod)
);

-- 2
ALTER TABLE tankonyv ADD PRIMARY KEY (sorszam);
ALTER TABLE konyvigeny ADD CONSTRAINT fk_tankonyv FOREIGN KEY (tankonyv) REFERENCES tankonyv(sorszam);
ALTER TABLE konyvigeny ADD CONSTRAINT fk_tantargy FOREIGN KEY (tantargy) REFERENCES tantargy(id);

-- ZH
-- 1
SELECT tantargy.nev FROM tantargy JOIN konyvigeny ON tantargy.id = konyvigeny.tantargy JOIN tankonyv ON konyvigeny.tankonyv = tankonyv.sorszam WHERE tankonyv.ev < 1980 GROUP BY 1;

-- 2
SELECT tantargy.nev FROM tantargy JOIN konyvigeny ON tantargy.id = konyvigeny.tantargy JOIN tankonyv ON konyvigeny.tankonyv = tankonyv.sorszam WHERE tankonyv.ev < 1980 GROUP BY 1;

-- 3
CREATE TABLE tankonyv (
sorszam int(11) PRIMARY KEY,
nev varchar(20) CHECK(LENGHT(nev)>=5),
ar float CHECK (ar<=5000 OR oldalszam>=800),
ev int(11) DEFAULT 2020,
oldalszam int(11) NOT NULL
);

-- 6
SELECT tantargy.nev, COUNT(*) FROM tantargy JOIN konyvigeny ON tantargy.id = konyvigeny.tantargy GROUP BY 1;

-- 7
SELECT nev, sorszam from tankonyv WHERE (ar>2000 AND oldalszam<200);

-- 8
UPDATE tankonyv SET ar = ar * 0.9 WHERE sorszam IN (SELECT tankonyv FROM konyvigeny JOIN tantargy ON tantargy.id = konyvigeny.tankonyv WHERE nev = 'algebra');

-- 9
SELECT nev FROM tankonyv WHERE oldalszam / ar > 5;

-- 10
SELECT nev,
CASE 
WHEN gyakOraszam > elmOraszam THEN 'gyaktobb'
WHEN gyakOraszam < elmOraszam THEN 'elmtobb'
ELSE 'egyenlo' END as 'Tobb'
FROM tantargy;

-- 11
SELECT tantargy.nev, COUNT(*) FROM tantargy JOIN konyvigeny ON tantargy.id = konyvigeny.tantargy JOIN tankonyv ON konyvigeny.tankonyv = tankonyv.sorszam WHERE tankonyv.ev < 1980 GROUP BY 1;

-- 12
SELECT tantargy.nev, COUNT(*) FROM tantargy JOIN konyvigeny ON tantargy.id = konyvigeny.tantargy JOIN tankonyv ON konyvigeny.tankonyv = tankonyv.sorszam GROUP BY 1;

-- 13
SELECT tantargy.nev, tantargy.kredit FROM tantargy JOIN tanterv ON tantargy.id = tanterv.targy JOIN szak ON tanterv.szak = szak.kod WHERE kod = 66;

-- 15
-- SELECT nev, COUNT(*) FROM recept JOIN igeny ON recept.id = igeny.recept GROUP BY 1 HAVING COUNT(nev) > 3 
SELECT nev FROM tantargy JOIN konyvigeny on tantargy.id = konyvigeny.tantargy WHERE COUNT(konyvigeny.tantargy)>3;


-- 16
CREATE TEMPORARY TABLE tmp AS SELECT * FROM tantargy JOIN tanterv ON tantargy.id = tanterv.targy;
ALTER TABLE tmp DROP COLUMN kotelezo;
SELECT * FROM tmp;
DROP TABLE tmp;

-- vagy: 
SELECT tantargy.nev, tanterv.targy, tanterv.szak FROM tantargy JOIN tanterv ON tantargy.id = tanterv.targy;

-- 17
SELECT nev FROM tankonyv WHERE ar>2000;

-- 18
DELETE FROM tankonyv WHERE oldalszam > 2000;


