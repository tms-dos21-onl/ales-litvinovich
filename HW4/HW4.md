## 1. Отобразить все процессы в системе.

```console
ales@ales-None:~$ ps -a -e
    PID TTY          TIME CMD
      1 ?        00:00:03 systemd
      2 ?        00:00:00 kthreadd
      3 ?        00:00:00 rcu_gp
      4 ?        00:00:00 rcu_par_gp
      5 ?        00:00:00 slub_flushwq
      6 ?        00:00:00 netns
      9 ?        00:00:00 kworker/0:1-events
  .................
   3475 ?        00:00:00 kworker/0:4H-ttm
   3478 ?        00:00:00 kworker/1:1H-ttm
   3501 pts/0    00:00:00 ps
```

## 2. Запустить бесконечный процесс в фоновом режиме используя nohup.

- Запускаем специально написанный скрипт в фон
```console
ales@ales-None:~$ nohup bash proc1.sh &
[1] 3931
```

## 3. Убедиться, что процесс продолжил работу после завершения сессии.

- Поиск процесса после разрыва сесиии
```console
ales@ales-None:~$ ps -aux | grep proc1.sh
ales        3931  0.1  0.0   9904  3712 ?        S    09:46   0:00 bash proc1.sh
ales        4011  0.0  0.0   9252  2304 pts/0    S+   09:47   0:00 grep --color=auto proc1.sh
```

## 4. Убить процесс, запущенный в фоновом режиме.

- Убиваем процесс принудительно сигналом 9
```console
ales@ales-None:~$ kill -9 3931
ales@ales-None:~$ ps -aux | grep proc1.sh
ales        4073  0.0  0.0   9252  2304 pts/0    S+   09:48   0:00 grep --color=auto proc1.sh
```

## 5. Написать свой сервис под управлением systemd, добавить его в автозагрузку (можно использовать процесс из п.2).

- Использую для сервиса скрипт из предыдушего задания. Даю ему права на выполнение
```console
chmod +x proc1.sh
```
- Создаю файл службы systemd
```console
[Unit]
Description=Мой сервис

[Service]
ExecStart=/home/ales/proc1.sh
Restart=always
User=ales
Group=nogroup
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=proc1

[Install]
WantedBy=multi-user.target
```
- Копирую в каталог systemd
```console
sudo cp proc1.service /etc/systemd/system/
```
- Перезапускаю службу systemd
```console
sudo systemctl daemon-reload
```
- Добавляю в автозагрузку 
```console
sudo systemctl proc1
```
- Результат после перезагрузки системы
```console
ales@ales-None:~$ systemctl status proc1
● proc1.service - Мой сервис
     Loaded: loaded (/etc/systemd/system/proc1.service; enabled; preset: enable>
     Active: active (running) since Tue 2024-02-20 11:06:02 +03; 50s ago
   Main PID: 871 (proc1.sh)
      Tasks: 2 (limit: 4570)
     Memory: 600.0K
        CPU: 156ms
     CGroup: /system.slice/proc1.service
             ├─ 871 /bin/bash /home/ales/proc1.sh
             └─3041 sleep 1
```

## 6. Посмотреть логи своего сервиса.

- Выбрал 150 последних записей для своего сервиса
```console
les@ales-None:~$ journalctl -u proc1 -n 150
Feb 26 08:45:39 ales-None proc1[1012]: Бесконечный процесс выполняется...
Feb 26 08:45:40 ales-None proc1[1012]: Бесконечный процесс выполняется...
Feb 26 08:45:41 ales-None proc1[1012]: Бесконечный процесс выполняется...
Feb 26 08:45:42 ales-None proc1[1012]: Бесконечный процесс выполняется...
Feb 26 08:45:43 ales-None proc1[1012]: Бесконечный процесс выполняется...
Feb 26 08:45:44 ales-None proc1[1012]: Бесконечный процесс выполняется...
Feb 26 08:45:45 ales-None proc1[1012]: Бесконечный процесс выполняется...
Feb 26 08:45:46 ales-None proc1[1012]: Бесконечный процесс выполняется...
Feb 26 08:45:47 ales-None proc1[1012]: Бесконечный процесс выполняется...
```

## 7. (**) Написать скрипт, который выводит следующую информацию (можно переиспользовать предыдущее дз):
- кол-во процессов запущенных из под текущего пользователя
- load average за 15 минут
- кол-во свободной памяти
- свободное место в рутовом разделе /

```bash
#!/bin/bash
# Количество процессов текущего пользователя
process_count=$(ps -u $ales | wc -l)                                
echo "Количество процессов текущего пользователя: $process_count"
# Load average за 15 минут
load_average=$(uptime | awk -F'e:' '{ print $2 }')
echo "Средняя загрузка: $load_average"
# Свободная память
free_memory=$(free -h | awk '/Mem:/ { print $4 }')
echo "Свободная память: $free_memory"
# Свободное место в рутовом разделе
free_space=$(df -h / | awk 'NR==2 { print $4 }')
echo "Свободное место в рутовом разделе: $free_space"
```

## 8. (**) Добавить в cron задачу, которая будет каждые 10 минут писать в файл результаты выполнения скрипта из п.7

- Выдаю права на исполнение скрипту sh2.sh
```console
ales@ales-None:~$ chmod +x sh2.sh
```
- Добавляем задачу в планировщик
```console
ales@ales-None:~$ crontab -e
no crontab for ales - using an empty one
crontab: installing new crontab
```
```console
*/10 * * * * /home/ales/sh2.sh >> /home/ales/sh2.log 2>&1
```
- Логи из файла:
```console
ales@ales-None:~$ cat sh2.log
Количество процессов текущего пользователя: 13
Средняя загрузка:  0.02, 0.02, 0.00
Свободная память: 1.7Gi
Свободное место в рутовом разделе: 7.9G
Количество процессов текущего пользователя: 13
Средняя загрузка:  0.05, 0.03, 0.00
Свободная память: 1.7Gi
Свободное место в рутовом разделе: 7.9G
...
```

## 9. (***) Сделать п. 5 для Prometheus Node Exporter

- Установка
```console
ales@ales-None:~$ wget https://github.com/prometheus/node_exporter/releases/tag/v1.7.0/node_exporter-1.7.0.darwin-amd64.tar.gz       # Скачивание архива    
ales@ales-None:~$ tar -xvf node_exporter-1.7.0.linux-amd64.tar.gz                                                                    # Распаковка
ales@ales-None:~$ sudo cp node_exporter /usr/local/bin/                                                                              # Копирую сервис в bin
```
- Добавляю сервис в атозагрузки
```console
[Unit]
Description=Prometheus Node Exporter
After=network.target

[Service]
User=ales
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=default.target
```
- Проверяю статус после перезагрузки и вебдоступ
```console
ales@ales-None:~$ sudo systemctl status node_exporter
[sudo] password for ales: 
● node_exporter.service - Prometheus Node Exporter
     Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; preset: enabled)
     Active: active (running) since Tue 2024-02-27 08:51:01 +03; 2min 18s ago
   Main PID: 1390 (node_exporter)
      Tasks: 5 (limit: 4570)
     Memory: 14.5M
        CPU: 48ms
     CGroup: /system.slice/node_exporter.service
             └─1390 /usr/local/bin/node_exporter
  ```
   ![Вебдоступ](https://github.com/tms-dos21-onl/ales-litvinovich/assets/87812043/db769a93-10bc-43f5-a21c-08e1e053aff5)
