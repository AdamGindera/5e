-- Magazyny

-- Kod  całkowity, klucz podstawowy
-- Lokalizacja tekst, nie puste
-- Pojemność całkowita, nie puste
CREATE TABLE magazyny (
    kod INT PRIMARY KEY,
    lokalizacja VARCHAR(533) NOT NULL,
    pojemnosc INT NOT NULL
);

-- Kontenery

-- Kod tekst o stałej długości 4 znaków, klucz podstawowy,
-- Zawartosc tekst
-- Wartosc rzeczywista, dwa miejsca po przecinku, cztery przed
-- Magazyn całkowita, nie pusta, pole klucza obcego (odwołuje się do pola kod w tabeli magazyny)
CREATE TABLE kontenery (
    kod VARCHAR(4) PRIMARY KEY,
    zawartosc VARCHAR(124),
    wartosc DECIMAL(6,2),
    magazyn INT NOT NULL,
    FOREIGN KEY (magazyn) REFERENCES magazyny(kod)
);


-- 1. Wyświetl wszystkie dane o wszystkich magazynach (zrzut)
SELECT * 
FROM magazyny;
-- 2. Wyświetl wszystkie kontenery o wartości większej niż $150.  (zrzut)
SELECT * 
FROM Kontenery
WHERE wartosc > 150;
-- 3. Co jest przechowywane w kontenerach? Wyświetl zawartość tak, aby dane się nie powtarzały.   (zrzut)
SELECT DISTINCT zawartosc
FROM kontenery;

-- 4. Wyświetl średnią wartość wszystkich kontenerów.   (zrzut)
SELECT AVG(wartosc) as srednia_wartosc
FROM kontenery;

-- 5. Wyświetl kody magazynów wraz ze średnią wartością zawartych w nich kontenerów.  (zrzut)
SELECT magazyny.kod, AVG(wartosc) as srednia_wartosc
FROM magazyny INNER JOIN kontenery ON magazyny.kod=kontenery.magazyn
GROUP BY magazyn;
-- 6. Wyświetl kody magazynów wraz ze średnią wartością zawartych w nich kontenerów, ale ogranicz się do tych, w których średnia wartość kontenerów jest większa niż 150.  (zrzut)
SELECT magazyny.kod, AVG(wartosc) as srednia_wartosc
FROM magazyny INNER JOIN kontenery ON magazyny.kod=kontenery.magazyn
GROUP BY magazyn
HAVING srednia_wartosc > 150;
-- 7. Wyświetl kod każdego kontenera, wraz z miastem, gdzie jest zlokalizowany (czyli lokalizacją magazynu)  (zrzut)
SELECT kontenery.kod, lokalizacja
FROM kontenery INNER JOIN magazyny ON kontenery.magazyn=magazyny.kod;
-- 8. Wyświetl  kody magazynów wraz z liczbą kontenerów w każdym z tych magazynów.  (zrzut)
SELECT magazyny.kod, pojemnosc
FROM magazyny;
-- 9. Rozwiń poprzednie zapytanie tak, aby w zestawieniu były wymienione również magazyny, w których nie ma kontenerów (powinna być wyświetlona liczba zero, a nie magazyn pominięty w tym zestawieniu)  (zrzut)
SELECT magazyny.kod, COUNT(kontenery.kod)
FROM magazyny LEFT JOIN kontenery ON magazyny.kod=kontenery.magazyn
GROUP BY magazyny.kod;
????????
-- Wskazówka: wybierz kod magazynu z tabeli magazyny oraz policz kod z tabeli Kontenery; dane wybieraj z dwóch tabel połączonych połączeniem rozszerzającym (LEFT JOIN lub RIGHT JOIN), z rozszerzanej strony powinna być tabela Magazyny (wybieramy wszystkie magazyny, także te, w których nie ma kontenerów); grupowanie według kodu magazynu
 
-- 10.  Wyświetl kody wszystkich magazynów, które są przeładowane (magazyn jest przeładowany, jeśli liczba zawartych w nim kontenerów jest większa niż jego pojemność)  (zrzut)
SELECT magazyny.kod
FROM magazyny INNER JOIN kontenery ON magazyny.kod = kontenery.magazyn
GROUP BY magazyny.kod, magazyny.pojemnosc
HAVING COUNT(kontenery.kod) > magazyny.pojemnosc;
 

-- np. wyświetl kody tych magazynów (z tabeli Magazyny), których pojemność jest mniejsza niż

-- (podzapytanie) ilość kontenerów (z tabeli kontenery), których kod magazynu (pole magazyn) jest taki jak kod magazynu z tabeli głównego zapytania (czyli Magazyny)
?

-- 11. Wyświetl kody wszystkich kontenerów zlokalizowanych w Chicago wraz z lokalizacją i pojemnością magazynów . Uwzględnij w zestawieniu także te magazyny z Chicago, w których nie ma aktualnie kontenerów  (zrzut)
SELECT Kontenery.Kod, lokalizacja, pojemnosc
FROM Magazyny INNER JOIN kontenery ON Magazyny.Kod = Kontenery.Magazyn
WHERE Magazyny.Lokalizacja = 'Chicago';
   
-- lub zastosuj podzapytanie (wyświetl kody kontenerów, dla których kod magazynu (magazyn) jest na liście (IN) kodów magazynów zlokalizowanych w Chicago. 

-- 12. Utwórz nowy magazyn w Nowym Yorku z pojemnością 3 kontenerów.   (zrzut)
INSERT INTO magazyny (kod, lokalizacja, pojemnosc)
VALUES (7, 'New York', 3);
-- 13. Utwórz nowy kontener, z kodem "H5RT",  zawierającym "Papers" z wartością $200 i zlokalizowany w magazynie o kodzie 2.  (zrzut)
INSERT INTO kontenery (kod, zawartosc, wartosc, magazyn)
VALUES ('H5RT', 'Papers', 200, 2);
-- 14. Zmniejsz wartość wszystkich kontenerów o 15%.  (zrzut)
UPDATE kontenery
SET wartosc = wartosc * 0.85;
-- 15 Usuń wszystkie kontenery o wartości mniejszej niż $100.  (zrzut)
DELETE FROM kontenery
WHERE wartosc < 100;
-- 16. Usuń wszystkie kontenery z przeładowanych magazynów.   (zrzut)
???????????????????????????????????????????????????????????????
DELETE FROM Kontenery
WHERE Magazyn IN (
    SELECT Kod
    FROM Magazyny
    WHERE Pojemnosc < (
        SELECT COUNT(Kontenery.Kod)
        FROM Kontenery
        WHERE Kontenery.Magazyn = Magazyny.Kod
    )
);
-- usuń wszystkie kontenery, których kod jest na liście (IN) kodów przeładowanych magazynów (tę wartość zwraca zapytanie nr. 10)