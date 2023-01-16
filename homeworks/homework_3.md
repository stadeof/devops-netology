# Домашнее задание к занятию "3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера"

1. https://hub.docker.com/repository/docker/stadeoff/devops_homework

2. 1. Высоконагруженное монолитное java веб-приложение; - контейнеризация возможна, с учетом создания кластера и балансировщика нагрузки. В целом, возможен и запуск на физическом сервере, но думаю это будет не рациональное распределение ресурсов сервера. Паравиртуализация была бы оптимальным вариантам.
    2. Nodejs веб-приложение; - считаю контейниризацию оптимальной, на одной виртуалке можно развернуть несколько nodejs приложений, изолированных друг от друга, каждый со своими зависимостями, благодаря docker.
    3. Мобильное приложение c версиями для Android и iOS; - плохо представляю как это должно выглядеть на сервере, учитывая, что он хранится в магазинах playmarket/appstore. Предположу, что здесь будет уместна отдельная ВМ.
    4. Шина данных на базе Apache Kafka; - уместно применить контейнеризацию, с учетом возможного масштабирования.
    5. Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana; - предполагаю, что удобнее и логичнее всего развернуть ELK стек в контейнерах.
    6. Мониторинг-стек на базе Prometheus и Grafana; - возможно как развертывание на виртуальной машине, так и гетерогенно. Я бы отдал предпочтение ВМ, так как стек достаточно требовательный.
    7. MongoDB, как основное хранилище данных для java-приложения; - возможно использование в контейнере, но стоит быть внимательным с volumes, во избежания потери данных. Как правило, для баз данных используется кластер
    8. Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry. - возможна как отдельная виртуальная машина, так как системные требования гитлаб сервера подразумевает 4cpu, 4ram для +-2000 пользователей, так и докер. И для регистри, и для гитлаба есть официальные документации.

3. 
```
stade@stade-pc:~/web/test/centdeb$ docker run -dt -v data:/data --name centos centos
f757bb513956c9cbbb8585ccb357801c3f06d047154b0f60be352da6715c28b4
```
```
stade@stade-pc:~/web/test/centdeb$ docker run -dt -v data:/data --name debian debian
Unable to find image 'debian:latest' locally
latest: Pulling from library/debian
17c9e6141fdb: Pull complete 
Digest: sha256:bfe6615d017d1eebe19f349669de58cda36c668ef916e618be78071513c690e5
Status: Downloaded newer image for debian:latest
6425cff966f3e30ff043f3a23e0f78b58e83547f835bdcdf794c1de1475ba552
```

```
[root@f757bb513956 /]# cd data/
[root@f757bb513956 data]# echo test > test.txt
[root@f757bb513956 data]# ls
test.txt
[root@f757bb513956 data]# 
```

```
stade@stade-pc:~/web/test/centdeb$ docker exec -ti debian bash
root@6425cff966f3:/# cd data/
root@6425cff966f3:/data# ls
test.txt
root@6425cff966f3:/data# cat test.txt 
test
```