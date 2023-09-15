USE movies;

SELECT title, movie.length FROM movie
WHERE incolor = 'Y' AND
length < (SELECT MAX(length) FROM movie WHERE incolor = 'Y');

SELECT name FROM studio
LEFT JOIN movie ON name = studioname
GROUP BY name
HAVING COUNT(DISTINCT year) <= 1;

USE ships;

SELECT class,
	YEAR(MIN(battles.date)) AS first_battle,
	YEAR(MAX(battles.date)) AS last_battle,
	COUNT(DISTINCT battle) AS battles_count
FROM ships
LEFT JOIN outcomes ON outcomes.ship = ships.name
LEFT JOIN battles ON battles.name = outcomes.battle
WHERE class LIKE 'N%'
GROUP BY class;

SELECT battle FROM outcomes o1
JOIN ships ON ships.name = o1.ship
JOIN classes ON ships.class = classes.class
WHERE type = 'bb'
GROUP BY o1.battle
HAVING COUNT(*) >
(
	SELECT COUNT(*) FROM outcomes o2
	JOIN ships ON ships.name = o2.ship
	JOIN classes ON classes.class = ships.class
	WHERE type = 'bc' AND o1.battle = o2.battle
);


--2017 september

USE ships;

--�������� �� ������ ��� � ������� �� ��������, 
--����� ������ �� �� �������� � ����� (���� � �� �� �� ���������)
SELECT name, country FROM ships
LEFT JOIN outcomes ON name = ship
LEFT JOIN classes ON classes.class = ships.class
WHERE result NOT LIKE 'sunk';

--�������� �� ������ ���, ��������������� � ���� 
--������ �� ���-������ ������ � ���-����� ������
SELECT name, displacement, numguns FROM classes c
JOIN ships ON c.class = ships.class
WHERE displacement = (SELECT MIN(displacement) FROM classes)
AND numguns = (SELECT MAX(numguns) FROM classes c1 WHERE c1.class = c.class);


--�������� �� ������ ��� �� �������, � ����� � 
--�������� ���� �����
SELECT battle FROM outcomes o1
WHERE NOT EXISTS
(
	SELECT * FROM outcomes o2
	WHERE o2.battle = o1.battle AND o2.ship <> o1.ship
)

--�������� �� ������ ��� �� ����� � ���� �� ���������� � ����� ������ �� ���������� ����, �� 
--���� ������� � ������ �� 5 ������

SELECT class, COUNT(DISTINCT name) FROM ships
JOIN outcomes ON name = ship
WHERE result = 'sunk' AND class IN (
	SELECT c.class FROM classes c
	JOIN ships s ON c.class = s.class
	GROUP BY c.class
	HAVING COUNT(name) > 5
)
GROUP BY class;


--2017 july

USE movies;

--�������� �� ������ �� ����� ������ ����� �� 
--��������, ���������� � �������� �� �����, ������� �������� �� ����� �� ���� ������
SELECT studioname, title, year FROM movie m
WHERE year = (
	SELECT MAX(year) FROM movie
	WHERE m.studioname = movie.studioname
);


--�������� �� ������ ��� �� ��������� � ����
--������� �� ������������� �� ���� �����, �� ���� ����������, ����� ���� ���� ���� ���� ����� 1980 �
SELECT name, SUM(length) FROM movieexec
JOIN movie ON producerc# = cert#
GROUP BY name
HAVING MIN(year) < 1980;

--�������� �� ������ ��� �� ���������, ��������� 
--��� ����� �� ���������� � ���-������ ����� ������, ����� � �������� �� �������, � ����� �� ���������, ��� �� 
--��������� � ����� ������
SELECT starname, title, name, networth FROM starsin
JOIN movie ON movietitle = title AND movieyear = year
JOIN (
	SELECT cert#, networth, name FROM movieexec
	WHERE networth = (SELECT MAX(networth) FROM movieexec)
) t ON producerc# = t.cert#;


--�������� �� ������� ������� ����� �� ����������, ���������� � �������� �� ������ �����, 
--����������� �� ���������� �� ����� �Interstellar�
SELECT name, title, year FROM movieexec
JOIN movie ON producerc# = cert#
WHERE cert# = ANY (
	SELECT producerc# FROM movie
	WHERE title = 'Interstellar'
);