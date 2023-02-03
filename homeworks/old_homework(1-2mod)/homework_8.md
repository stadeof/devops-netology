# Домашнее задание к занятию "8. MySQL"

1. docker-compose.yml: 

```
version: '3.8'

services:
  db:
    image: mysql:8.0
    restart: always
    environment:
      - MYSQL_DATABASE=test_db
      - MYSQL_ROOT_PASSWORD=1234
    ports:
      - '3306:3306'
    volumes:
      - db:/var/lib/mysql
      - ./db/init.sql:/docker-entrypoint-initdb.d/init.sql
      - ./test_db.sql:/backups/test_db.sql
volumes:
  db:
    driver: local
```

\h:

```
mysql> \s
--------------
mysql  Ver 8.0.31 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:          9
Current database:
Current user:           root@localhost
SSL:                    Not in use
Current pager:          stdout
Using outfile:          ''
Using delimiter:        ;
Server version:         8.0.31 MySQL Community Server - GPL
Protocol version:       10
Connection:             Localhost via UNIX socket
Server characterset:    utf8mb4
Db     characterset:    utf8mb4
Client characterset:    latin1
Conn.  characterset:    latin1
UNIX socket:            /var/run/mysqld/mysqld.sock
Binary data as:         Hexadecimal
Uptime:                 1 min 24 sec

Threads: 2  Questions: 5  Slow queries: 0  Opens: 119  Flush tables: 3  Open tables: 38  Queries per second avg: 0.059
```

```
mysql> SHOW TABLES FROM test_db;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.01 sec)
```

```
SELECT *
	   FROM orders
	       WHERE price>300
```

**id** 2 **title** My little pony **price** 500

```
mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES;
+------------------+-----------+---------------------------------------+
| USER             | HOST      | ATTRIBUTE                             |
+------------------+-----------+---------------------------------------+
| root             | %         | NULL                                  |
| mysql.infoschema | localhost | NULL                                  |
| mysql.session    | localhost | NULL                                  |
| mysql.sys        | localhost | NULL                                  |
| root             | localhost | NULL                                  |
| test             | localhost | {"fname": "James", "lname": "Pretty"} |
+------------------+-----------+---------------------------------------+
6 rows in set (0.00 sec)
```

Права

```
GRANT SELECT on test_db.* to test@'localhost';
```

SHOW TABLE

```
mysql> SHOW TABLE STATUS where name = 'orders';
+--------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+--------------------+----------+----------------+---------+
| Name   | Engine | Version | Row_format | Rows | Avg_row_length | Data_length | Max_data_length | Index_length | Data_free | Auto_increment | Create_time         | Update_time         | Check_time | Collation          | Checksum | Create_options | Comment |
+--------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+--------------------+----------+----------------+---------+
| orders | InnoDB |      10 | Dynamic    |    5 |           3276 |       16384 |               0 |            0 |         0 |              6 | 2023-01-16 12:35:10 | 2023-01-16 12:35:10 | NULL       | utf8mb4_0900_ai_ci |     NULL |                |         |
+--------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+--------------------+----------+----------------+---------+
1 row in set (0.00 sec)
```

```
mysql> SHOW PROFILES;
+----------+------------+----------------------------------+
| Query_ID | Duration   | Query                            |
+----------+------------+----------------------------------+
|       11 | 0.09871325 | ALTER TABLE orders ENGINE=MyISAM |
|       12 | 0.11373900 | ALTER TABLE orders ENGINE=InnoDB |
+----------+------------+----------------------------------+
2 rows in set, 1 warning (0.00 sec)
```

Настройки my.cnf

```
innodb_flush_log_at_trx_commit = 0 - буфер будет сбрасываться в лог файл независимо от транзакций, риск потери данных возрастает

innodb_file_per_table = 1 - данные таблиц будут храниться в отдельных файлах idb

autocommit = 0 - отключение режима автоматического завершения транзакций

innodb_log_buffer_size = 1M - размер буффера незакомиченных транзакций

key_buffer_size = 4915М - 30% от памяти

max_binlog_size	= 100M - размер логов операций
```