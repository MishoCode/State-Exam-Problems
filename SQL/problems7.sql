USE ships;

SELECT class, MIN(YEAR(date)), MAX(YEAR(date)), COUNT(DISTINCT battle)
FROM battles LEFT JOIN outcomes ON battles.name = battle
LEFT JOIN ships ON ships.name = ship
WHERE class LIKE 'N%'
GROUP BY class;

SELECT battle FROM outcomes o1
JOIN ships ON name = ship
JOIN classes ON ships.class = classes.class
WHERE type = 'bb'
GROUP BY battle
HAVING COUNT(*) > (
	SELECT COUNT(*) FROM outcomes o2
	JOIN ships ON name = ship
	JOIN classes ON ships.class = classes.class
	WHERE type = 'bc' AND o1.battle = o2.battle
);

USE movies;

SELECT name, COUNT(movietitle) FROM moviestar
LEFT JOIN starsin ON name = starname
WHERE gender = 'F'
GROUP BY name
HAVING COUNT(movietitle) >= ALL (SELECT COUNT(movietitle) FROM moviestar
LEFT JOIN starsin ON name = starname WHERE gender = 'F' GROUP BY name);