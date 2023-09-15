USE pc;

--�������� ������, ����� ������� �������� ������� �� ����������� ��
--����������
SELECT AVG(speed) FROM pc;

--�������� ������, ����� �� ����� ������������ ������� �������
--������ �� �������� �� �������� �������
SELECT maker, AVG(screen) FROM product
JOIN laptop ON product.model = laptop.model
GROUP BY maker;

--�������� ������, ����� ������� �������� ������� �� ��������� �
--���� ��� 1000
SELECT AVG(speed) FROM laptop
WHERE price > 1000;

--�������� ������, ����� ������� �������� ���� �� ����������,
--����������� �� ������������ �A�
SELECT AVG(price) FROM product
JOIN pc ON product.model = pc.model
WHERE maker = 'A';

--�������� ������, ����� ������� �������� ���� �� ���������� �
--��������� �� ������������ �B� (���� �����)
SELECT AVG(price) AS average_price FROM
(
	SELECT price FROM laptop
	JOIN product ON laptop.model = product.model
	WHERE maker = 'B'
	UNION ALL
	SELECT price FROM pc
	JOIN product ON product.model = pc.model
	WHERE maker = 'B'
) all_prices;

--�������� ������, ����� ������� �������� ���� �� ����������
--������ ���������� �� ������� �� �����������
SELECT speed, AVG(price) AS average_price FROM pc
GROUP BY speed;

--�������� ������, ����� ������� ���������������, ����� ��
--��������� ���� �� 3 �������� ������ ���������
SELECT maker FROM product
WHERE type = 'pc'
GROUP BY maker
HAVING COUNT(*) >= 3;

--�������� ������, ����� ������� ��������������� �� ���������� �
--���-������ ����
SELECT DISTINCT maker FROM product
JOIN pc ON product.model = pc.model
WHERE price = (
	SELECT MAX(price) FROM pc
);


--�������� ������, ����� ������� �������� ���� �� ���������� ��
--����� �������, ��-������ �� 800 MHz
SELECT speed, AVG(price) FROM pc
WHERE speed > 800
GROUP BY speed;

--�������� ������, ����� ������� ������� ������ �� ����� �� ����
--��������, ����������� �� �������������, ����� ����������� �
--��������
SELECT AVG(hd) FROM pc
JOIN product ON product.model = pc.model
WHERE maker IN (
	SELECT maker FROM product
	WHERE type = 'Printer'
);

--�������� ������, ����� �� ����� ������ �� ������ ������
--��������� � ������ �� ���-������ � ���-������� ������ ��� �����
--������
SELECT screen, MAX(price) - MIN(price) AS price_difference FROM laptop
GROUP BY screen;


USE ships;

--�������� ������, ����� ������� �������
--���� �� �������� (numguns) �� ������
--������, ������� �� ���� (�.�. �������� �� �
--��������� Ships)
SELECT AVG(numguns) FROM classes
JOIN ships ON classes.class = ships.class;

--�������� ������, ����� ������� �� �����
--���� ������� � ���������� ������, � �����
--����� �� ���������� ���� � ������ �� ����
SELECT class, MIN(launched) AS first_year, MAX(launched) AS last_year FROM ships
GROUP BY class;

--�������� ������, ����� �� ����� ����
--������� ���� �� ��������, �������� � �����
SELECT class, COUNT(*) AS sunk_ships_count FROM ships
JOIN outcomes ON name = ship
WHERE result = 'sunk'
GROUP BY class;

--�������� ������, ����� �� ����� ���� �
--��� 4 ������� �� ���� ������ �������
--���� �� ��������, �������� � �����
SELECT class, COUNT(*) AS sunk_ships_count FROM ships
JOIN outcomes ON ship = name
WHERE result = 'sunk' AND class IN (
	SELECT class FROM ships
	GROUP BY class
	HAVING COUNT(*) > 4
)
GROUP BY class;

--�������� ������, ����� ������� ��������
--����� �� �������� (displacement) �� ����� ������
SELECT country, AVG(displacement) AS avg_displacement FROM classes
GROUP BY country;