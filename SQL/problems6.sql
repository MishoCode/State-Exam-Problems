--2016 september

USE ships;


--Да се посочи заявката, която извежда всички държави, които имат поне един кораб, участвал в 
--битка, както и броя на потъналите кораби за всяка от държавите


SELECT country, COUNT(result) FROM classes
JOIN ships ON ships.class = classes.class
JOIN outcomes ON name = ship
WHERE result = 'sunk'
GROUP BY country;

--Да се посочи заявката, която извежда имената на битките, които са по-мащабни (с кораби от повече 
--държави) от битката в Коралово море (Coral Sea)

SELECT DISTINCT battle FROM outcomes o1
WHERE (
	SELECT COUNT(DISTINCT country) FROM outcomes o, ships s, classes c
	WHERE o.ship = s.name AND s.class = c.class AND o.battle = o1.battle
) > (
	SELECT COUNT(DISTINCT country) FROM outcomes o, ships s, classes c
	WHERE o.ship = s.name AND s.class = c.class AND battle = 'Coral Sea'
);


-- 2016 july

USE movies;

--Да се посочи заявката, която извежда името на продуцента и имената на филмите, 
--продуцирани от продуцента на 'Pretty Woman'. Възможно е името на продуцента на филма да 
--не е известно

SELECT name, title FROM movie m
JOIN (
	SELECT name, cert# FROM movieexec
	WHERE cert# IN (
		SELECT producerc# FROM movie
		WHERE title = 'Pretty Woman'
	)
) t ON producerc# = t.cert#;


--Да се посочи заявката, която за актьорите, участвали в най­много филми на съответното 
--студио, извежда име на студио, име на актьор и брой филми, в които е участвал актьорът. В 
--резултата ?не? трябва да се включват филми, за които името на студиото не е известно

SELECT studioname, starname, COUNT(*) FROM movie m
JOIN starsin ON title = movietitle AND year = movieyear
WHERE studioname IS NOT NULL
GROUP BY studioname, starname
HAVING COUNT(*) >= ALL (
	SELECT COUNT(*) FROM movie, starsin
	WHERE title = movietitle AND year = movieyear AND m.studioname = studioname
	GROUP BY studioname, starname
);