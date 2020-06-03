--#2. Добавьте таблицы
CREATE TABLE "dvd" (
	"dvd_id"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"title"	TEXT NOT NULL,
	"production_year"	TEXT NOT NULL
);

CREATE TABLE "customer" (
	"customer_id"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"first_name"	TEXT NOT NULL,
	"last_name"	TEXT NOT NULL,
	"passport_code"	INTEGER NOT NULL,
	"registration_date"	TEXT NOT NULL
);

CREATE TABLE "offer" (
	"offer_id"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"dvd_id"	INTEGER NOT NULL,
	"customer_id"	INTEGER NOT NULL,
	"offer_date"	TEXT NOT NULL,
	"return_date"	TEXT NOT NULL,
	FOREIGN KEY(dvd_id) REFERENCES dvd(dvd_id),
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

--#3.Подготовьте SQL запросы для заполнения таблиц данными.
INSERT INTO dvd (title, production_year)
VALUES
	('Гонщик нереальный', '2003'),
	('Тачки 2', '2010'),
	('Брат 2', '1999'),
	('Ночной дозор', '2004'),
	('Трон', '2010'),
	('Звёздные войны. Эпизод III: Месть ситхов', '2005'),
	('Матрицы', '1999');
	
INSERT INTO customer (first_name, last_name, passport_code, registration_date)
VALUES
	('Саша', 'Десантов', '123456', '2004-07-07'),
	('Рома', 'Сапожников', '321411', '2005-05-15'),
	('Иван', 'Бачурин', '234769', '2007-02-11'),
	('Кирилл', 'Лаптев', '110836', '2005-05-17');
	
INSERT INTO offer (dvd_id, customer_id, offer_date, return_date)
VALUES
	(3, 1, '2005-06-06', '2005-07-06'),
	(1, 2, '2006-12-09', '2006-13-09'),
	(4, 2, '2006-12-09', '2006-13-09'),
	(6, 4, '2007-07-12', '2007-08-12'),
	(2, 3, '2011-08-11', '2011-09-11'),
	(5, 2, '2011-11-11', '2012-01-11'),
	(2, 3, '2020-04-11', '2020-08-11');
	
--#4.Подготовьте SQL запрос получения списка всех DVD, год выпуска которых 2010, отсортированных в алфавитном порядке по названию DVD
SELECT *
FROM dvd
WHERE 
	production_year = '2010'
ORDER BY title ASC;

--#5.Подготовьте SQL запрос для получения списка DVD дисков, которые в настоящее время находятся у клиентов
SELECT dvd.dvd_id, dvd.title
FROM dvd
INNER JOIN offer ON dvd.dvd_id = offer.dvd_id
WHERE
	offer.offer_date <= date('now') AND date('now') <= offer.return_date;

--#6.Напишите SQL запрос для получения списка клиентов, которые брали какие-либо DVD 
--диски в текущем году. В результатах запроса необходимо также отразить какие диски брали клиенты.
SELECT 
	customer.customer_id, 
	customer.first_name, 
	customer.last_name, 
	dvd.dvd_id, 
	dvd.title,
	dvd.production_year
FROM customer
LEFT JOIN offer ON customer.customer_id = offer.customer_id
LEFT JOIN dvd ON dvd.dvd_id = offer.dvd_id
WHERE 
	strftime('%Y', offer.offer_date) = '2020';