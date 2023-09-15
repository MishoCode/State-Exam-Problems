USE movies;

--За всеки актьор/актриса изведете броя на различните студиа, с които са записвали филми.
--Включете и тези, за които няма информация в кои филми са играли
SELECT name, COUNT(DISTINCT studioname) FROM moviestar
LEFT JOIN starsin ON name = starname
LEFT JOIN movie ON movietitle = title AND movieyear = year
WHERE gender = 'M'
GROUP BY name;

--Изведете имената на актьорите, участвали в поне 3 филма след 1990 г
SELECT name FROM moviestar
JOIN starsin ON name = starname
WHERE gender = 'M' AND movieyear > 1990
GROUP BY name
HAVING COUNT(*) >= 3;

USE pc;

--Да се изведат различните модели компютри, подредени по цена на най-скъпия конкретен
--компютър от даден модел
SELECT model FROM pc
GROUP BY model
ORDER BY MAX(price);

USE ships;

--Намерете броя на потъналите американски кораби за всяка проведена битка с поне един
--потънал американски кораб
SELECT battle, COUNT(*) AS sunk_ships FROM outcomes
JOIN ships ON name = ship
JOIN classes ON classes.class = ships.class
WHERE result = 'sunk' AND country = 'USA'
GROUP BY battle;

--Битките, в които са участвали поне 3 кораба на една и съща страна
SELECT DISTINCT battle FROM outcomes
JOIN ships ON name = ship
JOIN classes ON classes.class = ships.class
GROUP BY battle, country
HAVING COUNT(*) >= 3;

--Имената на класовете, за които няма кораб, пуснат на вода след 1921 г., но имат пуснат
--поне един кораб
SELECT class FROM ships
GROUP BY class
HAVING MAX(launched) <= 1921;


--За всеки кораб броя на битките, в които е бил увреден (result = ‘damaged’). Ако корабът
--не е участвал в битки или пък никога не е бил увреждан, в резултата да се вписва 0
SELECT name, COUNT(battle) AS damaged_battles FROM ships
LEFT JOIN outcomes ON ship = name AND result = 'damaged'
GROUP BY name;

SELECT name, (
	SELECT COUNT(*) FROM outcomes o
	WHERE result = 'damaged' AND o.ship = s.name
) FROM ships s;

--Намерете за всеки клас с поне 3 кораба броя на корабите от този клас, които са
--победили в битка (result = 'ok')
SELECT class, COUNT(DISTINCT ship) FROM ships
LEFT JOIN outcomes ON ship = name AND result = 'ok'
GROUP BY class
HAVING COUNT(DISTINCT name) >= 3;

--За всяка битка да се изведе името на битката, годината на битката и броят на потъналите
--кораби, броят на повредените кораби и броят на корабите без промяна
SELECT battle, date,
	SUM(CASE result WHEN 'sunk' THEN 1 ELSE 0 END) AS sunk_count,
	SUM(CASE result WHEN 'damaged' THEN 1 ELSE 0 END) AS damaged_count,
	SUM(CASE result WHEN 'ok' THEN 1 ELSE 0 END) AS ok_count
FROM outcomes
JOIN battles ON battle = name
GROUP BY battle, date;

--Намерете имената на битките, в които са участвали поне 3 кораба с под 9 оръдия и от
--тях поне два са с резултат ‘ok’
SELECT battle FROM outcomes
JOIN ships ON ship = name
JOIN classes ON classes.class = ships.class
WHERE numguns < 9
GROUP BY battle
HAVING COUNT(*) >= 3 AND SUM(CASE result WHEN 'ok' THEN 1 ELSE 0 END) >= 2;


