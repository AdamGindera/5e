-- Utwórz tabele:

-- Producenci

 

--  kod całkowity, klucz podstawowy, autoinkrementacja
-- nazwa  tekst, pole nie może być puste
CREATE TABLE producenci (
    kod INT PRIMARY KEY AUTO_INCREMENT,
    nazwa VARCHAR(100) NOT NULL
);

-- Produkty
-- kod całkowite, klucz podstawowy,  autoinkrementacja
-- nazwa tekst, pole nie może puste
-- cena dwa miejsca po przecinku, przed przecinkiem 5 cyfr
-- producent całkowite, klucz obcy odwołujący się do pola kod w tabeli producenci
CREATE TABLE produkty (
    kod INT PRIMARY KEY AUTO_INCREMENT,
    nazwa VARCHAR(365) NOT NULL,
    cena DECIMAL (7,2),
    producent INT
);
-- 1. Wyświetl nazwy wszystkich produktów|
SELECT nazwa
FROM produkty;
-- 2. Wyświetl nazwy i ceny wszystkich produktów w sklepie 
SELECT nazwa, cena
FROM produkty;
-- 3. Wyświetl nazwy produktów o cenie mniejszej lub równiej  $200.
SELECT nazwa
FROM produkty
WHERE cena <= 200;
-- 4. Wyświetl wszystkie produkty o cenie pomiędzy $60 i $120.
SELECT nazwa
FROM produkty
BETWEEN 60 AND 120;
-- 5. Wyświetl nazwy produktów i ceny w centach (tzn. pomnóż ceny przez 100) 
SELECT nazwa, cena * 100 AS centow
FROM produkty;

-- 6. Wyświetl średnią cenę wszystkich produktów 
SELECT AVG(cena)
FROM produkty;
-- 7. Wyświetl średną ceną wszystkich produktów producenta o kodzie 2 
SELECT AVG(cena) as srednia_cena
FROM produkty
WHERE producent = 2;
 

-- 8. Ile jest produktów o cenie większej lub równiej $180.
SELECT COUNT(*) 
FROM produkty
WHERE cena >=180;
-- 9. Wyświetl nazwy i ceny wszystkich produktów o cenie większej lub równej  $180, i posortuj je najpierw według ceny (rosnąco), a następnie według nazwy (malejąco) 
SELECT nazwa, cena
FROM produkty
WHERE cena >=180
ORDER BY cena DESC; -- ORDER BY cena; --
-- 10. Wyświetl wszystkie dane z z tabeli produkty oraz wszystkie dane z tabeli producenci 
SELECT * 
FROM produkty;

SELECT * 
FROM producenci;
-- 11. Wyświetl nazwę produktu, cenę i nazwę producenta dla wszystkich produktów 
SELECT produkty.nazwa, cena, producenci.nazwa
FROM produkty INNER JOIN producenci ON produkty.producent = producenci.kod;
-- 12. Wyświetl średnią cenę produktów każdego producenta, pokazując tylko kod producenta
SELECT producent, AVG(cena)
FROM produkty
GROUP BY producent;
-- 13. Wyświetl średnią cenę produktów każdego producenta, pokazując nazwę producenta 
SELECT producenci.nazwa, AVG(cena)
FROM produkty INNER JOIN producenci ON produkty.producent = producenci.kod
GROUP BY producent;
-- 14. Wyświetl nazwę każdego producenta, którego produkty mają średnią cenę większą lub równą $150
SELECT AVG(cena) as srednia_cena, producenci.nazwa
FROM produkty INNER JOIN producenci ON produkty.producent = producenci.kod
GROUP BY producenci.nazwa
HAVING srednia_cena >=150;

-- 15. Wyświetl nazwę i cenę najtańszego produktu  (LIMIT lub podzapytanie)
SELECT nazwa, cena 
FROM produkty
ORDER BY cena 
LIMIT 1;

SELECT nazwa, cena
FROM produkty
WHERE cena = (
    SELECT MIN(cena)
    FROM produkty
);
-- 16.Wyświetl nazwę każdego producenta razem z nazwą i ceną jego najdroższego produktu - CZY DA SIĘ BEZ PODZAPYTANIA?
SELECT producenci.nazwa, produkty.nazwa, cena
FROM produkty INNER JOIN producenci ON produkty.producent = producenci.kod
WHERE cena = (
    SELECT MAX(cena)
    FROM produkty p
    WHERE p.producent = producenci.kod
);
* NIE DZIAŁA*
-- 17. Dodaj nowy produkt:  Loudspeakers, $70, producent 2.
INSERT INTO Produkty(nazwa,cena, producent)
VALUES ('Loudspeakers', 70, 2);
-- 18. Zmień nazwę produktu o kodzie 8 na "Laser Printer".
UPDATE produkty
SET nazwa = 'Laser Printer'
WHERE kod = 8;
-- 19. Wykonaj 10% przecenę każdego produktu 
UPDATE produkty
SET cena = cena * 0.90;
-- 20. Wykonaj 10% przecenę każdego produktu o cenie większej lub równiej $120.
UPDATE Produkty
SET cena = cena * 0.90
WHERE cena >= 120;

-- SELECT
-- FROM
-- WHERE
-- GROUP BY
-- HAVING
-- ORDER BY