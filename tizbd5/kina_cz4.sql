-- 1. Przygotuj tabele:

-- Filmy
-- Kod liczba całkowita, autoinkrementacja, klucz podstawowy
-- Tytul  tekst
-- Rating tekst

CREATE TABLE Filmy (
    kod INT AUTO_INCREMENT PRIMARY KEY,
    Tytul VARCHAR(333),
    Rating VARCHAR(333)
);

-- Kina
-- Kod  liczba całkowita, autonumerowanie, klucz podstawowy
-- Nazwa tekst nie puste
-- Film liczba całkowita, klucz obcy odwołujący się do pola kod w tabeli Filmy

CREATE TABLE Kina (
    kod INT AUTO_INCREMENT PRIMARY KEY, 
    nazwa VARCHAR(323) NOT NULL,
    film INT,
    FOREIGN KEY (film) REFERENCES Filmy(kod)
);


-- 1. Wyświetl tytuły wszystkich filmów
SELECT * 
FROM filmy;
-- 2. Ile różnych poziomów ratingu jest zapisane w bazie? Wyświetl je (dane nie powinny się powtarzać). 
SELECT DISTINCT Rating 
FROM filmy;

-- 3. Wyświetl wszystkie filmy z nieustalonym ratingiem.
SELECT *
FROM filmy
WHERE Rating IS NULL;
-- 4. Wyświetl wszystkie  kina, w których aktualnie nie są wyświetlane żadne filmy. 
SELECT nazwa
FROM kina
WHERE film IS NULL;
-- 5. Wyświetl wszystkie dane o kinach i filmach, uwzględnij tylko dane o filmach, które są wyświetlane w tych kinach i dane o kinach, w których są wyświetlane jakieś filmy. 
SELECT * 
FROM filmy INNER JOIN kina ON filmy.kod=kina.film
WHERE film IS NOT NULL;
-- 6. Wyświetl wszystkie dane o kinach i filmach, uwzględnij w zestawieniu także te kina, w których aktualnie nie są wyświetlane żadne filmy.
SELECT *
FROM kina LEFT JOIN filmy ON kina.film=filmy.kod;
-- 7. Wyświetl wszystkie dane o kinach i filmach, uwzględnij w zestawieniu także te filmy, które nie są aktualnie wyświetlane w żadnych kinach. 
SELECT *
FROM filmy LEFT JOIN kina ON filmy.kod=kina.film;
-- 8. Wyświetl wszystkie dane o kinach i filmach, uwzględnij w zestawieniu także te kina, w których aktualnie nie są wyświetlane żadne filmy oraz  te filmy, które nie są aktualnie wyświetlane w żadnych kinach. 
SELECT *
FROM kina LEFT JOIN filmy ON kina.film=filmy.kod
UNION
SELECT *
FROM filmy LEFT JOIN kina ON filmy.kod=kina.film;
-- 9. Dodaj film  "One, Two, Three" (bez ratingu)
INSERT INTO filmy (Tytul, rating)
VALUES ('One, Two, Three', NULL);
 
-- 10. Ustal rating wszystkich filmów bez ratingu na  "G".
UPDATE filmy
SET rating = "G"
WHERE rating IS NULL;
-- 11. usuń kina wyświetlające filmy z ratingiem "NC-17".
DELETE kina
FROM kina INNER JOIN filmy ON kina.film=filmy.kod
WHERE rating = 'NC-17';