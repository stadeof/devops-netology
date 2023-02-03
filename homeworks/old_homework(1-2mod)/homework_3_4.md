# ДЗ | 3.4. Операционные системы, лекция 2
1. Cкачал .tar архив, разархивировал, перенес исполняемый файл в /usr/bin/node_exporter командой mv. Задал права на исполняемый файл node_exporter:node_exporter

sudo nano /etc/systemd/system/node_exporter.service
```
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
EnvironmentFile=/opt/node_exporter
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/bin/node_exporter $METRICS
Restart=on-failure

[Install]
WantedBy=multi-user.target
```
Передаваемые параметры находятся в файле /opt/node_exporter. Я передаю только 1 флаг.
Содержимое файла:
```
METRICS="--collector.cpu.info"
```
sudo systemctl status node_exporter
```
● node_exporter.service - Node Exporter
     Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
     Active: active (running) since Fri 2022-09-23 11:34:55 UTC; 3s ago
   Main PID: 3738 (node_exporter)
      Tasks: 3 (limit: 1030)
     Memory: 2.5M
        CPU: 11ms
     CGroup: /system.slice/node_exporter.service
             └─3738 /usr/bin/node_exporter --collector.cpu.info

сен 23 11:34:55 testvm node_exporter[3738]: ts=2022-09-23T11:34:55.637Z caller=node_exporter.go:115 level=info collector=thermal_zone
сен 23 11:34:55 testvm node_exporter[3738]: ts=2022-09-23T11:34:55.637Z caller=node_exporter.go:115 level=info collector=time
сен 23 11:34:55 testvm node_exporter[3738]: ts=2022-09-23T11:34:55.637Z caller=node_exporter.go:115 level=info collector=timex
сен 23 11:34:55 testvm node_exporter[3738]: ts=2022-09-23T11:34:55.637Z caller=node_exporter.go:115 level=info collector=udp_queues
сен 23 11:34:55 testvm node_exporter[3738]: ts=2022-09-23T11:34:55.637Z caller=node_exporter.go:115 level=info collector=uname
сен 23 11:34:55 testvm node_exporter[3738]: ts=2022-09-23T11:34:55.637Z caller=node_exporter.go:115 level=info collector=vmstat
сен 23 11:34:55 testvm node_exporter[3738]: ts=2022-09-23T11:34:55.637Z caller=node_exporter.go:115 level=info collector=xfs
сен 23 11:34:55 testvm node_exporter[3738]: ts=2022-09-23T11:34:55.637Z caller=node_exporter.go:115 level=info collector=zfs
сен 23 11:34:55 testvm node_exporter[3738]: ts=2022-09-23T11:34:55.637Z caller=node_exporter.go:199 level=info msg="Listening on" address=:9100
сен 23 11:34:55 testvm node_exporter[3738]: ts=2022-09-23T11:34:55.644Z caller=tls_config.go:195 level=info msg="TLS is disabled." http2=false
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
