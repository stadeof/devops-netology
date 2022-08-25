# ДЗ Красичков  
## "3.1. Работа в терминале, лекция 1"
___

1. +
2. +
3. +
4. + 
5. ОЗУ 1024МБ, 2 ядра, 4мб видеопамять
6. v.memory = (кол-во в мб)  |  v.cpus = (кол-во ядер)  
7. +
8.  HISTFILESIZE (1160) |  ignoreboth это тоже самое, что и  ignorespace, ignoredups
9. {} - зарезервированные слова / переменные, 199 строка
10. 100к файлов создать можно командой:
```
touch a{1..100000}
```
  300к нельзя (Argument list too long)
11. Проверка наличия каталога /tmp
12. Список команд ниже:
```
   11  mkdir new_path_directory
   12  sudo rsync -r /bin/bash /tmp/new_path_directory/bash 
   13  ls
   14  cd new_path_directory/bash 
   15  PATH=/tmp/new_path_directory/bash:$PATH
   16  type -a bash
   17  export PATH=/tmp/new_path_directory/bash:$PATH
   18  type -a bash
   19  ${PATH}
   20  PATH=/tmp/new_path_directory/:$PATH
   21  type -a bash
```
13. at выполняет команды в указанное время, batch выполняет команды, когда позволяют уровни загрузки системы; другими словами, когда среднее значение нагрузки падает ниже 1,5 или ified при вызове atd.
14. + (vagrant suspend)
