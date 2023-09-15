USE movies;

--�� ����� ������/������� �������� ���� �� ���������� ������, � ����� �� ��������� �����.
--�������� � ����, �� ����� ���� ���������� � ��� ����� �� ������
SELECT name, COUNT(DISTINCT studioname) FROM moviestar
LEFT JOIN starsin ON name = starname
LEFT JOIN movie ON movietitle = title AND movieyear = year
WHERE gender = 'M'
GROUP BY name;

--�������� ������� �� ���������, ��������� � ���� 3 ����� ���� 1990 �
SELECT name FROM moviestar
JOIN starsin ON name = starname
WHERE gender = 'M' AND movieyear > 1990
GROUP BY name
HAVING COUNT(*) >= 3;

USE pc;

--�� �� ������� ���������� ������ ��������, ��������� �� ���� �� ���-������ ���������
--�������� �� ����� �����
SELECT model FROM pc
GROUP BY model
ORDER BY MAX(price);

USE ships;

--�������� ���� �� ���������� ����������� ������ �� ����� ��������� ����� � ���� ����
--������� ����������� �����
SELECT battle, COUNT(*) AS sunk_ships FROM outcomes
JOIN ships ON name = ship
JOIN classes ON classes.class = ships.class
WHERE result = 'sunk' AND country = 'USA'
GROUP BY battle;

--�������, � ����� �� ��������� ���� 3 ������ �� ���� � ���� ������
SELECT DISTINCT battle FROM outcomes
JOIN ships ON name = ship
JOIN classes ON classes.class = ships.class
GROUP BY battle, country
HAVING COUNT(*) >= 3;

--������� �� ���������, �� ����� ���� �����, ������ �� ���� ���� 1921 �., �� ���� ������
--���� ���� �����
SELECT class FROM ships
GROUP BY class
HAVING MAX(launched) <= 1921;


--�� ����� ����� ���� �� �������, � ����� � ��� ������� (result = �damaged�). ��� �������
--�� � �������� � ����� ��� ��� ������ �� � ��� ��������, � ��������� �� �� ������ 0
SELECT name, COUNT(battle) AS damaged_battles FROM ships
LEFT JOIN outcomes ON ship = name AND result = 'damaged'
GROUP BY name;

SELECT name, (
	SELECT COUNT(*) FROM outcomes o
	WHERE result = 'damaged' AND o.ship = s.name
) FROM ships s;

--�������� �� ����� ���� � ���� 3 ������ ���� �� �������� �� ���� ����, ����� ��
--�������� � ����� (result = 'ok')
SELECT class, COUNT(DISTINCT ship) FROM ships
LEFT JOIN outcomes ON ship = name AND result = 'ok'
GROUP BY class
HAVING COUNT(DISTINCT name) >= 3;

--�� ����� ����� �� �� ������ ����� �� �������, �������� �� ������� � ����� �� ����������
--������, ����� �� ����������� ������ � ����� �� �������� ��� �������
SELECT battle, date,
	SUM(CASE result WHEN 'sunk' THEN 1 ELSE 0 END) AS sunk_count,
	SUM(CASE result WHEN 'damaged' THEN 1 ELSE 0 END) AS damaged_count,
	SUM(CASE result WHEN 'ok' THEN 1 ELSE 0 END) AS ok_count
FROM outcomes
JOIN battles ON battle = name
GROUP BY battle, date;

--�������� ������� �� �������, � ����� �� ��������� ���� 3 ������ � ��� 9 ������ � ��
--��� ���� ��� �� � �������� �ok�
SELECT battle FROM outcomes
JOIN ships ON ship = name
JOIN classes ON classes.class = ships.class
WHERE numguns < 9
GROUP BY battle
HAVING COUNT(*) >= 3 AND SUM(CASE result WHEN 'ok' THEN 1 ELSE 0 END) >= 2;


