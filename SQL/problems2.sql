USE movies;

SELECT movietitle, movieyear, starname FROM starsin JOIN moviestar
ON name = starname
WHERE gender = 'M' AND starname NOT LIKE '%k%' AND starname NOT LIKE '%b%'
AND movieyear < 1982;

USE ships;
-- 5. �������� ���� �� ���������� ����������� ������ �� 
-- ����� ��������� ����� � ���� ���� ������� �����������
-- �����.

SELECT battle, COUNT(*) FROM outcomes JOIN ships
ON ship = name
JOIN classes
ON classes.class = ships.class
WHERE country = 'USA' AND result = 'sunk'
GROUP BY battle;

-- 6. �������, � ����� �� ��������� ���� 3 ������ �� 
-- ���� � ���� ������.

SELECT DISTINCT battle FROM outcomes
JOIN ships ON name = ship
JOIN classes ON classes.class = ships.class
GROUP BY battle, country
HAVING COUNT(*) >= 3;

-- �� ����� ���� �� �� ������ ����� ��, ��������� � ������� ������, 
-- � ����� � ������ ����� �� ���� ����

SELECT classes.class, MIN(country) AS country, MIN(launched) AS first_year FROM classes
JOIN ships ON classes.class = ships.class
GROUP BY classes.class;

--�� ����� ���� � ������ - ����� �� �����, ����� �� ���������� ����� � ���� ������

SELECT class, MIN(name), COUNT(*) FROM ships
GROUP BY class;

-- 7. ������� �� ���������, �� ����� ���� �����, ������
-- �� ���� ���� 1921 �., �� ���� ������ ���� ���� �����.

SELECT class FROM ships
GROUP BY class
HAVING MAX(launched) <= 1921;

-- 8. �� ����� ����� �� �� ������ ����� �� �������, � ����� � ��� �������.
-- ��� ������� �� � �������� � ����� ��� ��� ������ �� � ���
-- ��������, � ��������� �� �� ������ 0.

SELECT name, COUNT(battle) AS damaged_battles_count FROM ships
LEFT JOIN outcomes ON name = ship AND result = 'damaged'
GROUP BY name;

--2019 september
USE movies;

--�� �� ������ ������� �� ��������, ����� ������� �� ����� ��������� ����� �� � ���� �� ���-
--���� �� �� ������. ����������, ����� ����� ���� ���� ����, �� ������ �� ���������� � ������������
--���������

SELECT name, year, COUNT(*) FROM movieexec
JOIN movie ON cert# = producerc#
GROUP BY cert#, name, year;

--�� �� ������ ������, ����� �� ������ ����� �� ���-������� ������ (����� � ��� ��������)

SELECT name FROM moviestar
WHERE birthdate IN (SELECT MAX(birthdate) FROM moviestar);

SELECT name FROM moviestar
WHERE birthdate >= ALL (SELECT birthdate FROM moviestar WHERE birthdate IS NOT NULL);

--2019 july

--�� �� ������ ������� �� ��������, ����� ������� ��� �� ������ � 
--���� �� ������� ��, �� ���� ������ � ��-����� �� ��� �����.
--��������, ����� ����� ���� ���� ����, �� ������ �� ���������� � ���������

SELECT name, COUNT(title) AS CNT FROM
studio JOIN movie ON name = studioname
GROUP BY name
HAVING COUNT(title) < 2;

--�� �� ������ ������, ����� �� ������ ������� �� ������ ���������� � ��������� ����� �����

SELECT name FROM movieexec
WHERE networth <= ALL (SELECT networth FROM movieexec WHERE networth IS NOT NULL);

SELECT name FROM movieexec
WHERE networth IN (SELECT MIN(networth) FROM movieexec);

--2018 september
USE ships;

--�� �� ������ ������, ����� ������� ��� �� ����, �������� �� ������� �����, � ����� ����� �� ���� 
--���� � ��������, �������� �� ���������� �����, � ����� ����� �� ���� ���� � ��������, � ���� �� 
--������ �������� �����, � ����� ������ �� ���� ���� �� ���������, ���� �� ���� �������, ��������� � 
--������� N. ��� �� ����� ���� ���� �����, ����� �� � �������� � �����, �� ����������� ������ �� �� 
--����� �������� null

SELECT class, YEAR(MIN(date)), YEAR(MAX(date)), COUNT(DISTINCT battles.name) FROM ships
LEFT JOIN outcomes ON ships.name = outcomes.ship
LEFT JOIN battles ON outcomes.battle = battles.name
WHERE class LIKE 'N%'
GROUP BY class;

--�� �� ������ ������, ����� �� ������ ������� �� ���� �����, �� ����� ����� �� �������� �� ��� 'bb', 
--��������� � ���� �����, � ��-����� �� ���� �� �������� �� ��� 'bc', ��������� � ������ �����. �����, 
--� ����� �� � �������� ���� ���� �����, �� �� �� �������� � ���������
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

--�� �� ������ ������, ����� �� ������ ��� �� ������, �������� �� ������ ���� �� ���� ������, 
--�������� �� ��������� ���� �� ���� ������ � ���� �� ������ ����� �� ���� ������, ���� �� ���� 
--������ ��������� � ������� �M�

SELECT name, MIN(year) AS first_movie, MAX(year) AS last_movie, COUNT(*) movies_count FROM studio
JOIN movie ON name = studioname
WHERE name LIKE 'M%'
GROUP BY name;

--�� �� ������ ������, ����� �� ������ ����� �� ���������, ��������� � ���-����� �����, � ���� �� 
--�������, � ����� � ���������

SELECT name, COUNT(movietitle) AS movies_count FROM moviestar
JOIN starsin ON name = starname
WHERE gender = 'F'
GROUP BY name
HAVING COUNT(movietitle) >= ALL (
	SELECT COUNT(movietitle) FROM moviestar
	JOIN starsin ON name = starname
	WHERE gender = 'F'
	GROUP By name);
