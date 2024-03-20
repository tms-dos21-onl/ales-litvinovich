1. Распределить основные сетевые протоколы (перечислены ниже) по уровням модели TCP/IP:

```
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

4. Установить telnetd на VM, зайти на нее с другой VM с помощью telnet и отловить вводимый пароль и вводимые команды при входе c помощью tcpdump

5. (***) Открыть порт 222/tcp и обеспечить прослушивание порта с помощью netcat, проверить доступность порта 222 с помощью telnet и nmap.
