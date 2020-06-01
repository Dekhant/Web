--1 Напишите SQL запросы  для решения задач ниже
CREATE TABLE PC( 
      "id_PC" INTEGER PRIMARY KEY AUTOINCREMENT, 
      "cpu(MHz)" INTEGER NOT NULL, 
      "memory(Mb)" INTEGER NOT NULL, 
      "hdd(Gb)" INTEGER NOT NULL
); 

INSERT INTO PC ("cpu(MHz)", "memory(Mb)", "hdd(Gb)")
VALUES
	(1600, 2000, 500),
	(2400, 3000, 800),
	(3200, 3000, 1200),
	(2400, 2000, 500);
	
SELECT 
	"id_PC", 
	"cpu(MHz)", 
	"memory(Mb)"
FROM PC
WHERE
	PC."memory(Mb)" = 3000;
	
SELECT 
	MIN("hdd(Gb)")
FROM PC;

SELECT 
	COUNT("id_PC") AS quantity, 
	"hdd(Gb)"
FROM PC
WHERE
	"hdd(Gb)" = (SELECT MIN("hdd(Gb)") FROM PC)
	
--2 Есть таблица следующего вида:
CREATE TABLE track_downloads(
	"download_id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"track_id"	INTEGER NOT NULL,
	"user_id"	INTEGER NOT NULL,
	"download_time"	TEXT NOT NULL
);

INSERT INTO track_downloads ("track_id", "user_id", "download_time")
VALUES
	(1, 2, '2010-11-19'),
	(2, 3, '2010-12-19'),
	(3, 4, '2010-10-19'),
	(1, 3, '2010-11-19'),
	(2, 3, '2010-11-19'),
	(3, 1, '2010-11-19'),
	(4, 5, '2010-11-20');

-- Напишите SQL-запрос, возвращающий все пары (download_count, user_count), удовлетворяющие следующему условию: 
--  user_count — общее ненулевое число пользователей, сделавших ровно download_count скачиваний 19 ноября 2010 года

SELECT "download_count", COUNT(*) AS user_count 
FROM( 
    SELECT COUNT(*) AS download_count  
    FROM track_downloads 
	WHERE 
		"download_time" = '2010-11-19' 
    GROUP BY "user_id"
	)  
AS download_count 
GROUP BY "download_count";

--3 Опишите разницу типов данных DATETIME и TIMESTAMP

-- DATETIME 
--		Хранит время в виде целого числа вида YYYYMMDDHHMMSS, используя для этого 8 байтов
--		Поддерживаемый диапазон от 1000-01-01 00:00:00 до 9999-12-31 23:59:59
--		Не зависит от установленной временной зоны

-- TIMESTAMP 
--		Хранит число секунд от полуночи 1 января 1970 года по усреднённому времени Гринвича, используя 4 байта
--		Поддерживаемый диапазон от 1970-01-01 00:00:01UTC до 2038-01-19 03:14:07UTC (UTC - всемирное координированное время)
--		С учетом часового пояса
--		По умолчанию хранит значение NOW

--	В SQLite нет типа данных для хранения даты или времени. 
--	Предполагается хранить дату и время либо в строковом поле, либо в виде числа
--	TEXT - Для хранения даты/времени в формате "YYYY-MM-DD HH:MM:SS"
--	REAL - Для записи даты/времени в виде числа

--	В SQLite функция datetime() возвращает данные в формате "YYYY-MM-DD HH:MM:SS"

--4 Необходимо создать таблицу студентов (поля id, name) и таблицу курсов (поля id, name). 
--  Каждый студент может посещать несколько курсов. Названия курсов и имена студентов - произвольные

CREATE TABLE students(
	"id_students"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	TEXT NOT NULL
);

CREATE TABLE courses(
	"id_courses"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	TEXT NOT NULL
);

CREATE TABLE students_on_courses(
	"id_courses"	INTEGER NOT NULL,
	"id_students"	INTEGER NOT NULL,
	FOREIGN KEY("id_courses") REFERENCES "courses"("id_courses"),
	FOREIGN KEY("id_students") REFERENCES "students"("id_students")
);

INSERT INTO students(name)
VALUES
	('Дмитрий'),
	('Алексей'),
	('Мария'),
	('Татьяна'),
	('Сергей'),
	('Роман');
	
INSERT INTO courses(name)
VALUES
	('ПС'),
	('ВМ'),
	('БД'),
	('ИБ');
	
INSERT INTO students_on_courses(id_courses, id_students)
VALUES	
	(1, 1),
	(2, 1),
	(3, 2),
	(4, 2),
	(1, 3),
	(1, 4),
	(3, 4),
	(1, 5),
	(1, 6),
	(4, 6);
	
-- отобразить количество курсов, на которые ходит более 5 студентов

SELECT 
	courses.name,
	COUNT(students.id_students) as students
FROM students_on_courses
INNER JOIN students ON (students_on_courses.id_students = students.id_students)
INNER JOIN courses ON (students_on_courses.id_courses = courses.id_courses)
GROUP BY courses.id_courses
HAVING (COUNT(courses.id_courses) >= 5);

-- отобразить все курсы, на которые записан определенный студент

SELECT 
	courses.name, 
	students.name
FROM students_on_courses
INNER JOIN students ON (students_on_courses.id_students = students.id_students)
INNER JOIN courses ON (students_on_courses.id_courses = courses.id_courses)
WHERE
	students.id_students = 1;
	
--5 Может ли значение в столбце(ах), на который наложено ограничение foreign key, равняться null?

--  Может. Если на значение, на которое он ссылается не наложено ограничение NOT NULL
--  Допустим, мы вводим данные в таблицу и не знаем на что ссылается данный ключ. Но по другим значениям в таблице 
--  можно определить на что ссылается данный ключ. 
--  Например: в файловой системе для корневой директории будет родительская директория NULL

--6 Как удалить повторяющиеся строки с использованием ключевого слова Distinct?

CREATE TABLE members(
	"id_members"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"first_name" TEXT NOT NULL,
	"status" INTEGER NOT NULL
);

INSERT INTO members ("first_name", "status")
VALUES
	('Алекс', 3),
	('Мария', 10),
	('Дмитрий', 2),
	('Харитон', 2),
	('Евгений', 2),
	('Евгений', 2),
	('Алекс', 3);
	
SELECT 
	status,
	first_name
FROM members
ORDER BY status;

SELECT DISTINCT status, first_name
FROM members
ORDER BY status;

--7 Есть две таблицы:
--  users - таблица с пользователями (users_id, name)
--  orders - таблица с заказами (orders_id, users_id, status)

CREATE TABLE users(
	"users_id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	TEXT NOT NULL
);

CREATE TABLE orders(
	"orders_id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"users_id"	INTEGER NOT NULL,
	"status"	INTEGER NOT NULL,
	FOREIGN KEY("users_id") REFERENCES "users"("users_id")
);

INSERT INTO users(name)
VALUES
	('Дмитрий'),
	('Алексей'),
	('Мария'),
	('Татьяна'),
	('Сергей'),
	('Роман');
	
INSERT INTO orders(users_id, status)
VALUES
	(1, 1),
	(1, 1),
	(1, 1),
	(2, 1),
	(2, 1),
	(3, 1),
	(3, 0),
	(4, 0),
	(4, 0),
	(5, 1),
	(6, 1),
	(6, 1),
	(6, 1),
	(6, 1),
	(6, 1),
	(6, 1);
	
-- Выбрать всех пользователей из таблицы users, у которых ВСЕ записи в таблице orders имеют status = 0

SELECT * 
FROM users 
WHERE 
	users_id NOT IN ( 
	SELECT users_id 
	FROM orders 
	WHERE 
		status <> 0)
		
-- Выбрать всех пользователей из таблицы users, у которых больше 5 записей в таблице orders имеют status = 1

SELECT 
	orders.users_id, 
	users.name 
FROM orders 
INNER JOIN users ON users.users_id = orders.users_id 
WHERE orders.status = 1 
GROUP BY orders.users_id 
HAVING COUNT(orders.status) > 5;

--8 В чем различие между выражениями HAVING и WHERE?

--  В HAVING можно  писать условия по агрегатным функциям
--  На HAVING можно наложить условия на результаты группировки, потому что порядок исполнения запроса устроен таким образом, что на этапе, 
--  когда выполняется WHERE, ещё нет групп, а HAVING выполняется уже после формирования групп. 
