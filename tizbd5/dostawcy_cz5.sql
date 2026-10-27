-- Produkty

 
-- Kod całkowite, autnumerowanie, klucz podstawowy
-- Nazwa tekst do 40 znaków
 CREATE TABLE produkty (
    kod INT AUTO_INCREMENT PRIMARY KEY,
    nazwa VARCHAR(40)
);

-- Dostawcy 
-- Kod tekst, 4 znaki, klucz podstawowy
-- Nazwa tekst do 40 znaków
 CREATE TABLE dostawcy (
    kod VARCHAR(4) PRIMARY KEY,
    nazwa VARCHAR(40)
 );

 

-- Oferty
-- Produkt całkowite
-- Dostawca tekst, 4 znaki
-- Cena całkowita
-- Klucz podstawowy na polach produkt i dostawca
-- produkt klucz obcy, odwołuje się do pola Kod w tabeli Produkty
-- Dostawca klucz obcy, odwołuje się do pola Kod w tabeli Dostawcy
CREATE TABLE oferty (
    produkt INT,
    dostawca VARCHAR(4),
    cena INT,
    PRIMARY KEY (produkt, dostawca),
    FOREIGN KEY (produkt) REFERENCES produkty(kod),
    FOREIGN KEY (dostawca) REFERENCES dostawcy(kod)
);

 

-- 1. Wyświetl nazwy wszystkich produktów
SELECT * 
FROM produkty;

-- 2. Wyświetl wszystkie dane dostawców
SELECT *
FROM dostawcy;
-- 3. Dla każdego produktu wyświetl średnią cenę (pokaż kod produktu i średnią ceną, zmień nazwy wyświetlanych kolumn na kod_produktu i srednia_cena)
SELECT AVG(cena) as srednia_cena, kod as kod_produktu
FROM produkty INNER JOIN oferty ON produkty.kod=oferty.produkt
GROUP BY produkt;

-- 4. Wyświetl nazwy wszystkich Dostawców oferujących produkt o kodzie 1
SELECT nazwa
FROM dostawcy INNER JOIN oferty ON dostawcy.kod=oferty.dostawca
WHERE produkt = 1;
-- 5. Wyświetl nazwy wszystkich produktów oferowanych przez dostawcę o kodzie 'HAL'
SELECT produkty.nazwa
FROM produkty INNER JOIN oferty ON produkty.kod=oferty.produkt
WHERE dostawca = 'HAL';

-- 6. Dla każdego produktu wyświetl najdroższą ofertę dostawy, pokaż nazwę produktu, nazwę dostawcy oraz cenę (zauważ, że może być więcej niż jeden dostawca oferujący produkty w tej samej, najdroższej cenie).
SELECT MAX(cena), produkty.nazwa, dostawcy.nazwa
FROM oferty 
INNER JOIN produkty ON oferty.produkt=produkty.kod
INNER JOIN dostawcy ON oferty.dostawca=dostawcy.kod
GROUP BY produkty.nazwa;
-- (WYŚWIETLA TYLKO JEDEN PRODUKT, /// WYŚWIETLA 1 PRODUKT Z CENA 50, A JEST WIĘCEJ DOSTAWCÓW DLA TEGO PRODUKTU O TEJ SAMEJ CENIE)
-- Wybierz nazwy produktów, nazwy dostawców i ceny o cenach równych
-- w podzapytaniu wybierz najwyższe ceny z tabeli Oferty dla produktów o kodzie z tabeli Oferty równym kodowi aktualnie sprawdzanego produktu (podzapytania skorelowane)
-- ??????????????????????????????????
SELECT Produkty.Nazwa, Dostawcy.nazwa, Oferty.cena
FROM oferty 
INNER JOIN produkty ON oferty.produkt=produkty.kod
INNER JOIN dostawcy ON oferty.dostawca=dostawcy.kod
WHERE (Oferty.Produkt, Oferty.Cena) IN (
    SELECT Produkt, MAX(cena)
    FROM oferty
    GROUP BY produkt
);

 

-- 7. Dodaj Ofertę produktu o kodzie 1 dostawcy "Skellington Supplies"  o cenie 7.
INSERT INTO Oferty (Produkt, Dostawca, Cena)
VALUES (1,'TNBC', 7);
-- MOGĘ SPRAWDZIĆ W TABELI DOSTAWCY KOD DLA Skellington Supplies, a co jak bym nie mógł sprawdzić?
INSERT INTO Oferty (Produkt, Dostawca, Cena)
VALUES (1,
    (SELECT kod 
    FROM dostawcy
    WHERE nazwa = 'Skellington Supplies'),
    7);

-- 8. Podnieś cenę wszystkich produktów o 1
UPDATE oferty
SET cena = cena + 1;
-- 9. Producent  "Susan Calvin Corp." nie będzie dostarczał już wkrętów  (bolt). Usuń właściwy wiersz z tabeli Oferty.
DELETE FROM oferty
WHERE Produkt = 4 AND dostawca = 'RBT';

-- TO SAMO CO W ZAD7.
DELETE FROM oferty
WHERE Produkt = (
    SELECT kod 
    FROM produkty
    WHERE nazwa = 'Bolt'
)
AND dostawca = (
    SELECT kod
    FROM dostawcy
    WHERE nazwa = 'Susan Calvin Corp.'
);
-- 10. Usuń z bazy dostawcę o kodzie "RBT"
DELETE FROM oferty
WHERE dostawca = 'RBT';

DELETE FROM dostawcy 
WHERE kod = 'RBT';
-- 11. Usuwamy z oferty (tabela Oferty) nakrętki (nut). Właściwy kod produktu wyszukaj podzapytaniem.
DELETE FROM oferty
WHERE Produkt = (
    SELECT kod
    FROM produkty
    WHERE nazwa = 'Nut'
);
