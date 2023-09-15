USE pc;

--Напишете заявка, която извежда средната честота на процесорите на
--компютрите
SELECT AVG(speed) FROM pc;

--Напишете заявка, която за всеки производител извежда средния
--размер на екраните на неговите лаптопи
SELECT maker, AVG(screen) FROM product
JOIN laptop ON product.model = laptop.model
GROUP BY maker;

--Напишете заявка, която извежда средната честота на лаптопите с
--цена над 1000
SELECT AVG(speed) FROM laptop
WHERE price > 1000;

--Напишете заявка, която извежда средната цена на компютрите,
--произведени от производител ‘A’
SELECT AVG(price) FROM product
JOIN pc ON product.model = pc.model
WHERE maker = 'A';

--Напишете заявка, която извежда средната цена на компютрите и
--лаптопите на производител ‘B’ (едно число)
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

--Напишете заявка, която извежда средната цена на компютрите
--според различните им честоти на процесорите
SELECT speed, AVG(price) AS average_price FROM pc
GROUP BY speed;

--Напишете заявка, която извежда производителите, които са
--произвели поне по 3 различни модела компютъра
SELECT maker FROM product
WHERE type = 'pc'
GROUP BY maker
HAVING COUNT(*) >= 3;

--Напишете заявка, която извежда производителите на компютрите с
--най-висока цена
SELECT DISTINCT maker FROM product
JOIN pc ON product.model = pc.model
WHERE price = (
	SELECT MAX(price) FROM pc
);


--Напишете заявка, която извежда средната цена на компютрите за
--всяка честота, по-голяма от 800 MHz
SELECT speed, AVG(price) FROM pc
WHERE speed > 800
GROUP BY speed;

--Напишете заявка, която извежда средния размер на диска на тези
--компютри, произведени от производители, които произвеждат и
--принтери
SELECT AVG(hd) FROM pc
JOIN product ON product.model = pc.model
WHERE maker IN (
	SELECT maker FROM product
	WHERE type = 'Printer'
);

--Напишете заявка, която за всеки размер на лаптоп намира
--разликата в цената на най-скъпия и най-евтиния лаптоп със същия
--размер
SELECT screen, MAX(price) - MIN(price) AS price_difference FROM laptop
GROUP BY screen;


USE ships;

--Напишете заявка, която извежда средния
--брой на оръдията (numguns) за всички
--кораби, пуснати на вода (т.е. изброени са в
--таблицата Ships)
SELECT AVG(numguns) FROM classes
JOIN ships ON classes.class = ships.class;

--Напишете заявка, която извежда за всеки
--клас първата и последната година, в която
--кораб от съответния клас е пуснат на вода
SELECT class, MIN(launched) AS first_year, MAX(launched) AS last_year FROM ships
GROUP BY class;

--Напишете заявка, която за всеки клас
--извежда броя на корабите, потънали в битка
SELECT class, COUNT(*) AS sunk_ships_count FROM ships
JOIN outcomes ON name = ship
WHERE result = 'sunk'
GROUP BY class;

--Напишете заявка, която за всеки клас с
--над 4 пуснати на вода кораба извежда
--броя на корабите, потънали в битка
SELECT class, COUNT(*) AS sunk_ships_count FROM ships
JOIN outcomes ON ship = name
WHERE result = 'sunk' AND class IN (
	SELECT class FROM ships
	GROUP BY class
	HAVING COUNT(*) > 4
)
GROUP BY class;

--Напишете заявка, която извежда средното
--тегло на корабите (displacement) за всяка страна
SELECT country, AVG(displacement) AS avg_displacement FROM classes
GROUP BY country;