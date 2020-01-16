-- 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
-- Заполните их текущими датой и временем.

UPDATE users SET created_at = NOW()
UPDATE users SET updated_at = NOW()

-- 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были 
-- заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". 
-- Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

ALTER TABLE users CHANGE created_at created_at DATETIME;
ALTER TABLE users CHANGE updated_at updated_at DATETIME;

-- 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные 
-- цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать 
-- записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые 
-- запасы должны выводиться в конце, после всех записей.

SELECT value FROM storehouses_products ORDER BY value;
