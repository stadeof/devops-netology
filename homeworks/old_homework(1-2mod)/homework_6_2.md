# Домашнее задание к занятию "6.2. SQL"

docker-compose.yml

version: '3.5'
```
services:
  postgres-netology:
    container_name: postgres_cnetology
    image: postgres
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: user1234
      PGDATA: /data/postgres
    volumes:
       - ./data:/data/postgres
       - ./backups:/backups
    ports:
      - "5433:5432"
    restart: unless-stopped
```
1.  Список БД

```
test_db=# \l
                                  List of databases
   Name    |      Owner      | Encoding |  Collate   |   Ctype    | Access privileges 
-----------+-----------------+----------+------------+------------+-------------------
 postgres  | user            | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | user            | UTF8     | en_US.utf8 | en_US.utf8 | =c/user          +
           |                 |          |            |            | user=CTc/user
 template1 | user            | UTF8     | en_US.utf8 | en_US.utf8 | =c/user          +
           |                 |          |            |            | user=CTc/user
 test_db   | test-admin-user | UTF8     | en_US.utf8 | en_US.utf8 | 
 user      | user            | UTF8     | en_US.utf8 | en_US.utf8 | 
(5 rows)

```

Описание таблиц

```
test_db-# \d
               List of relations
 Schema |       Name        |   Type   | Owner 
--------+-------------------+----------+-------
 public | clients           | table    | user
 public | clients_id_seq    | sequence | user
 public | clients_заказ_seq | sequence | user
 public | orders            | table    | user
 public | orders_id_seq     | sequence | user
(5 rows)

```

Права

```
test_db=# SELECT table_name, grantee, privilege_type FROM information_schema.role_table_grants WHERE table_name='orders';
 table_name |     grantee      | privilege_type 
------------+------------------+----------------
 orders     | user             | INSERT
 orders     | user             | SELECT
 orders     | user             | UPDATE
 orders     | user             | DELETE
 orders     | user             | TRUNCATE
 orders     | user             | REFERENCES
 orders     | user             | TRIGGER
 orders     | test-admin-user  | INSERT
 orders     | test-admin-user  | SELECT
 orders     | test-admin-user  | UPDATE
 orders     | test-admin-user  | DELETE
 orders     | test-admin-user  | TRUNCATE
 orders     | test-admin-user  | REFERENCES
 orders     | test-admin-user  | TRIGGER
 orders     | test-simple-user | INSERT
 orders     | test-simple-user | SELECT
 orders     | test-simple-user | UPDATE
 orders     | test-simple-user | DELETE
(18 rows)

```

```
test_db=# SELECT table_name, grantee, privilege_type FROM information_schema.role_table_grants WHERE table_name='clients';
 table_name |     grantee      | privilege_type 
------------+------------------+----------------
 clients    | user             | INSERT
 clients    | user             | SELECT
 clients    | user             | UPDATE
 clients    | user             | DELETE
 clients    | user             | TRUNCATE
 clients    | user             | REFERENCES
 clients    | user             | TRIGGER
 clients    | test-admin-user  | INSERT
 clients    | test-admin-user  | SELECT
 clients    | test-admin-user  | UPDATE
 clients    | test-admin-user  | DELETE
 clients    | test-admin-user  | TRUNCATE
 clients    | test-admin-user  | REFERENCES
 clients    | test-admin-user  | TRIGGER
 clients    | test-simple-user | INSERT
 clients    | test-simple-user | SELECT
 clients    | test-simple-user | UPDATE
 clients    | test-simple-user | DELETE
(18 rows)

```
2. 

```
INSERT INTO orders 
	VALUES (1, 'Шоколад', 10), 
		(2, 'Принтер', 3000), 
		(3, 'Книга', 500), 
		(4, 'Монитор', 7000), 
		(5, 'Гитара', 4000);
```

```
INSERT INTO clients
	VALUES (1, 'Иванов Иван Иванович', 'USA'),
		(2, 'Петров Петр Петрович', 'Canada'),
		(3, 'Иоганн Себастьян Бах', 'Japan'),
		(4, 'Ронни Джеймс Дио', 'Russia'),
		(5, 'Ritchie Blackmore', 'Russia');
```

Подсчет

```
test_db=# select count(*) from clients;
test_db=# select count(*) from orders;
 count 
-------
     5
(1 row)
```

4. 
```
test_db=# UPDATE clients SET заказ=3 WHERE id=1;
UPDATE 1

test_db=# UPDATE clients SET заказ=4 WHERE id=2;
UPDATE 1

test_db=# UPDATE clients SET заказ=5 WHERE id=3;
UPDATE 1

```

```
test_db=# SELECT * FROM clients;
 id |       фамилия        | страна | заказ 
----+----------------------+--------+-------
  4 | Ронни Джеймс Дио     | Russia |     4
  5 | Ritchie Blackmore    | Russia |     5
  1 | Иванов Иван Иванович | USA    |     3
  2 | Петров Петр Петрович | Canada |     4
  3 | Иоганн Себастьян Бах | Japan  |     5
(5 rows)


```
```
test_db=# SELECT * FROM clients WHERE заказ IS NOT NULL;
 id |       фамилия        | страна | заказ 
----+----------------------+--------+-------
  4 | Ронни Джеймс Дио     | Russia |     4
  5 | Ritchie Blackmore    | Russia |     5
  1 | Иванов Иван Иванович | USA    |     3
  2 | Петров Петр Петрович | Canada |     4
  3 | Иоганн Себастьян Бах | Japan  |     5
(5 rows)
```

Произвел EXPLAIN таблицы clients, отсеев клиентов не сделавших заказ. Подробный вывод снизу (Таблица, время выполнения запроса, фильтер запроса и тд). 
```
              QUERY PLAN               
---------------------------------------
 - Plan:                              +
     Node Type: "Seq Scan"            +
     Parallel Aware: false            +
     Async Capable: false             +
     Relation Name: "clients"         +
     Alias: "clients"                 +
     Startup Cost: 0.00               +
     Total Cost: 14.20                +
     Plan Rows: 418                   +
     Plan Width: 164                  +
     Filter: "(\"заказ\" IS NOT NULL)"
(1 row)

```

Создание backup

```
user=# pg_dumpall > /backups/test_backup
user-# 
\q
root@e0a2f73186c8:/# ls /backups/
test_backup
root@e0a2f73186c8:/# 

stade@stade-pc:~/web$ docker rm -f postgres_netology 
postgres_netology

stade@stade-pc:~/web$ sudo rm -rf ~/web/homeworks/docker/data

stade@stade-pc:~/web$ docker-compose -f ./docker/docker-compose.yml up -d

user=# psql -f /backups/test_backup
```

```
user=# \l
                                  List of databases
   Name    |      Owner      | Encoding |  Collate   |   Ctype    | Access privileges 
-----------+-----------------+----------+------------+------------+-------------------
 postgres  | user            | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | user            | UTF8     | en_US.utf8 | en_US.utf8 | =c/user          +
           |                 |          |            |            | user=CTc/user
 template1 | user            | UTF8     | en_US.utf8 | en_US.utf8 | =c/user          +

...skipping 1 line
 test_db   | test-admin-user | UTF8     | en_US.utf8 | en_US.utf8 | 
 user      | user            | UTF8     | en_US.utf8 | en_US.utf8 | 
(5 rows)
```


