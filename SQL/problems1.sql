USE movies;

SELECT name FROM moviestar JOIN starsin
ON name = starname
WHERE gender = 'F' AND movietitle = 'Terms of Endearment';

SELECT DISTINCT starname FROM starsin JOIN movie
ON movietitle = title AND movieyear = year
WHERE studioname = 'MGM' AND year = 1995;

USE pc;

SELECT p.model, price  FROM laptop JOIN product p
ON laptop.model = p.model
WHERE maker = 'B'
UNION
SELECT p.model, price  FROM pc JOIN product p
ON pc.model = p.model
WHERE maker = 'B'
UNION
SELECT p.model, price  FROM printer JOIN product p
ON printer.model = p.model
WHERE maker = 'B'
ORDER BY price DESC

SELECT DISTINCT p1.hd FROM pc p1 JOIN pc p2
ON p1.hd = p2.hd
WHERE p1.code <> p2.code;

SELECT DISTINCT p1.model, p2.model FROM pc p1 JOIN pc p2
ON p1.speed = p2.speed AND p1.ram = p2.ram
WHERE p1.model < p2.model;

SELECT maker FROM product JOIN pc
ON pc.model = product.model
WHERE speed >= 1000
GROUP BY maker
HAVING COUNT(code) >= 2;

USE ships;

SELECT country FROM classes
WHERE type = 'bb'
INTERSECT
SELECT country FROM classes
WHERE type = 'bc';

SELECT DISTINCT c1.country FROM classes c1 JOIN classes c2
ON c1.country = c2.country
WHERE c1.type = 'bb' AND c2.type = 'bc';

--2022 september
USE movies;

SELECT title, length FROM movie
WHERE incolor = 'Y' AND
length < (SELECT MAX(length) FROM movie WHERE incolor = 'Y');

SELECT name FROM studio LEFT JOIN movie
ON name = studioname
GROUP BY name
HAVING COUNT(DISTINCT year) = 1;

--2022 july

SELECT s.name, m.title FROM movie m JOIN studio s
ON m.studioname = s.name
WHERE s.name IN (SELECT studioname FROM movie WHERE title = 'The Usual Suspects') ;

SELECT ms.name, si.movietitle FROM moviestar ms JOIN starsin si
ON ms.name = si.starname
WHERE si.movietitle IS NULL;

--2021 september

SELECT studioname FROM movie
WHERE incolor = 'Y'
INTERSECT
SELECT studioname FROM movie
WHERE length IS NULL;

SELECT name, COUNT(title) FROM moviestar
LEFT JOIN starsin ON name = starname
LEFT JOIN movie ON movietitle = title AND movieyear = year AND incolor = 'N'
WHERE gender = 'F'
GROUP BY name;

--2021 july
USE pc;

--�������� ��������, ����� ������� �������� � ������ �� ������ �������, ����� ����� �
--� �������� ����� 13 � 15 ���� ����������� � �� ����� ���������� ���� ���� ���������� ��������
--��� ������ ���������� RAM �����

SELECT code, price FROM laptop
WHERE screen BETWEEN 13 AND 15 AND
ram IN (SELECT ram FROM pc);

--������ 2: �� ����� ������������ �� �� ������ ����� � ����� 15-������ �������. ��� ����� ���-
--��������� ���� ������� ������� ��� ���, �� ���� ���� �� ��� �� � 15-�����, ����� ����� �� �� ��
--������ ������� 0

SELECT maker, COUNT(code) FROM laptop RIGHT JOIN product
ON laptop.model = product.model AND screen = 15
GROUP BY maker;

SELECT maker, COUNT(code) FROM product LEFT JOIN laptop
ON product.model = laptop.model AND screen = 15
GROUP BY maker;

--���� �� ��������� �� ��������� ����� �������, �� ����� screen � NULL ���� LEFT JOIN
SELECT maker, COUNT(code) FROM product LEFT JOIN laptop
ON product.model = laptop.model
WHERE screen = 15
GROUP BY maker;

--2020 september
USE movies;

--�� �� ������ ������, ����� ������� ������� � �������� �� ������ ������, ����� ���� ����
--���� ������ � ���� ���� �����-��� ����. ���������� �� �� ������� ��������� �� �����
SELECT DISTINCT studioname, address FROM movie JOIN studio
ON studioname = name
WHERE studioname IN (
	SELECT studioname FROM movie
	WHERE incolor = 'Y'
	INTERSECT
	SELECT studioname FROM movie
	WHERE incolor = 'Y'
)
ORDER BY address;

SELECT DISTINCT name, address
FROM Studio JOIN Movie ON name = studioName
WHERE inColor = 'Y' AND name IN (SELECT name 
                                 FROM Studio JOIN Movie ON name = studioName
                                 WHERE inColor = 'N')
ORDER BY address;

--�� �� ������ ������, ����� �� ����� ������ � ���-����� ��� ����� �������:
--����� ��;
--������;
--�������� ������� �� ������� �� ���� ������.
--������ ��� ����� ���� �� �� ������� (�� ������ ������� �� �� ������� null ��� 0)

SELECT name, address, AVG(length) FROM studio LEFT JOIN movie
ON name = studioname
GROUP by name, address
HAVING COUNT(*) <= 3;

--2020 august
USE movies;

--�� �� ������ ������, ����� ������� ������� � ��������� ���� �� ������ ������� ������, �����
--��� �� ������� "Jr." � �� ������ � ���� ���� ������ ����. ����� �� �� ������� ���-������� ������,
--� ������, ������ �� ���� � ���� ����, �� �� ������� �� ������� ���
SELECT name, birthdate FROM moviestar
WHERE name NOT LIKE '%Jr.%' AND
name IN (
	SELECT starname FROM movie JOIN starsin
	ON title = movietitle AND year = movieyear
	WHERE incolor = 'Y'
	)
ORDER BY BIRTHDATE DESC, name;

SELECT DISTINCT name, birthdate
FROM moviestar INNER JOIN starsin ON name = starname
INNER JOIN Movie ON movieTitle = title AND movieYear = year
WHERE name NOT LIKE '%Jr.%' AND inColor = 'Y'
ORDER BY birthdate DESC, name ASC;


--�� �� ������ ������, ����� ������� �������� ���������� �� ����� �������, ������ � ���-�����
--6 �����:
--���;
--������� ������ (����. ��� ��������� � ������ �� 1.1.1995 �., � �������� �� ���� 1995);
--���� �������� ������, � ����� � ��������.
--��� �� ������ ������� ���� ���������� � ����� ����� � ������, �� ��� ���� �� �� ������ ��� � �������
--����������, ���� �� ���� ������ �� ������ 0

SELECT name, YEAR(birthdate), COUNT(DISTINCT studioname) FROM moviestar LEFT JOIN starsin
ON name = starname
LEFT JOIN movie ON title = movietitle AND year = movieyear
WHERE gender = 'F'
GROUP BY name, YEAR(birthdate)
HAVING COUNT(movietitle) <= 6;

SELECT name, YEAR(birthdate) AS birthdate, COUNT(DISTINCT studioName) AS studio_cnt
FROM MovieStar LEFT JOIN StarsIn ON name = starName
    LEFT JOIN Movie ON movieTitle = title AND movieYear = year
WHERE gender = 'F'
GROUP BY name, YEAR(birthdate)
HAVING COUNT(studioName) < 7;

