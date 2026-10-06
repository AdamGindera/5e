-- 1. Dana jest tabela CREATE TABLE student(id_student INT auto_increment PRIMARY KEY, nazwisko VARCHAR(20), nr_indeksu INT, stypendium dec(6,2)); 
 
-- A.  Wprowadź ograniczenia na tabelę student:
-- nazwisko – niepusta kolumna,
ALTER TABLE student
MODIFY nazwisko VARCHAR(20) NOT NULL;
-- nr_indeksu – unikatowa kolumna,
ALTER TABLE student
ADD UNIQUE (nr_indeksu);
-- stypendium –nie może być niższe niż 1000zł,
ALTER TABLE student
ADD CHECK (stypendium >= 1000);
-- B. Dodaj niepustą kolumnę imie (powinna znaleźć się za polem nazwisko).
ALTER TABLE student
ADD imie VARCHAR(20) NOT NULL
AFTER nazwisko;
-- C. Zmień typ pola stypendium tak, aby było możliwe wpisanie stypendium o wartości 10000
ALTER TABLE student
MODIFY stypendium dec (7,2);
-- D. Dodaj wartość domyślną dla stypendium: 1000
ALTER TABLE student
ALTER stypendium SET DEFAULT 1000;

-- 2.  Dane są tabele:
-- CREATE TABLE dostawca(id_dostawca INT auto_increment PRIMARY KEY, nazwa VARCHAR(30));

-- CREATE TABLE towar(id_towar INT, kod_kreskowy INT, id_dostawca INT);
 
-- Zmodyfikuj powyższe tabele:
-- A. kolumna nazwa z tabeli dostawca powinna być unikatowa,
ALTER TABLE dostawca
ADD UNIQUE (nazwa);
-- B. do tabeli towar dodaj niepustą kolumnę nazwa (za polem kod_kreskowy),
ALTER TABLE towar
ADD nazwa VARCHAR(123) NOT NULL
AFTER kod_kreskowy;
-- C. Do tabeli towar dodaj klucz podstawowy na polach id_towar i id_dostawca
ALTER TABLE towar
ADD PRIMARY KEY (id_towar, id_dostawca);
-- D. kolumna kod_kreskowy w tabeli towar powinna być unikatowa,
ALTER TABLE towar
ADD UNIQUE (kod_kreskowy);
-- E. zmieniamy zdanie, klucz podstawowy w tabeli towar powinien być tylko na polu towar
ALTER TABLE towar
DROP PRIMARY KEY;

ALTER TABLE towar 
ADD PRIMARY KEY (id_towar);
-- F.  kolumna id_dostawca z tabeli towar jest kluczem obcym z tabeli dostawca.
ALTER TABLE towar
ADD FOREIGN KEY (id_dostawca) REFERENCES dostawca(id_dostawca);
-- G. kolumna nazwa w tabeli dostawca powinna dopuszczać dłuższe nazwy (zmień typ)
ALTER TABLE dostawca
MODIFY nazwa VARCHAR(321) NOT NULL;
 
 
-- 3.  Dane są tabele: 
--  CREATE TABLE kraj(id_kraj INT auto_increment PRIMARY KEY, nazwa VARCHAR(30));
-- CREATE TABLE gatunek(id_gatunek INT auto_increment PRIMARY KEY, nazwa VARCHAR(30));
-- CREATE TABLE zwierze(id_zwierze INT auto_increment PRIMARY KEY, id_gatunek INT, id_kraj INT, cena dec(6,2));
 
-- Zmodyfikuj powyższe tabele:
-- A. kolumny nazwa z tabel kraj i gatunek mają być niepuste i unikatowe,
ALTER TABLE kraj
MODIFY nazwa VARCHAR(30) NOT NULL;

ALTER TABLE kraj
ADD UNIQUE (nazwa);

ALTER TABLE gatunek
MODIFY nazwa VARCHAR(30) NOT NULL;

ALTER TABLE gatunek
ADD UNIQUE (nazwa);
-- B. W tabeli zwierze zmień nazwę kolumny id_gatunek na gatunek_id oraz id_kraj na kraj_id
ALTER TABLE zwierze
CHANGE COLUMN id_gatunek gatunek_id INT;

ALTER TABLE zwierze
CHANGE COLUMN id_kraj kraj_id INT;
-- C. kolumna gatunek_id z tabeli zwierze jest kluczem obcym z tabeli gatunek,
ALTER TABLE zwierze
ADD FOREIGN KEY (gatunek_id) REFERENCES gatunek(id_gatunek);
 
-- D. kolumna kraj_id z tabeli zwierze jest kluczem obcym z tabeli kraj
ALTER TABLE zwierze
ADD FOREIGN KEY (kraj_id) REFERENCES kraj(id_kraj);
-- E. Kolumna nazwa z tabeli gatunek powinna być indeksowana w celu szybszego przeszukiwania
CREATE INDEX index_gatunek_nazwa
ON gatunek(nazwa);
-- F. Kolumna nazwa z tabeli kraj również powinna być indeksowana
CREATE INDEX index_kraj_nazwa
ON kraj(nazwa);