-- Zapytanie 1: wybierające jedynie id i tytuły książek z gatunku liryka
SELECT id, tytul 
FROM ksiazka
WHERE gatunek = 'Liryka';
-- Zapytanie 2: wybierające pierwsze 15 rekordów, jedynie tytuł książki oraz odpowiadające mu id czytelnika i data oddania posortowane rosnąco według daty oddania. Należy posłużyć się relacją
SELECT tytul, id_cz, data_odd
FROM ksiazka INNER JOIN wypozyczenia ON ksiazka.id=wypozyczenia.id_ks
ORDER BY data_odd 
LIMIT 15;
-- Zapytanie 3: modyfikujące strukturę tabeli ksiazka, poprzez dodanie nowej kolumny o nazwie rezerwacja typu TINYINT, o długości 1 Bajta, która przyjmuje wartość domyślną 0 (oznacza, że książka nie jest zarezerwowana)
ALTER TABLE ksiazka
ADD rezerwacja TINYINT(1) DEFAULT NULL;
-- Zapytanie 4: aktualizujące pole rezerwacja na wartość 1 dla książki, której id=1
UPDATE ksiazka
SET rezerwacja = 1
WHERE id = 1;
-- Zapytanie 5: wybierające jedynie tytuł książki, której id=4
SELECT tytul
FROM ksiazka
WHERE id = 4;