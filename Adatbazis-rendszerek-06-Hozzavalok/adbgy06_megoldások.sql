-- ADATBÁZIS 2. levelező GYAK 2020
-- Vegyük a következő adatbázissémát (az adatbázis neve legyen `Hozzavalok`)! A mellékelt DOCX-ben van az adatbázis-séma. Másolja ki a következő részeket egy txt-be, s egy sima szöveget szerkesztő programmal (notepad a windows-on pl.) töltse ki válaszokkal, és a kitöltött válaszú txt tartalmát töltse vissza a megoldásához online szövegként, nem fájlfeltöltéssel! A szöveg jelenleg SQL kommentekből áll, simán be lehet vinni SQL szerkesztő ablakba, és kitöltögetni sorban. Elvárom, hogy a visszatöltött szöveg is MySQL szintaxis hiba nélküli legyen.


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 1. Adjon meg egy CREATE SCRIPTET a következőféleképpen: A látható kulcsok és idegen kulcsok is szerepeljenek (igeny.alapanyag→alapanyag.ID,
-- igeny.recept→recept.ID). Az a kívánalom is szerepeljen a leírásban, hogy a recept tábla `nev` mezője kötelezően megadandó, valamint, az az
-- alapanyag tábla `egysegar` mezője nemnegatív, 1 milliónál kisebb szám. A `mertekegyseg` alapértelmezett értéke legyen a ’dkg’ szöveg. Az (alapanyag,recept) összetett kulcsa  az igeny táblának- [5p+2p]]

DROP TABLE IF EXISTS igeny;
-- ez hivatkozik idegen kulccsal a többire, azokat nem lehetne törölni ettől

CREATE OR REPLACE TABLE alapanyag (
ID INT,
nev VARCHAR(45),
mertekegyseg VARCHAR(4) DEFAULT 'dkg',
egysegar INT CHECK(egysegar>=0 AND egysegar < 1000000),
romlando BOOLEAN,
PRIMARY KEY(ID)
);

CREATE OR REPLACE TABLE recept (
ID INTEGER,
nev VARCHAR(45) NOT NULL,
tipus VARCHAR(20),
haszonkulcs INTEGER,
PRIMARY KEY(ID)
);
CREATE TABLE igeny (
alapanyag INT,
recept INT,
PRIMARY KEY(alapanyag,recept),
FOREIGN KEY (alapanyag) REFERENCES alapanyag(ID),
FOREIGN KEY (recept) REFERENCES recept(ID)
);


-- Utólag adja hozzá az `igeny` táblára azt a feltételt, hogy a mennyiseg nem lehet
-- 200-nál nagyobb.[3p]
ALTER TABLE igeny ADD CHECK (mennyiseg<=200);


-- Adjon meg SQL standard vagy MySQL (húzza alá, melyik) lekérdezéseket a következő feladatok megoldására! Minden feladat ezután 5p.

-- 2. Listázza azon alapanyagok nevét és ID-ját, amit literben mérnek! ( ’l’ a mértékegység)

SELECT nev, ID
FROM alapanyag
WHERE mertekegyseg = 'l';

-- 3. Listázza azon alapanyagok nevét és ID-ját, amit literben mérnek, név szerint növekvőleg rendezve!
SELECT nev, ID
FROM alapanyag
WHERE mertekegyseg = 'l'
ORDER BY nev 
;



-- 4. Listázza, melyik alapanyag-ID hányszor szerepel az `igeny` táblában!
SELECT alapanyag, COUNT(*)
FROM igeny
WHERE 1
GROUP BY alapanyag;



-- 5. Listázza, melyik alapanyag-ID hányszor szerepel az `igeny` táblában, a szereplések száma szerint rendezve!
SELECT alapanyag, COUNT(*)
FROM igeny
WHERE 1
GROUP BY alapanyag
ORDER BY 2;



-- 6. Listázza, melyik 3 alapanyag-ID-szerepel a legtöbbször az `igeny` táblában,
SELECT alapanyag, COUNT(*)
FROM igeny
WHERE 1
GROUP BY alapanyag
ORDER BY 2 DESC LIMIT 3;


-- 7. Listázza, mely alapanyag-ID-k szerepelnek legalább háromszor az `igeny` táblában!
SELECT alapanyag, COUNT(*)
FROM igeny
WHERE 1
GROUP BY alapanyag
HAVING COUNT(*)>=3;

-- 8. Listázza, mely alapanyag-ID-k szerepelnek legalább háromszor az `igeny` táblában, de az alapanyagok nevét is listázza!
SELECT alapanyag, MIN(alapanyag.nev), COUNT(*)
FROM igeny JOIN alapanyag ON igeny.alapanyag=alapanyag.ID
WHERE 1
GROUP BY alapanyag
HAVING COUNT(*)>=3;

-- 9. Listázza, mely alapanyagok kellenek a ’bográncsgulyás’ nevű recepthez! Az alapanyagok ID-jét írassa ki!
SELECT igeny.alapanyag
FROM igeny JOIN recept ON igeny.recept=recept.ID
WHERE recept.nev='bográncsgulyás';

-- 10. Listázza, mely alapanyagok kellenek a ’bográncsgulyás’ nevű recepthez! Az alapanyagok nevét, mennyiségét és mértékegységét írassa ki!
SELECT igeny.alapanyag, alapanyag.nev,igeny.mertekegyseg, alapanyag.mertekegyseg
FROM (igeny JOIN recept ON igeny.recept=recept.ID) JOIN
      alapanyag ON igeny.recept=alapanyag.iD
WHERE recept.nev='bográncsgulyás';



-- 11. Listázza, melyik recepthez kell a legtöbb romlandó alapanyag! A recept nevét írassa ki! Ha több ilyen is van, elég egyet ezek közül.
SELECT MIN(recept.nev)
FROM (igeny JOIN recept ON igeny.recept=recept.ID) JOIN
      alapanyag ON igeny.recept=alapanyag.iD
WHERE romlando=1
GROUP BY igeny.recept
ORDER BY COUNT(*) DESC LIMIT 1


-- 12. Listázza, melyik recepthez kell a legtöbb romlandó alapanyag! A recept nevét írassa ki! Ha több ilyen is van, amihez egyforma számú kell, mindet írassa ki! Használjon beágyazott lekérdezést a darabszám meghatározásához!
SELECT MIN(recept.nev)
FROM (igeny JOIN recept ON igeny.recept=recept.ID) JOIN
      alapanyag ON igeny.recept=alapanyag.iD
WHERE romlando=1
GROUP BY igeny.recept
HAVING COUNT(*) =
(SELECT COUNT(*)
FROM (igeny JOIN recept ON igeny.recept=recept.ID) JOIN
      alapanyag ON igeny.recept=alapanyag.iD
WHERE romlando=1
GROUP BY igeny.recept
ORDER BY COUNT(*) DESC LIMIT 1
);


-- 13. Az olyan alapanyagoknál, ahol a mértékegység a ’l’, a mértékegységet változtassa ’lit’-ré.!
UPDATE alapanyag
SET mertekegyseg='lit'
WHERE mertekegyseg='l';


-- 14. Törölje azon recepteket, amikhez egyetlen alapanyag sem tartozik!
DELETE FROM recept
WHERE ID NOT IN (SELECT recept FROM igeny);


-- 15. Ha a igeny.recept→recept.ID idegenkulcs-hivatkozásra ON DELETE CASCADE módosító van rátéve, ON UPDATE módosító nincs rátéve, és a ’bográcsgulyás’ nevű receptnek 10 alapanyaga van bejegyezve az `igeny` táblában, és kiadjuk a DELETE FROM recept WHERE nev=’bográcsgulyás’ utasítást, akkor hány rekord törlődik, és miért annyi?
-- 1+10, a CASCADE miatt a zigeny táblából is törlődik 10 rekord.



-- 16. Ha összesen két recept van a recept táblában, az ID-jeik 2 és 3, és jön egy INSERT INTO recept(nev) VALUES (’1’); utasítás, utána hány rekord lesz? [Emlékeztető: ID kulcs, nev NOT NULL]. Miért?
-- Marad 2, mert nincs megadva kulcs, nem fogja beengedni a RDBMS az inzertet.


-- 17. Ha összesen két recept van a recept táblában, az ID-jeik 2 és 3, és jön egy INSERT INTO recept(ID,nev) VALUES (1,’3’); utasítás, utána hány rekord lesz ebben a táblában? [Emlékeztető: ID kulcs, nev NOT NULL]. Miért?
-- 3, mert itt meg van adva a kulcs, az különbözik az eddigiektől, és a nev tényleg nem NULL.


-- 18. Mi a különbség a UNIQUE és a PRIMARY KEY megszorítás között?
-- Választ ide: A UNIQUE mező lehet NULL, a P.K: nem.

-- 19. Ha R(A INTEGER PRIMARY KEY, B INTEGER) tábla tartalma jelenleg a [(1,2),(2,3)] sorok, akkor mi lesz az eredménye az
-- UPDATE R SET A=1 WHERE B=3; utasításnak, mi lesz a tábla új tartalma és miért?
-- Választ ide: duplicate entry in table R, duplikált kulcs miatt nem engedi be.

-- 20. Ha R(A INTEGER, B INTEGER, PRIMARY KEY(A,B)) tábla tartalma jelenleg a [(1,2),(2,3)] sorok, akkor mi lesz az eredménye az
-- UPDATE R SET A=1,B=A+4 WHERE B=3; utasításnak, mi lesz a tábla új tartalma és miért?
-- Választ ide: engedélyezett lesz a művelet, [(1,2),(1,5)]

-- 21. Ha R(A INTEGER, B INTEGER) tábla tartalma jelenleg a [(1,2),(2,3)] sorok, akkor mi lesz az eredménye az
-- UPDATE R SET A=A+B+1,B=A+B+1 WHERE B=3; utasításnak, mi lesz a tábla új tartalma és miért?
-- Eleme lesz egy olyan sor, amire teljesül R.A=R.B?
-- Választ ide: [(1,2),(6,10)], mert a második utasításban már A új értéke szerepel.

-- 22. Adjunk olyan nézettáblát, ami azt adja meg, hogy melyik alapanyag hány receptben fordul elő >10 mennyiségben.
CREATE VIEW n10 AS
SELECT alapanyag, MIN(alapanyag.nev), COUNT(*)
FROM igeny JOIN alapanyag ON igeny.alapanyag=alapanyag.ID
WHERE 1
GROUP BY alapanyag
HAVING COUNT(*)>10;