-- − Zapytanie 1: wybierające jedynie pola idMeble, nazwa, plik, styl, cena i opis z tabeli meble dla kategorii 1
SELECT idMeble, nazwa, plik, styl, cena, opis
FROM meble
WHERE kategoria = 1;
-- − Zapytanie 2: wstawiające rekord do tabeli zakupy o wartościach identyfikator klienta: 1, identyfikator mebla: 6, jedna sztuka. Klucz główny nadawany automatycznie 
INSERT INTO zakupy (idKlienci, idMeble, sztuk)
VALUES(1, 6, 1);
-- − Zapytanie 3: wybierające jedynie nazwę i cenę mebli, które zostały zakupione przez klienta o identyfikatorze równym 1. Należy posłużyć się relacją
SELECT nazwa, cena
FROM meble INNER JOIN zakupy ON meble.idMeble=zakupy.idMeble
WHERE idKlienci = 1;
-- − Zapytanie 4: wybierające jedynie nazwę mebla oraz odpowiadające mu imię i nazwisko kupującego klienta. Należy posłużyć się relacją m:n
SELECT nazwa, imie, nazwisko
FROM meble 
INNER JOIN zakupy ON meble.idMeble=zakupy.idMeble
INNER JOIN klienci ON zakupy.idKlienci=klienci.idKlienci;
