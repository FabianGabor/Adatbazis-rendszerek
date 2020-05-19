-- Az eddig is használt receptes adatbázisban:
-- 25. Adjon olyan függvényt, ami minden alapanyag id-hoz visszaadja, hány receptben szerepel.
DELIMITER //
CREATE OR REPLACE FUNCTION alapanyagHanyReceptben ( alapanyagID int(4) )
RETURNS int
BEGIN    
DECLARE keresettID int(4);
    DECLARE szamlalo int(4);
    DECLARE c CURSOR FOR SELECT alapanyag.ID,COUNT(igeny.recept) AS szamlal FROM alapanyag JOIN igeny ON igeny.alapanyag = alapanyag.ID JOIN recept ON recept.ID = igeny.recept GROUP BY alapanyag.nev HAVING alapanyag.ID = alapanyagID;
    OPEN c;
    FETCH c INTO keresettID,szamlalo;
    CLOSE c;
    RETURN szamlalo;    
END //
DELIMITER ;
 
-- Futtatva (ID = 1 azaz só, eredmény 4 kéne legyen):
SET @p0='1'; SELECT `alapanyagHanyReceptben`(@p0) AS `alapanyagHanyReceptben`;
-- MySQL returned an empty result set (i.e. zero rows).
-- Végre működik, nem tudom hány elbabrált óra után! https://dev.mysql.com/doc/refman/8.0/en/fetch.html szerint FETCH ugyanannyi paramétert igényel, ahány oszlopom van a queryben. Mivel csak számlálóba fetch-eltem sokáig, ezért itt volt a hiba.
 
-- 26. Adjon olyan függvényt, ami minden alapanyag id-hoz és minden receptID-hez visszaadja, mi a mennyiség, ami kell ehhez a recepthez. Ha nincs ilyen, a válasz legyen NULL.
-- 27. Adjon olyan eljárást, ami egy input szöveget alapanyagnév részleteként értelmezve, minden alapanyagnál, aminek neve tartalmazza az input szöveget, az egységárat emelje 50%-kal!


