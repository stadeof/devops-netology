# ДЗ | 3.3.  Операционные системы, лекция 1
1. chdir("/tmp")  
2. В /usr/share/misc/magic.mgc, "/etc/magic", также пытается найти в каталоге пользователя "/home/stade/.magic", "/home/stade/.magic.mgc"
3. Например, мы можем перенаправлять поток в /dev/null "echo somelog > file.log > /dev/null".  
Если файл удален, то перенаправить по PID процесса /proc/1237/fd/4 > /dev/null.
4. Зомби не занимают памяти (как процессы-сироты), но блокируют записи в таблице процессов.
5.  Таблица ниже

PID  | COMM | FD | ERR | PATH | 
--- | --- | --- | --- | --- |
2512 |  redis-server | 8 | 0 | /proc/1/stat |
1998 | teamviewerd | 4 | 0 | /dev/fb0 |
1998 | teamviewerd | 14 | 0 | /sys/devices/virtual/tty/tty0/active |
1998 | teamviewerd | 14 | 0 | /sys/devices/virtual/tty/tty0/active |
1998 | teamviewerd  | 14 | 0 | /dev/tty2 |
2512 | redis-server | 8 | 0 | /proc/1/stat |
965 | systemd-oomd | 7 | 0 | /proc/meminfo |
2512 | redis-server | 8 | 0 | /proc/1/stat |
4809 | ThreadPoolForeg | 281 | 0 | /home/stade/.config/google-chrome/Default/IndexedDB/chrome-extension_bihmplhobchoageeokmgbdihknkjbknd_0.indexeddb.leveld |

6. Системный вызов uname() "uname({sysname="Linux", nodename="stade-pc", ...}) = 0".
Не смог найти в man, нашел в интернете: 
"Part of the utsname information is also accessible via /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}."
7. ; - последовательное выполнение команд в bash. && - выполнить команду в том случае, если предыдущий код выхода равен 0 (т.е. завершилось успешно).
Смысл есть, если код выхода будет 0,  так как сессия будет завершена при не нулевом коде выхода.
8. -e - немедленный выход, если выходное состояние команды ненулевое. -u - во время замещения рассматривает незаданную переменную как ошибку. -x - выводит команды и их аргументы по мере выполнения команд. -o - устанавливает флаг, соответствующий имени_опции. 
В сценарии был бы удобен тем, что сразу задается необходимое поведение при ошибке сценария. Если я правильно понял, вызов pipefail делается условием.
9. (S,S+,Ss,Ssl,Ss+) -  спящие процессы
(I,I<) - фоновые процессы ядра
