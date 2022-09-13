# ДЗ | 3.4. Операционные системы, лекция 2
1. Решил развернуть docker контейнер с node exporter, следующая конфигурация:
```
version: '3.5'
services:
  node-exporter:
    image: quay.io/prometheus/node-exporter
    container_name: node-exporter
    hostname: node-exporter
    restart: always
    ports:
      - 9100:9100
```
2. **Для процессора:** node_cpu_seconds_total;  
**для ram:** node_memory_MemTotal_bytes и node_memory_MemFree_bytes;  
**для диска:** node_filesystem_avail_bytes и node_filesystem_size_bytes; 
**для сети:** node_network_receive_bytes_total и node_network_transmit_bytes_total.
3. cpu, load, disk, ram, swap, network, processes и т.д. Ознакомился.
4. "BOOT_IMAGE=/vmlinuz-5.4.0-110-generic" - указывает, что это виртуальная машина
5.  fs.nr_open = 1048576. Это максимальное количество открытых файлов. hard limit не позволит достичь такого числа.
6. PID | TTY | TIME | CMD |
     --- | --- | --- |
      2 | pts/0 | 00:00:00 | bash |
     11| pts/0 | 00:00:00 | ps |

7. Команды запускает 2 процесса, параллельно запускающий еще 2 процесса и тд.  Спасли лимиты, предусмотренные ОС. cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-3.scope. 
Можно убрать лимиты изменив  "TasksMax=infinity"
