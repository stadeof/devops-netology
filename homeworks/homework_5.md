# Домашнее задание к занятию "5. Elasticsearch"
Лектор разрешил использовать OpenSearch вместо Elastcisearch.

1.

**Dockerfile:**

```docker
FROM centos:7

RUN yum update -y
RUN yum install java-11-openjdk-devel unzip wget -y

RUN groupadd opensearch
RUN useradd opensearch -g opensearch -M -s /bin/bash

RUN wget https://artifacts.opensearch.org/releases/bundle/opensearch/2.5.0/opensearch-2.5.0-linux-x64.tar.gz
RUN tar -xf opensearch-2.5.0-linux-x64.tar.gz

RUN mkdir /var/lib/opensearch
RUN mv ./opensearch-2.5.0/* /var/lib/opensearch && rm -fr ./opensearch-2.5.0

WORKDIR /var/lib/opensearch
RUN chown -R opensearch:opensearch /var/lib/opensearch

USER opensearch

CMD ["/var/lib/opensearch/bin/opensearch"]
```

**docker.io:** https://hub.docker.com/repository/docker/stadeoff/opensearch_netology/general

**curl:** 

```json
stade@stade-desktop:~/netology/work/elk/opensearch$ curl localhost:9200
{
  "name" : "netology_test",
  "cluster_name" : "opensearch",
  "cluster_uuid" : "NCMGLeV4TmGxDKDzpapXZg",
  "version" : {
    "distribution" : "opensearch",
    "number" : "2.5.0",
    "build_type" : "tar",
    "build_hash" : "b8a8b6c4d7fc7a7e32eb2cb68ecad8057a4636ad",
    "build_date" : "2023-01-18T23:48:48.981786100Z",
    "build_snapshot" : false,
    "lucene_version" : "9.4.2",
    "minimum_wire_compatibility_version" : "7.10.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "The OpenSearch Project: https://opensearch.org/"
}
```

2. 
**1 шард, 0 реплик**
```bash
curl -H 'Content-Type: application/json' -XPUT 'http://localhost:9200/ind-1?pretty' -d '{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  }
}'
```
**2 шарда, 1 реплика**
```bash
curl -H 'Content-Type: application/json' -XPUT 'http://localhost:9200/ind-2?pretty' -d '{
  "settings": {
    "number_of_shards": 2,
    "number_of_replicas": 1
  }
}'
```
**4 шарда, 2 реплики**
```bash
curl -H 'Content-Type: application/json' -XPUT 'http://localhost:9200/ind-3?pretty' -d '{
  "settings": {
    "number_of_shards": 4,
    "number_of_replicas": 2
  }
}'
```
**Список индексов и статусов:** 
```bash
stade@stade-desktop:~/netology/work/elk/opensearch$ curl http://localhost:9200/_cat/indices
green  open ind-1 x7VHgYv7SDuVu6h9ZyP0Hg 1 0 0 0 208b 208b
yellow open ind-3 HTv8ALVNSAGTrObQ0ov14w 4 2 0 0 832b 832b
yellow open ind-2 3IJLhMaZQ9-2bQutZwCZDA 2 1 0 0 416b 416b
```

**Состояние кластера:**

```bash
stade@stade-desktop:~/netology/work/elk/opensearch$ curl http://localhost:9200/_cluster/health?pretty=true
{
  "cluster_name" : "opensearch",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "discovered_master" : true,
  "discovered_cluster_manager" : true,
  "active_primary_shards" : 7,
  "active_shards" : 7,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 41.17647058823529
}
```

OpenSearch, как и ElasticSearch является отказоустойчивыми системами. Так как, в нашел случае, OpenSearch работает в режиме single-node, создавать реплики ему негде. Соответственно по умолчанию мы имеем желтый статус. 

```
stade@stade-desktop:~/netology/work/elk/opensearch$ curl -X DELETE "localhost:9200/ind-1,ind-2,ind-3"
{"acknowledged":true}
```
Пришлось дописать в opensearch.yml:  
```yml
path.repo: /var/lib/opensearch/snapshots
```

```bash
curl -H 'Content-Type: application/json' -XPUT "localhost:9200/_snapshot/netology_backup" -d'
{
  "type": "fs",
  "settings": {
    "location": "/var/lib/opensearch/snapshots"
  }
}'

{"acknowledged":true}
```
Создал индекс тест
```sh
stade@stade-desktop:~/netology/work/elk/opensearch$ curl http://localhost:9200/_cat/indices
green open test oeUkxuBGRHiGTVhzD0d4Mg 1 0 0 0 208b 208b
```

Создаю снэпшот

```sh
stade@stade-desktop:~/netology/work/elk/opensearch$ curl -X PUT "localhost:9200/_snapshot/netology_backup/netology_snap"
{"accepted":true}
```

```bash
bash-4.2$ cd snapshots/
bash-4.2$ ls
index-0  index.latest  indices  meta-nCSHAjnzQmelodFldfBqyA.dat  snap-nCSHAjnzQmelodFldfBqyA.dat
```

Удалил индекс test, создал test-2

```
stade@stade-desktop:~/netology/work/elk/opensearch$ curl http://localhost:9200/_cat/indices
green open test-2 54PD-5LMSS2KJkaLl1iLng 1 0 0 0 208b 208b
```
Смотрю доступные снапшоты
```json
stade@stade-desktop:~/netology/work/elk/opensearch$ curl -X GET "localhost:9200/_snapshot/netology_backup/*?verbose=false&pretty"
{
  "snapshots" : [
    {
      "snapshot" : "netology_snap",
      "uuid" : "nCSHAjnzQmelodFldfBqyA",
      "indices" : [
        "test"
      ],
      "data_streams" : [ ],
      "state" : "SUCCESS"
    }
  ]
}
```

```json
stade@stade-desktop:~/netology/work/elk/opensearch$ curl -X POST "localhost:9200/_snapshot/netology_backup/netology_snap/_restore?pretty" -H 'Content-Type: application/json' -d'
{
  "indices": "test",
  "rename_pattern": "(.+)",
  "rename_replacement": "restored-$1"
}
'
{
  "accepted" : true
}
```
Итоговый список индексов:

```
stade@stade-desktop:~/netology/work/elk/opensearch$ curl http://localhost:9200/_cat/indices
green open test-2        54PD-5LMSS2KJkaLl1iLng 1 0 0 0 208b 208b
green open restored-test hQwtVFt5RAezx4W25-fElA 1 0 0 0 208b 208b
```