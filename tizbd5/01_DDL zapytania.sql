-- 1. Utwórz tabelę pracownik(id_pracownik, imie, nazwisko, pesel, data_zatr, pensja), gdzie
-- id_pracownik – jest numerem pracownika nadawanym automatycznie, jest to klucz główny
-- imie i nazwisko – to niepuste łańcuchy znaków zmiennej długości,
-- pesel – stała długość, 11 znaków
-- data_zatr – domyślna wartość daty zatrudnienia to bieżąca data systemowa (curdate)
-- pensja – nie może być niższa niż 1000zł, dane przechowujemy jako stałoprzecinkowe (6 przed przecinkiem, 2 po przecinku)
 CREATE TABLE pracownik (
    id_pracownik INT AUTO_INCREMENT PRIMARY KEY,
    imie VARCHAR(100) NOT NULL, 
    nazwisko VARCHAR(200) NOT NULL,
    pesel VARCHAR(11),
    data_zatr DATE DEFAULT (CURDATE()),
    pensja DECIMAL (8,2) CHECK (pensja >= 1000) 
 );
????
 
-- 2. Utwórz tabelę naprawa(id_naprawa, data_przyjecia, opis_usterki, zaliczka), gdzie
-- id_naprawa – jest unikatowym, nadawanym automatycznie numerem naprawy, jest to klucz główny,
-- data_przyjecia – nie może być późniejsza niż bieżąca data systemowa,
-- opis usterki – nie może być pusty, musi mieć długość powyżej 10 znaków, (length)
-- zaliczka – nie może być mniejsza niż 100zł ani większa niż 1000zł.
 CREATE TABLE naprawa (
    id_naprawa INT PRIMARY KEY AUTO_INCREMENT
    data_przyjecia DATE CHECK (data_przyjecia <= CURDATE()),
    opis_usterki VARCHAR(365) NOT NULL CHECK (LENGTH(opis_usterki) > 10),
    zaliczka CHECK (zaliczka >= 100 AND zaliczka <= 1000)
 );

-- CURRENT DATA NIE DZIAŁA? CZY JEST ŹLE? NIE WIEM
CREATE TABLE naprawa (
    id_naprawa INT AUTO_INCREMENT PRIMARY KEY,
    data_przyjecia DATE,
    opis_usterki VARCHAR(255) NOT NULL CHECK (LENGTH(opis_usterki) > 10),
    zaliczka DECIMAL(6,2) CHECK (zaliczka >= 100 AND zaliczka <= 1000)
);
-- 3. Utwórz tabelę wykonane_naprawy(id_pracownik, id_naprawa, data_naprawy, opis_naprawy, cena), gdzie
-- id_pracownik – identyfikator pracownika wykonującego naprawę, klucz obcy powiązany z tabelą pracownik,
-- id_naprawa – identyfikator zgłoszonej naprawy, klucz obcy powiązany z tabelą naprawa,
-- data_naprawy – domyślna wartość daty naprawy to bieżąca data systemowa,
-- opis_naprawy – niepusty opis informujący o sposobie naprawy,
-- cena – cena naprawy.
CREATE TABLE wykonane_naprawy (
    id_pracownik INT,
    id_naprawa INT,
    data_naprawy DATE DEFAULT (CURDATE()),
    opis_naprawy VARCHAR(321) NOT NULL,
    CENA DECIMAL(10,2),

FOREIGN KEY (id_pracownik)
REFERENCES pracownik (id_pracownik),
FOREIGN KEY (id_naprawa)
REFERENCES naprawa(id_naprawa)
);
