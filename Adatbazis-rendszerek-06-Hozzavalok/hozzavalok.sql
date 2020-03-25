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
    FOREIGN KEY (`alapanyag`) REFERENCES `alapanyag` (`ID`),
    FOREIGN KEY (`recept`) REFERENCES `recept` (`ID`)
);

ALTER TABLE igeny ADD PRIMARY KEY (alapanyag,recept);

-- Utólag adja hozzá az `igeny` táblára azt a feltételt, hogy a mennyiseg nem lehet
-- 200-nál nagyobb.
ALTER TABLE igeny ADD CHECK (igeny.mennyiseg>=200);


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
SELECT alapanyag from igeny GROUP BY 1 HAVING COUNT(*) >= 2

-- 8. Listázza, mely alapanyag-ID-k szerepelnek legalább háromszor az `igeny` táblában, de az alapanyagok nevét is listázza!
SELECT igeny.alapanyag, alapanyag.nev, COUNT(*) FROM (igeny JOIN alapanyag on igeny.alapanyag = alapanyag.ID) GROUP BY igeny.alapanyag HAVING COUNT(*)>=3

-- 9. Listázza, mely alapanyagok kellenek a ’bográncsgulyás’ nevű recepthez! Az alapanyagok ID-jét írassa ki!
SELECT alapanyag.nev FROM alapanyag JOIN igeny ON igeny.alapanyag = alapanyag.ID JOIN recept ON recept.ID = igeny.recept WHERE recept.nev = 'bográncsgulyás';

-- 10. Listázza, mely alapanyagok kellenek a ’bográncsgulyás’ nevű recepthez! Az alapanyagok nevét, mennyiségét és mértékegységét írassa ki!

-- 11. Listázza, melyik recepthez kell a legtöbb romlandó alapanyag! A recept nevét írassa ki! Ha több ilyen is van, elég egyet ezek közül.

-- 12. Listázza, melyik recepthez kell a legtöbb romlandó alapanyag! A recept nevét írassa ki! Ha több ilyen is van, amihez egyforma számú kell, mindet írassa ki! Használjon beágyazott lekérdezést a darabszám meghatározásához!

-- 13. Az olyan alapanyagoknál, ahol a mértékegység a ’l’, a mértékegységet változtassa ’liter’-ré.!

-- 14. Törölje azon recepteket, amikhez egyetlen alapanyag sem tartozik!

-- 15. Ha a igeny.recept→recept.ID idegenkulcs-hivatkozásra ON DELETE CASCADE módosító van rátéve, ON UPDATE módosító nincs rátéve, és a ’bográcsgulyás’ nevű receptnek 10 alapanyaga van bejegyezve az `igeny` táblában, és kiadjuk a DELETE FROM recept WHERE nev=’bográcsgulyás’ utasítást, akkor hány rekord törlődik, és miért annyi?

-- 16. Ha összesen két recept van a recept táblában, az ID-jeik 2 és 3, és jön egy INSERT INTO recept(nev) VALUES (’1’); utasítás, utána hány rekord lesz? [Emlékeztető: ID kulcs, nev NOT NULL]. Miért?

-- 17. Ha összesen két recept van a recept táblában, az ID-jeik 2 és 3, és jön egy INSERT INTO recept(ID,nev) VALUES (1,’3’); utasítás, utána hány rekord lesz ebben a táblában? [Emlékeztető: ID kulcs, nev NOT NULL]. Miért?

-- 18. Mi a különbség a UNIQUE és a PRIMARY KEY megszorítás között?
-- Választ ide:

-- 19. Ha R(A INTEGER PRIMARY KEY, B INTEGER) tábla tartalma jelenleg a [(1,2),(2,3)] sorok, akkor mi lesz az eredménye az
-- UPDATE R SET A=1 WHERE B=3; utasításnak, mi lesz a tábla új tartalma és miért?
-- Választ ide:

-- 20. Ha R(A INTEGER, B INTEGER, PRIMARY KEY(A,B)) tábla tartalma jelenleg a [(1,2),(2,3)] sorok, akkor mi lesz az eredménye az
-- UPDATE R SET A=1,B=A+4 WHERE B=3; utasításnak, mi lesz a tábla új tartalma és miért?
-- Választ ide:

-- 21. Ha R(A INTEGER, B INTEGER) tábla tartalma jelenleg a [(1,2),(2,3)] sorok, akkor mi lesz az eredménye az
-- UPDATE R SET A=A+B+1,B=A+B+1 WHERE B=3; utasításnak, mi lesz a tábla új tartalma és miért?
-- Eleme lesz egy olyan sor, amire teljesül R.A=R.B?
-- Választ ide:

-- 22. Adjunk olyan nézettáblát, ami azt adja meg, hogy melyik alapanyag hány receptben fordul elő >10 mennyiségben.
