-- − Zapytanie 1: wybierające jedynie id_zadania, zadanie i datę z tabeli zadania 
SELECT id_zadania, data
FROM zadania;
-- − Zapytanie 2: wstawiające do tabeli zadania rekord z danymi: „spotkanie firmowe”, dnia „2024-05-10” dla osoby o id równym 1
INSERT INTO zadania (zadanie, data, osoba_id)
VALUES('spotkanie firmowe', '2024-05-10', 1);
-- − Zapytanie 3: usuwające rekord o id_zadania równym 2 z tabeli zadania
DELETE FROM zadania
WHERE id_zadania = 2;
-- − Zapytanie 4: wybierające jedynie imię, nazwisko i numer telefonu osoby oraz odpowiadające im zadanie i datę z tabeli zadania. Należy posłużyć się relacją
SELECT imie, nazwisko, telefon, zadanie, data
FROM osoby INNER JOIN zadania ON osoby.id_osoba=zadania.osoba_id;