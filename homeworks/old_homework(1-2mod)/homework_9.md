# Домашнее задание к занятию "9. PostgreSQL"

1. 
    1. Вывод списка БД: \l
    2. Подключение к БД: \c <база данных>
    3. Вывод списка таблиц: \dt
    4. Вывод описания содержимого таблиц: \d <таблица>
    5. Выход из psql: \q

2. 

```
test_database=# SELECT attname, avg_width FROM pg_stats WHERE tablename = 'orders';
 attname | avg_width 
---------+-----------
 id      |         4
 title   |        16
 price   |         4
(3 rows)
```

3. 

CREATE создает таблицу orders_1 с полями (id - числовое, первичный ключ, title - текстовое, не пустое, prce - числовое, не пустое)
CREATE создает таблицу orders_2 с полями (id - числовое, первичный ключ, title - текстовое, не пустое, prce - числовое, не пустое)

Транзакция выбирает из таблицы orders с помощью SELECT по заданным параметрам (id, title, price) и с условием, заданными с помощью WHERE (цена больше 499 и соответсвенно меньше или равна этому числу) и вставляет в одну из созданных нами таблиц. Далее удаляет содержимое таблицы orders.
```
CREATE TABLE orders_1 (
    id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    price INT NOT NULL
);

CREATE TABLE orders_2 (
    id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    price INT NOT NULL
);

START TRANSACTION;

INSERT INTO orders_1 (id, title, price)
SELECT id, title, price
FROM orders
WHERE price > 499;

INSERT INTO orders_2 (id, title, price)
SELECT id, title, price
FROM orders
WHERE price <= 499;

DELETE FROM orders;

COMMIT;
```
Можно изначально было сделать автоматическое шардирование, если есть понимание того, как это сделать равномерно. (Например известны параметры шардирования)
PS. В данном случае можно было сразу создать 2 таблицы и делать в них запись исходя из условия (Цены)

4. 

```
root@b2f36a75ba73:/backups# pg_dump -U postgres test_database > /backups/dump.sql -W
Password: 
root@b2f36a75ba73:/backups# ls
dump.sql  test_dump.sql
```
Уникальность:
```
ALTER TABLE test_database
ADD UNIQUE (title);
```
