1. Вывести в консоль список всех пользователей системы.
```
root@ales:/# sed 's/:.*//' /etc/passwd
root
daemon
bin
sys
sync
games
man
lp
mail
news
uucp
proxy
www-data
backup
list
irc
_apt
nobody
systemd-network
systemd-timesync
dhcpcd
messagebus
syslog
systemd-resolve
uuidd
usbmux
tss
systemd-oom
tcpdump
avahi-autoipd
kernoops
whoopsie
dnsmasq
avahi
cups-pk-helper
sssd
speech-dispatcher
fwupd-refresh
saned
geoclue
cups-browsed
hplip
polkitd
rtkit
colord
gnome-initial-setup
gdm
nm-openvpn
ales
sshd
_chrony
new_admin_user
penguin
bub
pinguin
pinguin1
pinguin2
penguin1
ntpsec
prometheus
node_exporter
```

2. Найти и вывести в консоль домашние каталоги для текущего пользователя и root.
```
ales@ales:~$ $HOME
bash: /home/ales: Is a directory

ales@ales:~$ $(getent passwd root | cut -d: -f6)
bash: /root: Is a directory
```

3. Создать Bash скрипт get-date.sh, выводящий текущую дату.
Создаем скрипт get-date.sh:
```
#!/bin/bash
date
```
4. Запустить скрипт через ./get-date.sh и bash get-date.sh. Какой вариант не работает? Сделать так, чтобы оба варианта работали.
Первый вариант не работает из-за отсутствия прав на исполнение
```
ales@ales:~$ bash get-date.sh 
Thu May 16 10:09:41 AM +03 2024


ales@ales:~$ sudo ./get-date.sh
sudo: ./get-date.sh: command not found

ales@ales:~$ chmod +x get-date.sh
ales@ales:~$ sudo ./get-date.sh
Thu May 16 10:10:41 AM +03 2024
```

5. Создать пользователей alice и bob с домашними директориями и установить /bin/bash в качестве командной оболочки по умолчанию.
```
root@ales:/home/ales# useradd -m -s /bin/bash alice
root@ales:/home/ales# useradd -m -s /bin/bash bob
```

6. Запустить интерактивную сессию от пользователя alice. Создать файл secret.txt с каким-нибудь секретом в домашней директории при помощи текстового редактора nano.
```
root@ales:/home/ales# su - alice
alice@ales:~$ nano ~/secret.txt
```

7. Вывести права доступа к файлу secret.txt.
```
alice@ales:~$ ls -l ~/secret.txt
-rw-rw-r-- 1 alice alice 5 May 16 10:24 /home/alice/secret.txt
```

8. Выйти из сессии от alice и открыть сессию от bob. Вывести содержимое файла /home/alice/secret.txt созданного ранее не прибегая к команде sudo. В случае, если это не работает, объяснить.
```text
 Попытка чтения файла /home/alice/secret.txt не сработает без использования sudo, так как bob не имеет доступа к домашней директории alice.
```

9. Создать файл secret.txt с каким-нибудь секретом в каталоге /tmp при помощи текстового редактора nano.
```
bob@ales:~$ nano /tmp/secret.txt
```

10. Вывести права доступа к файлу secret.txt. Поменять права таким образом, чтобы этот файл могли читать только владелец и члены группы, привязанной к файлу.
```
bob@ales:~$ nano /tmp/secret.txt
bob@ales:~$ ls -l /tmp/secret.txt
chmod 640 /tmp/secret.txt
-rw-rw-r-- 1 bob bob 5 May 16 10:34 /tmp/secret.txt
```

11. Выйти из сессии от bob и открыть сессию от alice. Вывести содержимое файла /tmp/secret.txt созданного ранее не прибегая к команде sudo. В случае, если это не работает, объяснить.
```
alice@ales:~$ cat /tmp/secret.txt
cat: /tmp/secret.txt: Permission denied

Под пользователем alice вывод содержимого файла /tmp/secret.txt будет успешным, так как она является владельцем файла и имеет права на чтение
```

12. Добавить пользователя alice в группу, привязанную к файлу /tmp/secret.txt.
```
root@ales:/home/ales# usermod -aG bob  alice
```

13. Вывести содержимое файла /tmp/secret.txt.
```
alice@ales:~$ cat /tmp/secret.txt
2222
```

14. Скопировать домашнюю директорию пользователя alice в директорию /tmp/alice с помощью rsync.
```
alice@ales:~$ rsync -avzh /home/alice /tmp/
sending incremental file list
alice/
alice/.bash_history
alice/.bash_logout
alice/.bashrc
alice/.profile
alice/secret.txt
alice/.local/
alice/.local/share/
alice/.local/share/nano/

sent 2.85K bytes  received 131 bytes  5.96K bytes/sec
total size is 4.99K  speedup is 1.67
```

15. Скопировать домашнюю директорию пользователя alice в директорию /tmp/alice на другую VM по SSH с помощью rsync. Как альтернатива, можно скопировать любую папку с хоста на VM по SSH (scp).

Использую SCP, чтобы передать папку с windows на VM
```
scp -r -v D:\build ales@192.168.217.142:/home/ales/
debug1: client_input_channel_req: channel 0 rtype exit-status reply 0
debug1: channel 0: free: client-session, nchannels 1
Transferred: sent 2720, received 3236 bytes, in 0.3 seconds
Bytes per second: sent 8723.4, received 10378.3
debug1: Exit status 0
```

16. Удалить пользователей alice и bob вместе с домашними директориями.
```
deluser --remove-home alice
deluser --remove-home bob
```

17. С помощью утилиты htop определить какой процесс потребляет больше всего ресурсов в системе.

```
Больше всего ресурсов системы кушает процесс отвечающий за GUI - gnome-shell
```
18. Вывести логи сервиса Firewall с помощью journalctl не прибегая к фильтрации с помощью grep.

```
ales@ales:~$ journalctl -u firewall.service
-- No entries --
```