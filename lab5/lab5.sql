CREATE TABLE dvd(
	dvd_id	INTEGER PRIMARY KEY AUTOINCREMENT,
	title	TEXT NOT NULL,
	production_year	TEXT NOT NULL
);

CREATE TABLE customer(
	customer_id	INTEGER PRIMARY KEY AUTOINCREMENT,
	first_name	TEXT NOT NULL,
	last_name	TEXT NOT NULL,
	passport_code	TEXT NOT NULL,
	registration_date	TEXT NOT NULL
);

CREATE TABLE offer(
	offer_id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	dvd_id	INTEGER NOT NULL,
	customer_id	INTEGER NOT NULL,
	offer_date	TEXT NOT NULL,
	return_date	TEXT NOT NULL,
	FOREIGN KEY(dvd_id) REFERENCES dvd(dvd_id),
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);
--3 Подготовьте SQL запросы для заполнения таблиц данными

INSERT INTO dvd (title, production_year)
VALUES
	('Начало', '2010'),
	('Алиса в стране чудес', '2010'),
	('Остров проклятых', '2010'),
	('Ральф', '2012'),
	('Твоё имя', '2016'),
	('1917', '2020'),
	('Соник в кино', '2020');
	
INSERT INTO customer (first_name, last_name, passport_code, registration_date)
VALUES
	('Иван', 'Сидоров', '88902134', '2018-02-02'),
	('Александр', 'Смирнов', '88071234', '2019-12-11'),
	('Дмитрий', 'Медведев', '00006565', '2008-04-05'),
	('Руслан', 'Нигматулин', '98535354', '2012-05-30');
	
INSERT INTO offer (dvd_id, customer_id, offer_date, return_date)
VALUES
	(1, 2, '2018-06-30', '2018-07-02'),
	(2, 1, '2019-12-11', '2020-01-28'),
	(4, 3, '2018-04-03', '2018-05-02'),
	(7, 4, '2020-03-03', '2020-06-01'),
	(6, 3, '2020-04-30', '2020-07-01');
	
--4 Подготовьте SQL запрос получения списка всех DVD, год выпуска которых 2010, 
--  отсортированных в алфавитном порядке по названию DVD.

SELECT * 
FROM dvd
WHERE 
	production_year = '2010'
ORDER BY title ASC;

--5 Подготовьте SQL запрос для получения списка DVD дисков, которые в настоящее время находятся у клиентов

SELECT
	dvd.dvd_id,
	dvd.title, 
	dvd.production_year 
FROM dvd
INNER JOIN offer ON dvd.dvd_id = offer.dvd_id
WHERE
	offer.offer_date <= date('now') AND 
	offer.return_date >= date('now');
	
--6 Напишите SQL запрос для получения списка клиентов, которые брали какие-либо DVD диски в текущем году. 
--  В результатах запроса необходимо также отразить какие диски брали клиенты.

SELECT 
	customer.customer_id, 
	customer.first_name, 
	customer.last_name, 
	customer.passport_code, 
	customer.registration_date, 
	dvd.dvd_id, 
	dvd.title
FROM customer
INNER JOIN offer ON customer.customer_id = offer.customer_id
INNER JOIN dvd ON offer.dvd_id = dvd.dvd_id
WHERE
	strftime('%Y', offer.offer_date) = '2020';