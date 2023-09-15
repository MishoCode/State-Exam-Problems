--2016 september

USE ships;


--�� �� ������ ��������, ����� ������� ������ �������, ����� ���� ���� ���� �����, �������� � 
--�����, ����� � ���� �� ���������� ������ �� ����� �� ���������

SELECT country, COUNT(result) FROM classes
JOIN ships ON ships.class = classes.class
JOIN outcomes ON name = ship
WHERE result = 'sunk'
GROUP BY country;

--�� �� ������ ��������, ����� ������� ������� �� �������, ����� �� ��-������� (� ������ �� ������ 
--�������) �� ������� � �������� ���� (Coral Sea)

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

--�� �� ������ ��������, ����� ������� ����� �� ���������� � ������� �� �������, 
--����������� �� ���������� �� 'Pretty Woman'. �������� � ����� �� ���������� �� ����� �� 
--�� � ��������

SELECT name, title FROM movie m
JOIN (
	SELECT name, cert# FROM movieexec
	WHERE cert# IN (
		SELECT producerc# FROM movie
		WHERE title = 'Pretty Woman'
	)
) t ON producerc# = t.cert#;


--�� �� ������ ��������, ����� �� ���������, ��������� � �������� ����� �� ����������� 
--������, ������� ��� �� ������, ��� �� ������ � ���� �����, � ����� � �������� ��������. � 
--��������� ?��? ������ �� �� �������� �����, �� ����� ����� �� �������� �� � ��������

SELECT studioname, starname, COUNT(*) FROM movie m
JOIN starsin ON title = movietitle AND year = movieyear
WHERE studioname IS NOT NULL
GROUP BY studioname, starname
HAVING COUNT(*) >= ALL (
	SELECT COUNT(*) FROM movie, starsin
	WHERE title = movietitle AND year = movieyear AND m.studioname = studioname
	GROUP BY studioname, starname
);