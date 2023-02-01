
/*
6.1
*/

SELECT kraj, COUNT(*) AS "Liczba Osob" FROM gracze WHERE data_dolaczenia LIKE "2018%" GROUP BY kraj ORDER BY COUNT(*) DESC LIMIT 5;

/*
6.2
*/

SELECT nazwa, SUM(strzal) FROM klasy WHERE nazwa LIKE "%elf%" GROUP BY nazwa;


/*
6.3
*/

SELECT id_gracza
FROM Gracze
WHERE id_gracza NOT IN
 
(SELECT id_gracza
 
FROM Jednostki
 
WHERE nazwa = "artylerzysta");

/*
6.4
*/

SELECT jednostki.nazwa, COUNT(*) AS "Liczba_Jednostek" FROM jednostki 
INNER JOIN klasy ON jednostki.nazwa = klasy.nazwa 
WHERE ABS(lok_x - 100) + ABS(lok_y - 100) <= klasy.szybkosc 
GROUP BY jednostki.nazwa;

/*
6.5 a)
*/

/*
Tworzenie tabeli pomocniczej, która eliminuje przypadki w których 
1 gracz ma 2 jednostki w tym samym miejscu
*/
CREATE VIEW jednostki2 AS SELECT lok_x, lok_y, id_gracza, COUNT(*) AS liczba_jednostek
FROM Jednostki 
GROUP BY lok_x, lok_y, id_gracza 
HAVING COUNT(*) = 1;

/*
Sprawdzanie ile jest bitew
*/

SELECT lok_x, lok_y, COUNT(*) AS liczba_jednostek
FROM jednostki2
GROUP BY lok_x, lok_y
HAVING COUNT(*) > 1;


/*
6.5 b)
*/

/*
Sprawdzenie ile jest bitew miedzy dwoma Polakami
*/

SELECT lok_x, lok_y, COUNT(*) AS liczba_jednostek FROM jednostki2 
JOIN gracze ON jednostki2.id_gracza = gracze.id_gracza
WHERE gracze.kraj = "Polska"
GROUP BY lok_x, lok_y HAVING COUNT(*) > 1;

/*
Tworzenie tabeli pomocniczej
*/

Create VIEW zad5a AS 
SELECT lok_x, lok_y, COUNT(*) AS liczba_jednostek FROM jednostki2 
GROUP BY lok_x, lok_y HAVING COUNT(*) > 1;

/*
Sprawdzanie w ilu bitwach biorą udział polacy
*/

SELECT COUNT(*) as bitwy_polakow
FROM (Jednostki INNER JOIN Gracze ON Jednostki.id_gracza = Gracze.id_gracza) INNER JOIN zad5a ON (Jednostki.lok_y = zad5a.lok_y) AND (Jednostki.lok_x = zad5a.lok_x)
WHERE kraj LIKE "Polska";

/*
Wynikiem jest 264, ale wcześniej zobaczyliśmy, ze jest 19 Polakow toczy "bratobójcza" bitwę, wieć musimy to odjąc i dostajemy 254 
*/