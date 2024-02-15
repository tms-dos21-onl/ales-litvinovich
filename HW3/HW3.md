## 1. Познакомиться с утилитой Midnight Commander, установить её на VM и узнать с помощью неё все папки верхнего уровня файловой системы.

   ![Корневой каталог](https://github.com/tms-dos21-onl/ales-litvinovich/assets/87812043/1e5caf34-f3b8-430f-a7c8-6cfc287d92c8)

## 2. Установить PowerShell на VM и проверить, что он работаёт путем выполнения каких-нибудь простейших команд.

```console
ales@ales-None:~$ sudo apt install powershell
Reading package lists... Done
..
Unpacking powershell (7.4.1-1.deb) ...
Setting up powershell (7.4.1-1.deb) ...

ales@ales-None:~$ powershell
PowerShell 7.4.1
PS /home/ales> dir

    Directory: /home/ales

UnixMode         User Group         LastWriteTime         Size Name
--------         ---- -----         -------------         ---- ----
drwxr-xr-x       ales ales        1/26/2024 12:21         4096 Desktop
drwxr-xr-x       ales ales        1/26/2024 12:21         4096 Documents
drwxr-xr-x       ales ales        1/26/2024 12:21         4096 Downloads
drwxr-xr-x       ales ales        1/26/2024 12:21         4096 Music
drwxr-xr-x       root root         2/9/2024 14:59         4096 nika
drwxr-xr-x       ales ales        1/26/2024 12:21         4096 Pictures
drwxr-xr-x       ales ales        1/26/2024 12:21         4096 Public
drwx------       ales ales         2/8/2024 12:26         4096 snap
drwxr-xr-x       ales ales        1/26/2024 12:21         4096 Templates
drwxrwxr-x       ales ales        1/31/2024 08:52         4096 test
drwxr-xr-x       ales ales        1/26/2024 12:21         4096 Videos
-rw-rw-r--       ales ales        1/31/2024 08:56            4 1
-rw-rw-r--       ales ales        2/14/2024 10:52            6 1.md
-rw-rw-r--       ales ales         2/1/2024 08:16         2630 123.txt
-rw-rw-r--       ales ales        1/31/2024 08:54            0 app.log
-rw-rw-r--       ales ales         2/7/2024 14:13            9 file
-rw-rw-r--       ales ales         2/7/2024 14:13            0 file1
-rw-rw-r--       ales ales        2/13/2024 08:50           11 r
-rw-rw-r--       ales ales        2/15/2024 09:46          547 sp1
-rw-rw-r--       ales ales        2/12/2024 11:24           21 sysunfo.sh
-rw-rw-r--       ales ales        2/14/2024 10:53           12 touch
```
   
## 3. Создать простейший bash-скрипт sysinfo.sh, который собирает данные о:
## - количестве свободной оперативной памяти
## - текущей загрузке процессора
## - текущем IP адресе(ах)

```bash
#Инициализация Bash
#!/bin/bash

#Сбор информации о памяти
mem_info=$(free -m | grep Mem)                         #Через команду free и grep получаем инфу о памяти
total_mem=$(echo "$mem_info" | awk '{print $2}')       #Из полученной выше строчки достаем 2 слово используя команду awk
free_mem=$(echo "$mem_info" | awk '{print $4}')        #Из полученной в начале строчки достаем 4 слово используя команду awk
echo "Память: $free_mem Мб свободно из $total_mem Мб"  #Выводим значения свободной памяти и общей

# Собираем данные о текущей загрузке процессора
cpu_load=$(top -n1 | grep "Cpu(s)"| awk '{print $2}' ) #Получаем статическое значение Cpu и достаем из вывода команды
echo "Процессор: $cpu_load% "                          #Вывод результата

# Собираем данные о текущем IP-адресе(ах)
ip_addresses=$(hostname -I)                            #Получаем чистое значение IP
echo "IP адрес: $ip_addresses"                         #Вывод
```
- Результат:
```console
ales@ales-None:~$ bash sp1
Память: 1510 Мб свободно из 3870 Мб
Процессор: 25.0% 
IP адрес: 192.168.217.141 
```

4. (**) Cоздать файл immortalfile, запретить его удаление даже пользователем root и попытаться его удалить из под root, результатом должно быть “Operation not permitted”. Подсказка: CHATTR(1).

   
5. (***) Выполнить команду и разобраться, что она делает и что сохраняется в file.log 
env -i bash -x -l -c 'echo hello_there!' > file.log 2>&1

