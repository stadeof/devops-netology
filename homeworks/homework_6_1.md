# Домашнее задание к занятию "6.1. Типы и структура СУБД"

1. 
    1. **Электронные чеки в json виде** - так как чеки в json имеют вид ключ-значение, я бы мог порекомендовать гибкую NoSQL БД. Альтернативой могу предложить документо-ориентированную БД, так как, возможно чеки требуется хранить в строгом виде в связи с законодательством.

    2. **Склады и автомобильные дороги для логистической компании** - графовые. Так как основными элементами модели являются узлы и связи, выбор выглядит, с моей точки зрения, правильным для логистической компании.

    3. **Генеалогические деревья** - древовидные (иерархические) структуры данных (реляционные базах данных). Фактически Oracle и MSSQL хранят данные в Б-деревьях. Это было бы хорошим выбором, в связи с тем, что у нас будут виды, подвиды (родители)

    4. **Кэш идентификаторов клиентов с ограниченным временем жизни для движка аутенфикации** - так как это кэш с ограниченным временем жизни, оптимальным вариантов являются CУБД вида ключ-значение, такие как Redis / Memcached.

    5. **Отношения клиент-покупка для интернет-магазина** - так как это является интернет-магазином, я бы предложил реляционную БД, была бы возможность сделать таргетные рекомендации на основании его покупок и упорядоченное хранение.

2. 

```
PA (жертвуем согласованностью данных) согласно CAP и PA/EL согласно PACELC
CA (жертвуем устойчивостью к расщеплению) согласно CAP и PA/EC согласно PACELC
CP (жертвуем доступностью) согласно CAP и EL/PC согласно PACELC
```

3. Предполагаю, что нет, как минимум из-за того, что в терминах BASE и ACID согласованность является несколько разными вещами. В зависимости от требований, инженер должен опираться на один из принципов.

4. key-value хранилище с механизмом Pub/Sub это брокер сообщений. Таковыми могут выступать Redis, kafka, rabbitmq. Это система, в которой участвуют  подписчики и издатель (один или несколько). Соответсвенно, из минусов, на который стоит акцентировать внимание является постоянство данных. Redis рассылает сообщения, но не хранит, а например в таких брокерах как RabbitMQ или Kafka поддерживается хранение сообщений. Также, стоит обращать внимание на кол-во отправляемых сообщений в секунду и подбирать в соответствии с вашими задачами. 