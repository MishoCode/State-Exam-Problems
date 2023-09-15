USE movies;

SELECT movietitle, movieyear, starname FROM starsin JOIN moviestar
ON name = starname
WHERE gender = 'M' AND starname NOT LIKE '%k%' AND starname NOT LIKE '%b%'
AND movieyear < 1982;

USE ships;
-- 5. Изведете броя на потъналите американски кораби за 
-- всяка проведена битка с поне един потънал американски
-- кораб.

SELECT battle, COUNT(*) FROM outcomes JOIN ships
ON ship = name
JOIN classes
ON classes.class = ships.class
WHERE country = 'USA' AND result = 'sunk'
GROUP BY battle;

-- 6. Битките, в които са участвали поне 3 кораба на 
-- една и съща страна.

SELECT DISTINCT battle FROM outcomes
JOIN ships ON name = ship
JOIN classes ON classes.class = ships.class
GROUP BY battle, country
HAVING COUNT(*) >= 3;

-- За всеки клас да се изведе името му, държавата и първата година, 
-- в която е пуснат кораб от този клас

SELECT classes.class, MIN(country) AS country, MIN(launched) AS first_year FROM classes
JOIN ships ON classes.class = ships.class
GROUP BY classes.class;

--За всеки клас с кораби - името на класа, името на произволен кораб и брой кораби

SELECT class, MIN(name), COUNT(*) FROM ships
GROUP BY class;

-- 7. Имената на класовете, за които няма кораб, пуснат
-- на вода след 1921 г., но имат пуснат поне един кораб.

SELECT class FROM ships
GROUP BY class
HAVING MAX(launched) <= 1921;

-- 8. За всеки кораб да се изведе броят на битките, в които е бил увреден.
-- Ако корабът не е участвал в битки или пък никога не е бил
-- увреждан, в резултата да се вписва 0.

SELECT name, COUNT(battle) AS damaged_battles_count FROM ships
LEFT JOIN outcomes ON name = ship AND result = 'damaged'
GROUP BY name;

--2019 september
USE movies;

--Да се огради буквата на заявката, която извежда за всеки продуцент името му и броя на фил-
--мите му по години. Продуценти, които нямат нито един филм, НЕ трябва да присъстват в резултатното
--множество

SELECT name, year, COUNT(*) FROM movieexec
JOIN movie ON cert# = producerc#
GROUP BY cert#, name, year;

--Да се напише заявка, която да изведе името на най-младата звезда (полът е без значение)

SELECT name FROM moviestar
WHERE birthdate IN (SELECT MAX(birthdate) FROM moviestar);

SELECT name FROM moviestar
WHERE birthdate >= ALL (SELECT birthdate FROM moviestar WHERE birthdate IS NOT NULL);

--2019 july

--Да се огради буквата на заявката, която извежда име на студио и 
--броя на филмите му, за тези студия с по-малко от два филма.
--Студиата, които нямат нито един филм, НЕ трябва да присъстват в резултата

SELECT name, COUNT(title) AS CNT FROM
studio JOIN movie ON name = studioname
GROUP BY name
HAVING COUNT(title) < 2;

--Да се напише заявка, която да изведе имената на всички продуценти с минимален нетен актив

SELECT name FROM movieexec
WHERE networth <= ALL (SELECT networth FROM movieexec WHERE networth IS NOT NULL);

SELECT name FROM movieexec
WHERE networth IN (SELECT MIN(networth) FROM movieexec);

--2018 september
USE ships;

--Да се напише заявка, която извежда име на клас, годината на първата битка, в която кораб на този 
--клас е участвал, годината на последната битка, в която кораб на този клас е участвал, и броя на 
--всички различни битки, в които кораби на този клас са участвали, само за тези класове, започващи с 
--буквата N. Ако за даден клас няма кораб, който да е участвал в битка, за съответните години да се 
--върне стойност null

SELECT class, YEAR(MIN(date)), YEAR(MAX(date)), COUNT(DISTINCT battles.name) FROM ships
LEFT JOIN outcomes ON ships.name = outcomes.ship
LEFT JOIN battles ON outcomes.battle = battles.name
WHERE class LIKE 'N%'
GROUP BY class;

--Да се напише заявка, която да изведе имената на тези битки, за които броят на корабите от тип 'bb', 
--участвали в тази битка, е по-голям от броя на корабите от тип 'bc', участвали в същата битка. Битки, 
--в които не е участвал нито един кораб, да не се извеждат в резултата
SELECT t1.battle FROM
	(SELECT battle, COUNT(*) AS bb_type_count FROM
	outcomes JOIN ships ON ship = name
	JOIN classes ON ships.class = classes.class
	WHERE type = 'bb'
	GROUP BY battle) t1
LEFT JOIN
	(SELECT battle, COUNT(*) AS bc_type_count FROM
	outcomes JOIN ships ON ship = name
	JOIN classes ON ships.class = classes.class
	WHERE type = 'bc'
	GROUP BY battle) t2
ON t1.battle = t2.battle
WHERE bb_type_count > bc_type_count OR bc_type_count IS NULL

SELECT battle FROM outcomes o1
JOIN ships ON ships.name = o1.ship
JOIN classes ON classes.class = ships.class
WHERE type = 'bb'
GROUP BY o1.battle
HAVING COUNT(*) > (
	SELECT COUNT(*) FROM outcomes o2
	JOIN ships ON ships.name = o2.ship
	JOIN classes ON classes.class = ships.class
	WHERE type = 'bc' AND o1.battle = o2.battle
);

--2018 july
USE movies;

--Да се напише заявка, която да изведе име на студио, годината на първия филм за това студио, 
--годината на последния филм за това студио и броя на всички филми за това студио, само за тези 
--студиа започващи с буквата ‘M’

SELECT name, MIN(year) AS first_movie, MAX(year) AS last_movie, COUNT(*) movies_count FROM studio
JOIN movie ON name = studioname
WHERE name LIKE 'M%'
GROUP BY name;

--Да се напише заявка, която да изведе името на актрисата, участвала в най-много филми, и броя на 
--филмите, в които е участвала

SELECT name, COUNT(movietitle) AS movies_count FROM moviestar
JOIN starsin ON name = starname
WHERE gender = 'F'
GROUP BY name
HAVING COUNT(movietitle) >= ALL (
	SELECT COUNT(movietitle) FROM moviestar
	JOIN starsin ON name = starname
	WHERE gender = 'F'
	GROUP By name);
