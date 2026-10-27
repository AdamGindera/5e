--  Zapytanie 1: wybierające jedynie nazwy marek samochodów 
SELECT nazwa
FROM marki;
-- ‒ Zapytanie 2: wybierające jedynie pola: model, rocznik, przebieg, paliwo, cena, zdjecie dla samochodu o id równym 10
SELECT model, rocznik, przebieg, paliwo, cena 
FROM samochody
WHERE id = 10;
-- ‒ Zapytanie 3: wybierające jedynie pole nazwa z tabeli marki i odpowiadające jej pola: model, rocznik, cena, zdjecie z tabeli samochody jedynie dla samochodów wyróżnionych. Zapytanie wybiera dokładnie 4 wiersze. Należy posłużyć się relacją
SELECT nazwa, model, rocznik, cena, zdjecie
FROM marki INNER JOIN samochody ON marki.id=samochody.marki_id
WHERE wyrozniony = 1;
-- ‒ Zapytanie 4: wybierające jedynie pola: model, cena, zdjecie z tabeli samochody dla samochodów o nazwie marki Audi. Należy posłużyć się relacją
SELECT model, cena, zdjecie
FROM marki INNER JOIN samochody ON marki.id=samochody.marki_id
WHERE nazwa = 'Audi';