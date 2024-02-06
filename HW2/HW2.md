1. Создать новый виртуальный жёсткий диск, присоеденить его к VM, создать раздел (partition) и инициализировать на нём файловую системую.

После создания нового диска на 5гб для виртуалки размечаем диск в системе:
```
ales@ales-None:~$ sudo fdisk /dev/sdb

Welcome to fdisk (util-linux 2.39.1).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS (MBR) disklabel with disk identifier 0xf2a24b11.

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): 

Using default response p.
Partition number (1-4, default 1): 
First sector (2048-10485759, default 2048): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-10485759, default 10485759): 

Created a new partition 1 of type 'Linux' and of size 5 GiB.

Command (m for help): p
Disk /dev/sdb: 5 GiB, 5368709120 bytes, 10485760 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xf2a24b11

Device     Boot Start      End  Sectors Size Id Type
/dev/sdb1        2048 10485759 10483712   5G 83 Linux

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```
Проверяем резльтат:
```
ales@ales-None:~$ sudo fdisk -l
Disk /dev/loop0: 74.11 MiB, 77713408 bytes, 151784 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

Disk /dev/sda: 20 GiB, 21474836480 bytes, 41943040 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 72C34CC1-4204-4254-BA22-0BF8F5A3860A

Device     Start      End  Sectors Size Type
/dev/sda1   2048     4095     2048   1M BIOS boot
/dev/sda2   4096 41940991 41936896  20G Linux filesystem


Disk /dev/sdb: 5 GiB, 5368709120 bytes, 10485760 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xf2a24b11

Device     Boot Start      End  Sectors Size Id Type
/dev/sdb1        2048 10485759 10483712   5G 83 Linux
```
Создаем файловую систему ext4:
```
ales@ales-None:~$ sudo mkfs.ext4 -m 0 /dev/sdb1
mke2fs 1.47.0 (5-Feb-2023)
Creating filesystem with 1310464 4k blocks and 327680 inodes
Filesystem UUID: 1290fc1e-a905-400a-b341-4e6a5f55d654
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done
```

2. Смонтировать директорию /mnt/home на только что созданный раздел.
   
Заходим в файл и прописываем параметры для монтирования:
```
ales@ales-None:~$ sudo nano /etc/fstab

/dev/sdb1  /mnt/home/ ext4 defaults  0 0
```
После чего выполняем команду:
```
ales@ales-None:~$ sudo mount -a
```
Проверяем результат:
```
ales@ales-None:~$ df -h
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           388M  2.1M  385M   1% /run
/dev/sda2        20G  9.0G  9.6G  49% /
tmpfs           1.9G     0  1.9G   0% /dev/shm
tmpfs           5.0M  8.0K  5.0M   1% /run/lock
tmpfs           388M  100K  387M   1% /run/user/1000
/dev/sdb1       4.9G   24K  4.9G   1% /mnt/home
```
3. Создать нового пользователя penguin с home-директорией /mnt/home/penguin.

```
ales@ales-None:~$ sudo adduser penguin1 --home /mnt/home/penguin
info: Adding user `penguin1' ...
info: Selecting UID/GID from range 1000 to 59999 ...
info: Adding new group `penguin1' (1007) ...
info: Adding new user `penguin1' (1007) with group `penguin1 (1007)' ...
info: Creating home directory `/mnt/home/penguin' ...
info: Copying files from `/etc/skel' ...
New password: 
BAD PASSWORD: The password is shorter than 8 characters
Retype new password: 
passwd: password updated successfully
Changing the user information for penguin1
Enter the new value, or press ENTER for the default
	Full Name []: 
	Room Number []: 
	Work Phone []: 
	Home Phone []: 
	Other []: 
Is the information correct? [Y/n] y
info: Adding new user `penguin1' to supplemental / extra groups `users' ...
info: Adding user `penguin1' to group `users' ...
```

4. Создать новую группу пользователей birds, перенести в нее пользователя penguin.

Создаем группу:
```
ales@ales-None:~$ sudo groupadd birds
```
Назначаем новую основную группу для пользователя penguin1:
```
ales@ales-None:~$ sudo usermod -g birds penguin1
```
5. Cоздать директорию /var/wintering и выдать права на нее только группе birds.
   
   
6. Установить ntpd (или chrony) и разрешить пользователю penguin выполнять команду systemctl restart chronyd (нужны права sudo). Больше узнать о том, что такое NTP и почему он важен можно из следующей статьи.

   
7. (**) Вывод команды iostat -x в последней колонке показывает загрузку дисков в процентах. Откуда утилита это понимает?  
Достаточно ли вывода команды iostat -x для того, чтобы оценить реальную нагрузку на диски, или нужны дополнительные условия или ключи?


8. (***) Подумать, что сделает команда chmod -x $(which chmod). Выполнить её на виртуальной машине и вернуть всё как было не прибегая к скачиванию\копированию chmod с другого хоста.

    
