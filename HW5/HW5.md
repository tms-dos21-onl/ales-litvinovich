1. Распределить основные сетевые протоколы (перечислены ниже) по уровням модели TCP/IP:

```console
- UDP
- TCP
- FTP
- RTP
- DNS
- ICMP
- HTTP
- NTP
- SSH
```
 - Прикладной:HTTP, FTP, RTP, SSH, DNS, NTP
 - Трансопртный: TCP, UDP
 - Межсетевой: ICMP,
 - Канальный: -

2. Узнать pid процесса и длительность подключения ssh с помощью утилиты ss

- Вывожу PID процессов
```console
ales@KOMPUTER:~$ ps aux | grep ssh
root        1184  0.0  0.1  15428  8816 ?        Ss   14:53   0:00 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
root        1233  0.0  0.1  17180 10976 ?        Ss   14:54   0:00 sshd: ales [priv]
ales        1257  0.0  0.0  17312  7852 ?        S    14:54   0:00 sshd: ales@pts/2
ales        5270  0.0  0.0   4028  2112 pts/0    S+   14:58   0:00 grep --color=auto ssh
```
- Получаю keepalive 
```console
ales@KOMPUTER:~$ ss -tn -o
State      Recv-Q      Send-Q            Local Address:Port            Peer Address:Port       Process
ESTAB      0           0                172.31.107.222:22               172.31.96.1:62296       timer:(keepalive,109min,0)
```

3. Закрыть все порты для входящих подключений, кроме ssh
```console
ales@KOMPUTER:~$ sudo ufw allow ssh
Rule added
Rule added (v6)
```
```console
ales@KOMPUTER:~$ sudo ufw default deny incoming
Default incoming policy changed to 'deny'
(be sure to update your rules accordingly)
```

```console
ales@KOMPUTER:~$ sudo ufw enable
Firewall is active and enabled on system startup
ales@KOMPUTER:~$ sudo ufw status
Status: active

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW       Anywhere
22/tcp (v6)                ALLOW       Anywhere (v6)
```


4. Установить telnetd на VM, зайти на нее с другой VM с помощью telnet и отловить вводимый пароль и вводимые команды при входе c помощью tcpdump

- Устанавливаю telnet и открываю 23 порт

- Перехватываю трафик 

```console
ales2@KOMPUTER:~$ sudo tcpdump -i eth0  port 23
```

- Подключаюсь к другой вируталке
```console
ales2@KOMPUTER:~$ telnet 172.31.107.222
Trying 172.31.107.222...
Connected to 172.31.107.222.
Escape character is '^]'.
Ubuntu 22.04.3 LTS
KOMPUTER login: ales2
Password: 
Welcome to Ubuntu 22.04.3 LTS (GNU/Linux 5.15.146.1-microsoft-standard-WSL2 x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
```
- Получаю результат. Пароль 1111
```console
ales@KOMPUTER:~$ sudo tcpdump -A port 23
E..24.@.@.....k...`.........fn..P...$C..Password:
20:25:21.462573 IP KOMPUTER.mshome.net.54526 > 172.31.107.222.telnet: Flags [.], ack 116, win 1026, length 0
E..(".@.......`...k.....fn......P...{...
20:25:22.518487 IP KOMPUTER.mshome.net.54526 > 172.31.107.222.telnet: Flags [P.], seq 135:136, ack 116, win 1026, length 1
E..)".@.......`...k.....fn......P...J...1
20:25:22.564807 IP 172.31.107.222.telnet > KOMPUTER.mshome.net.54526: Flags [.], ack 136, win 502, length 0
E..(4.@.@.....k...`.........fn..P...$9..
20:25:22.733382 IP KOMPUTER.mshome.net.54526 > 172.31.107.222.telnet: Flags [P.], seq 136:137, ack 116, win 1026, length 1
E..)".@.......`...k.....fn......P...J...1
20:25:22.733410 IP 172.31.107.222.telnet > KOMPUTER.mshome.net.54526: Flags [.], ack 137, win 502, length 0
E..(4.@.@.....k...`.........fn..P...$9..
20:25:22.941936 IP KOMPUTER.mshome.net.54526 > 172.31.107.222.telnet: Flags [P.], seq 137:138, ack 116, win 8195, length 1
E..)".@.......`...k.....fn......P. .....1
20:25:22.941995 IP 172.31.107.222.telnet > KOMPUTER.mshome.net.54526: Flags [.], ack 138, win 502, length 0
E..(4.@.@.....k...`.........fn..P...$9..
20:25:23.174235 IP KOMPUTER.mshome.net.54526 > 172.31.107.222.telnet: Flags [P.], seq 138:139, ack 116, win 8195, length 1
E..)".@.......`...k.....fn......P. .....1
```

5. (***) Открыть порт 222/tcp и обеспечить прослушивание порта с помощью netcat, проверить доступность порта 222 с помощью telnet и nmap.

```
```
