# Домашнее задание к занятию "2. Применение принципов IaaC в работе с виртуальными машинами"

1. Основные преимущества: масштабируемость, скорость выполнения задачи, уменьшение затрат, быстрое восстановление при проблемах/ошибках.
    Думаю, основополагающим принципом является то, что сделав один раз инфраструктуру, ее можно использовать как готовый паттерн, лишь немного изменяя по необходимости. При этом, результат всегда будет идентичен.
2. Ансибл выгодно отличается от других систем управления конфигурациями низким порогом входа, отсутствием необходимости устанавливать агент к подключаемым серверам, также он написан на языке Python, предустановленном в Unix системах. 
Предполгаю более безопасным метод pull, так как ни один внешний клиент не имеет прав на внесение изменений в кластер, все обновления накатываются изнутри. 
3. 
```
stade@stade-pc:~$ virtualbox --help
Oracle VM VirtualBox VM Selector v6.1.36
(C) 2005-2022 Oracle Corporation
All rights reserved.

No special options.

If you are looking for --startvm and related options, you need to use VirtualBoxVM.

```

```
stade@stade-pc:~$ vagrant -v
Vagrant 2.2.19

```

```
 stade@stade-pc:~$ ansible --version
ansible 2.10.8
  config file = None
  configured module search path = ['/home/stade/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.10.6 (main, Aug 10 2022, 11:40:04) [GCC 11.3.0]

```