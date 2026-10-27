--  Zapytanie 1: wybierające jedynie średnią liczbę pracowników w firmach, minimalną liczbę pracowników i maksymalną liczbę pracowników. Kolumnom należy nadać nazwy (aliasy), kolejno: „średnia”, „najmniej”, „najwięcej”
SELECT AVG(liczba_pracownikow) as 'srednia', MIN(liczba_pracownikow) as 'najmniej', MAX(liczba_pracownikow) as 'najwiecej'
FROM wykonawcy;
-- − Zapytanie 2: wybierające jedynie nazwy firm i liczbę pracowników dla firm, w których liczba pracowników wynosi 40 i więcej
SELECT nazwa_firmy, liczba_pracownikow
FROM wykonawcy
WHERE liczba_pracownikow >= 40;
-- − Zapytanie 3: wybierające bez powtórzeń jedynie nazwy miast, z których pochodzą klienci, posortowane rosnąco według nazwy miasta
SELECT DISTINCT miasto
FROM klienci
GROUP BY miasto;

-- − Zapytanie 4: wybierające jedynie imiona klientów oraz ceny ich zleceń tylko dla klientów z Poznania, którzy zamówili malowanie. Należy posłużyć się relacją
SELECT imie, cena
FROM klienci INNER JOIN zlecenia ON klienci.id_klienta=zlecenia.id_klienta
WHERE klienci.miasto = 'Poznań' AND zlecenia.rodzaj = 'malowanie';
?? nie działa
-- − Zapytanie 5: wybierające jedynie imiona klientów oraz nazwy firm wykonujących dla nich zlecenia. Należy posłużyć się 
SELECT klienci.imie, nazwa_firmy
FROM klienci
INNER JOIN zlecenia ON klienci.id_klienta = zlecenia.id_klienta
INNER JOIN wykonanie ON zlecenia.id_zlecenia = wykonanie.id_zlecenia
INNER JOIN wykonawcy ON wykonanie.id_wykonawcy = wykonawcy.id_wykonawcy;

