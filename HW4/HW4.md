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


## 7. (**) Написать скрипт, который выводит следующую информацию (можно переиспользовать предыдущее дз):
- кол-во процессов запущенных из под текущего пользователя
- load average за 15 минут
- кол-во свободной памяти
- свободное место в рутовом разделе /


## 8. (**) Добавить в cron задачу, которая будет каждые 10 минут писать в файл результаты выполнения скрипта из п.


## 9. (***) Сделать п. 5 для Prometheus Node Exporter


