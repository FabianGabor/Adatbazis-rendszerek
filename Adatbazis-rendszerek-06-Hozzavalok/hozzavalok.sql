-- Fábián Gábor
-- CXNU8T
-- https://github.com/FabianGabor/Adatbazis-rendszerek/blob/master/Adatbazis-rendszerek-06-Hozzavalok/hozzavalok.sql

-- 1. Adjon meg egy CREATE SCRIPTET a következőféleképpen: 
-- A látható kulcsok és idegen kulcsok is szerepeljenek (igeny.alapanyag→alapanyag.ID, igeny.recept→recept.ID). 
-- Az a kívánalom is szerepeljen a leírásban, hogy a recept tábla `nev` mezője kötelezően megadandó, valamint, az az
-- alapanyag tábla `egysegar` mezője nemnegatív, 1 milliónál kisebb szám. 
-- A `mertekegyseg` alapértelmezett értéke legyen a ’dkg’ szöveg. 
-- Az (alapanyag,recept) összetett kulcsa  az igeny táblának

CREATE TABLE IF NOT EXISTS alapanyag (
    ID int not null primary key,
    nev varchar(45) not null,
    mertekegyseg varchar(4) not null default 'dkg',
    egysegar int unsigned CHECK (egysegar < 1000000),
    romlando boolean
);

CREATE TABLE IF NOT EXISTS recept (
    ID int not null PRIMARY KEY,
    nev varchar(45) not null,
    tipus varchar(20),
    haszonkulcs int
);

CREATE TABLE IF NOT EXISTS igeny (
    alapanyag int not null,
    recept int not null,
    mennyiseg int,
    CONSTRAINT fk_alapanyag FOREIGN KEY igeny(alapanyag) REFERENCES alapanyag(ID),
    CONSTRAINT fk_recept FOREIGN KEY igeny(recept) REFERENCES recept(ID) 
);

-- ALTER TABLE igeny ADD CONSTRAINT fk_alapanyag FOREIGN KEY igeny(alapanyag) REFERENCES alapanyag(ID) 
-- ALTER TABLE igeny ADD CONSTRAINT fk_recept FOREIGN KEY igeny(recept) REFERENCES recept(ID) 

ALTER TABLE igeny ADD PRIMARY KEY (alapanyag,recept);

-- Utólag adja hozzá az `igeny` táblára azt a feltételt, hogy a mennyiseg nem lehet
-- 200-nál nagyobb.
ALTER TABLE igeny ADD CHECK (igeny.mennyiseg>=200);

-- Adjon meg SQL standard vagy MySQL (húzza alá, melyik) lekérdezéseket a következő feladatok megoldására! Minden feladat ezután 5p.
-- Ezt a kérést nem igazán értem. SQL a nyelvezet, a MySQL egy szoftver, amely az SQL nyelvezetet használja. Amennyiben a tanár úr arra gondolt, hogy a használt SQL lekérdezések az Oracle/PostreSQL vagy MySQL által támogatottak, akkor ez esetben a válasz: MariaDB / MySQL

-- 2. Listázza azon alapanyagok nevét és ID-ját, amit literben mérnek! ( ’l’ a mértékegység)
SELECT id, nev from alapanyag where mertekegyseg = 'l';

-- 3. Listázza azon alapanyagok nevét és ID-ját, amit literben mérnek, név szerint növekvőleg rendezve!
SELECT id, nev from alapanyag where mertekegyseg = 'l' ORDER BY nev ASC;

-- 4. Listázza, melyik alapanyag-ID hányszor szerepel az `igeny` táblában!
SELECT alapanyag, count(*) from igeny GROUP by 1;

-- 5. Listázza, melyik alapanyag-ID hányszor szerepel az `igeny` táblában, a szereplések száma szerint rendezve!
SELECT alapanyag, count(*) from igeny GROUP by 1 ORDER BY 2;

-- 6. Listázza, melyik 3 alapanyag-ID-szerepel a legtöbbször az `igeny` táblában,
SELECT alapanyag from igeny GROUP by 1 ORDER BY COUNT(*) DESC LIMIT 3;

-- 7. Listázza, mely alapanyag-ID-k szerepelnek legalább háromszor az `igeny` táblában!
SELECT alapanyag from igeny GROUP BY 1 HAVING COUNT(*) >= 2;

-- 8. Listázza, mely alapanyag-ID-k szerepelnek legalább háromszor az `igeny` táblában, de az alapanyagok nevét is listázza!
SELECT igeny.alapanyag, alapanyag.nev, COUNT(*) FROM (igeny JOIN alapanyag on igeny.alapanyag = alapanyag.ID) GROUP BY igeny.alapanyag HAVING COUNT(*)>=3;

-- 9. Listázza, mely alapanyagok kellenek a ’bográncsgulyás’ nevű recepthez! Az alapanyagok ID-jét írassa ki!
SELECT alapanyag.ID FROM alapanyag JOIN igeny ON igeny.alapanyag = alapanyag.ID JOIN recept ON recept.ID = igeny.recept WHERE recept.nev = 'bográncsgulyás';

-- 10. Listázza, mely alapanyagok kellenek a ’bográncsgulyás’ nevű recepthez! Az alapanyagok nevét, mennyiségét és mértékegységét írassa ki!
SELECT alapanyag.nev,igeny.mennyiseg,alapanyag.mertekegyseg FROM alapanyag JOIN igeny ON igeny.alapanyag = alapanyag.ID JOIN recept ON recept.ID = igeny.recept WHERE recept.nev = 'bográncsgulyás';


-- 11. Listázza, melyik recepthez kell a legtöbb romlandó alapanyag! A recept nevét írassa ki! Ha több ilyen is van, elég egyet ezek közül.
SELECT recept.nev FROM alapanyag JOIN igeny ON igeny.alapanyag = alapanyag.ID JOIN recept ON recept.ID = igeny.recept WHERE alapanyag.romlando = 1 GROUP BY 1 ORDER BY COUNT(alapanyag.romlando) DESC LIMIT 1;

-- 12. Listázza, melyik recepthez kell a legtöbb romlandó alapanyag! A recept nevét írassa ki! Ha több ilyen is van, amihez egyforma számú kell, mindet írassa ki! Használjon beágyazott lekérdezést a darabszám meghatározásához!
SELECT *
	FROM	
	(SELECT recept.nev, SUM(alapanyag.romlando) as TotalRomlando FROM alapanyag JOIN igeny ON igeny.alapanyag = alapanyag.ID JOIN recept ON recept.ID = igeny.recept GROUP BY 1 ORDER BY COUNT(alapanyag.romlando) DESC) AS T
    WHERE T.TotalRomlando = (SELECT 2 FROM (SELECT recept.nev, SUM(alapanyag.romlando) FROM alapanyag JOIN igeny ON igeny.alapanyag = alapanyag.ID JOIN recept ON recept.ID = igeny.recept GROUP BY 1 ORDER BY 2 DESC LIMIT 1) AS SUMMA);

-- 13. Az olyan alapanyagoknál, ahol a mértékegység a ’l’, a mértékegységet változtassa ’liter’-ré.!
ALTER TABLE alapanyag MODIFY mertekegyseg VARCHAR(5);
update alapanyag set mertekegyseg='liter' where mertekegyseg='l';

-- 14. Törölje azon recepteket, amikhez egyetlen alapanyag sem tartozik!
DELETE FROM recept WHERE ID = (SELECT ID FROM recept WHERE NOT EXISTS (SELECT * FROM igeny WHERE igeny.recept = recept.ID));
--
DELETE FROM recept WHERE ID NOT IN (SELECT recept FROM igeny);

-- 15. Ha a igeny.recept→recept.ID idegenkulcs-hivatkozásra ON DELETE CASCADE módosító van rátéve, ON UPDATE módosító nincs rátéve, és a ’bográcsgulyás’ nevű receptnek 10 alapanyaga van bejegyezve az `igeny` táblában, és kiadjuk a DELETE FROM recept WHERE nev=’bográcsgulyás’ utasítást, akkor hány rekord törlődik, és miért annyi?
-- 1+10 a CASCADE miatt az igeny tablabol is torlodik 10 rekord

-- 16. Ha összesen két recept van a recept táblában, az ID-jeik 2 és 3, és jön egy INSERT INTO recept(nev) VALUES (’1’); utasítás, utána hány rekord lesz? [Emlékeztető: ID kulcs, nev NOT NULL]. Miért?
-- 2 recept, mert ID értéke nincs meghatározva az utasításban, ezenfelül a ’ karakter nem az érték idézőjele, a helyes karakter az ' ezért a VALUES (’1’) az 1-es nevű oszlopra hivatkozik, ami nem létezik.

-- 17. Ha összesen két recept van a recept táblában, az ID-jeik 2 és 3, és jön egy INSERT INTO recept(ID,nev) VALUES (1,’3’); utasítás, utána hány rekord lesz ebben a táblában? [Emlékeztető: ID kulcs, nev NOT NULL]. Miért?
-- Ugyancsak 2, mert a ’3’ a 3-as nevű oszlopra hivatkozik, ami nem létezik. Ha VALUES (1,'3'), azaz ' van használva idézőjelként, akkor helyes az utasítás, és ebben az esetben hozzá lesz adva a táblához, 3 rekordot eredményezve.

-- 18. Mi a különbség a UNIQUE és a PRIMARY KEY megszorítás között?
-- Választ ide:
-- A PRIMARY KEY egyedi értékeket kell tartalmazzon.
-- Primary key nem lehet NULL értékű, a UNIQUE kulcs egyetlen NULL értéket felvehet.

-- 19. Ha R(A INTEGER PRIMARY KEY, B INTEGER) tábla tartalma jelenleg a [(1,2),(2,3)] sorok, akkor mi lesz az eredménye az
-- UPDATE R SET A=1 WHERE B=3; utasításnak, mi lesz a tábla új tartalma és miért?
-- Választ ide: Hiba, mert [(1,2),(1,3)] lenne az eredmény, viszont csak az A oszlop PRIMARY KEY, ezért duplikált elsődleges kulcsot eredményezne.

-- 20. Ha R(A INTEGER, B INTEGER, PRIMARY KEY(A,B)) tábla tartalma jelenleg a [(1,2),(2,3)] sorok, akkor mi lesz az eredménye az
-- UPDATE R SET A=1,B=A+4 WHERE B=3; utasításnak, mi lesz a tábla új tartalma és miért?
-- Választ ide: [(1,2),(1,5)] mert A és B oszlop is PRIMARY KEY, ezért a kulcspárok különböznek.

-- 21. Ha R(A INTEGER, B INTEGER) tábla tartalma jelenleg a [(1,2),(2,3)] sorok, akkor mi lesz az eredménye az
-- UPDATE R SET A=A+B+1,B=A+B+1 WHERE B=3; utasításnak, mi lesz a tábla új tartalma és miért?
-- Eleme lesz egy olyan sor, amire teljesül R.A=R.B?
-- Választ ide: [(1,2),(6,10)] mert először az A=A+B+1 kerül elvézgésre, majd ennek az A-nak az értéke kerül a B=A+B+1 értékadásba. B = A + 2*B + 2 = A + 2 * (B+1) == A csak akkor teljesülhet, ha alaphelyzetbenb B=-1, de akkor viszont az UPDATE nem kerül végrehajtásra, mert a feltétel WHERE B=3.

-- 22. Adjunk olyan nézettáblát, ami azt adja meg, hogy melyik alapanyag hány receptben fordul elő >10 mennyiségben.
SELECT alapanyag.nev, COUNT(igeny.recept) FROM alapanyag JOIN igeny ON igeny.alapanyag = alapanyag.ID JOIN recept ON recept.ID = igeny.recept GROUP BY 1 HAVING COUNT(igeny.recept) > 10;

-- CREATE VIEW n10 AS SELECT alapanyag.nev, COUNT(igeny.recept) FROM igeny JOIN alapanyag ON igeny.alapanyag=alapanyag.ID WHERE 1 GROUP BY 1 HAVING COUNT(igeny.recept)>10;
