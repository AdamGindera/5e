-- Utwórz tabelę Dzialy z polami:
 
-- kod całkowite, klucz podstawowy 
-- nazwa typ tekstowy
-- budzet rzeczywisty (real)
CREATE TABLE dzialy (
    kod INT PRIMARY KEY,
    nazwa VARCHAR(365),
    budzet REAL
);

-- Utwórz tabelę Pracownicy z polami:
 
-- ID całkowite, klucz podstawowy
-- imie tekst, nie może być puste
-- nazwisko tekst, nie może być puste
-- dzial całkowite, jest to również pole klucza obcego, odwołujące się do pola kod w tabeli Działy
CREATE TABLE Pracownicy (
    id INT PRIMARY KEY,
    imie VARCHAR(365) NOT NULL,
    nazwisko VARCHAR(365) NOT NULL,
    dzial INT, 
    FOREIGN KEY (dzial) REFERENCES dzialy(kod)
);


-- 1. Wyświetl nazwiska wszystkich pracowników
SELECT nazwisko
FROM pracownicy;
-- 2. Wyświetl nazwiska wszystkich pracowników, ale tak, aby się nie powtarzały (DISTINCT) 
SELECT DISTINCT nazwisko
FROM pracownicy;
-- 3. Wyświetl dane wszystkich pracowników o nazwisku  "Smith".   
SELECT nazwisko
FROM pracownicy
WHERE nazwisko = 'Smith';
 

-- 4. Wyświetl wszystkie dane pracowników o nazwisku  "Smith" lub "Doe".
SELECT *
FROM pracownicy
WHERE nazwisko IN ('Smith', 'Doe');
-- 5. Wyświetl wszystkie dane o pracownikach, którzy pracują w dziale 14.
SELECT * 
FROM pracownicy
WHERE dzial = '14';
-- 6. Wyświetl wszystkie dane o pracownikach z działu 37 i działu 77. 
SELECT * 
FROM pracownicy
WHERE dzial IN ('37', '77');
-- 7. Wyświetl wszystkie dane o pracownikach, których nazwisko zaczyna się na literę  "S".
SELECT * 
FROM pracownicy
WHERE nazwisko LIKE 'S%';
-- 8. Wyświetl sumę budżetów wszystkich działów. 
SELECT SUM(budzet) AS caly_budzet
FROM dzialy;

-- 9. Dla każdego działu wyświetl liczbę pracowników (tylko kod działu i liczbę pracowników) 
SELECT dzial, COUNT(*) AS liczba_pracownikow
FROM pracownicy
GROUP BY dzial;
-- 10. Wyświetl wszystkie dane o pracownikach, łącznie z danymi o działach, w których pracują. 
SELECT * 
FROM pracownicy INNER JOIN dzialy ON pracownicy.dzial=dzialy.kod;

-- 11. Wyświetl imię i nazwisko każdego pracownika razem z nazwą i budżetem działu, w którym pracownik pracuje. 
SELECT imie, nazwisko, nazwa, budzet
FROM pracownicy INNER JOIN dzialy ON pracownicy.dzial=dzialy.kod;

-- 12. Wyświetl imiona i nazwiska pracowników, którzy pracują w działach o budżetach większych niż  $60,000 (czyli sześćdziesiąt tysięcy)
SELECT imie, nazwisko, budzet
FROM pracownicy INNER JOIN dzialy ON pracownicy.dzial=dzialy.kod
HAVING budzet BETWEEN '60000' AND '5090090';
-- 13. Wyświetl działy z budżetem większym niż średni budżet wszystkich działów. 
 SELECT *
 FROM dzialy
 WHERE budzet > (
    SELECT AVG(budzet)
    FROM dzialy
 );

-- 14. Wyświetl nazwy działów z więcej niż dwoma pracownikami 
SELECT nazwa
FROM dzialy INNER JOIN pracownicy ON dzialy.kod=pracownicy.dzial
GROUP BY dzialy.nazwa
HAVING COUNT(pracownicy.id) > 2;
??????????????????????????
-- 15. Wyświetl imiona i nazwiska pracowników, pracujących w działach (dziale) z najmniejszym budżetem.
-- SELECT imie, nazwisko
-- FROM dzialy INNER JOIN pracownicy ON dzialy.kod=pracownicy.dzial
-- GROUP BY nazwa
-- HAVING MIN(budzet);
SELECT imie, nazwisko
FROM dzialy INNER JOIN pracownicy ON dzialy.kod=pracownicy.dzial
WHERE budzet = (
    SELECT MIN(budzet)
    FROM dzialy
);
-- 16. Dodaj nowy dział  "Quality Assurance" z budżetem $40,000 i kodem 10. 
INSERT INTO dzialy (kod, nazwa, budzet)
VALUES (10, 'Quality Assurance', 40000);
-- 17. Dodaj pracownika "Mary Moore", pracującą w dziale o kodzie 10, z ID 847-21-9811.
INSERT INTO pracownicy (id, imie, nazwisko, dzial)
VALUES ('847-21-9811','Mary','Moore', 10);
-- 18. Zmniejsz budżet wszystkich działów o 10%.
UPDATE dzialy
SET budzet = budzet * 0.90;
-- 19. przenieś pracowników z działu Research  do działu IT  .
????????????????????????????????
UPDATE Pracownicy
SET dzial = (
    SELECT kod
    FROM dzialy
    WHERE nazwa = 'IT'
)
WHERE dzial = (
    SELECT kod
    FROM dzialy
    WHERE nazwa = 'Research'
);
-- 20. Usuń wszystkich pracowników pracujących w dziale   IT.
DELETE FROM pracownicy
WHERE dzial = (
    SELECT kod
    FROM dzialy
    WHERE nazwa = 'IT'
);
-- 21. Usuń wszystkich pracowników, którzy pracują w działach z budżetem większym bądź równym $60,000 (60 tysięcy)
DELETE FROM pracownicy
WHERE dzial IN (
    SELECT kod
    FROM dzialy
    WHERE budzet >= 60000
);
-- 22. Usuń wszystkie działy
DELETE FROM dzialy;