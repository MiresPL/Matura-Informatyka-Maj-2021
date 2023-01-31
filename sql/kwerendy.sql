SELECT kraj, COUNT(*) AS "Liczba Osob" FROM gracze WHERE data_dolaczenia LIKE "2018%" GROUP BY kraj ORDER BY COUNT(*) DESC LIMIT 5;

SELECT nazwa, SUM(strzal) FROM klasy WHERE nazwa LIKE "%elf%" GROUP BY nazwa;

SELECT id_gracza
FROM Gracze
WHERE id_gracza NOT IN
 
(SELECT id_gracza
 
FROM Jednostki
 
WHERE nazwa = "artylerzysta");