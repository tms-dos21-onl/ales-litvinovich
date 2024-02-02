Развернуть две виртуальные машины (кто еще не сделал, можно последовательно)
- Ubuntu
- Centos

Затем:
1. Произвести минимальную настройку (время, локаль, custom motd)
   
   Проверяем системное время и активирован ли NTP демон
```
ales@ales-None:~$ timedatectl
               Local time: Fri 2024-02-02 09:59:15 +03
           Universal time: Fri 2024-02-02 06:59:15 UTC
                 RTC time: Fri 2024-02-02 06:59:15
                Time zone: Europe/Minsk (+03, +0300)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no

```
   В случае необходимости меняем в ручную

```
ales@ales-None:~$ sudo timedatectl set-time "2025-01-01 00:00:00"
```
   И часовой пояс
```
ales@ales-None:~$ sudo timedatectl set-timezone Europe/Minsk
```
   Настраиваем приветствие при входе
```
ales@ales-None:~$ sudo nano /etc/motd
```
![Результат](https://github.com/tms-dos21-onl/ales-litvinovich/assets/87812043/e4f22fc4-a1b9-4ee1-94c2-29e301329779)

2. Определить точную версию ядра.
   
```
ales@ales-1-2:~$ cat /etc/os-release
PRETTY_NAME="Ubuntu 23.10"
NAME="Ubuntu"
VERSION_ID="23.10"
VERSION="23.10 (Mantic Minotaur)"
VERSION_CODENAME=mantic
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=mantic
LOGO=ubuntu-logo
```

3. Вывести список модулей ядра и записать в файл
   
   Создаем файл в который сразу же записывается результат команды
```
ales@ales-1-2:~$ lsmod > moduls.txt
ales@ales-1-2:~$ cat moduls.txt
Module                  Size  Used by
snd_seq_dummy          12288  0
snd_hrtimer            12288  1
vboxnetadp             28672  0
vboxnetflt             36864  0
vboxdrv               741376  2 vboxnetadp,vboxnetflt
snd_intel8x0           53248  1
snd_ac97_codec        196608  1 snd_intel8x0
ac97_bus               12288  1 snd_ac97_codec
snd_pcm               196608  2 snd_intel8x0,snd_ac97_codec
snd_seq_midi           24576  0
snd_seq_midi_event     16384  1 snd_seq_midi
snd_rawmidi            57344  1 snd_seq_midi
snd_seq               118784  9 snd_seq_midi,snd_seq_midi_event,snd_seq_dummy
snd_seq_device         16384  3 snd_seq,snd_seq_midi,snd_rawmidi
snd_timer              49152  3 snd_seq,snd_hrtimer,snd_pcm
joydev                 32768  0
intel_rapl_msr         20480  0
intel_rapl_common      36864  1 intel_rapl_msr
crct10dif_pclmul       12288  1
polyval_generic        12288  0
ghash_clmulni_intel    16384  0
aesni_intel           356352  0
crypto_simd            16384  1 aesni_intel
snd                   143360  11 snd_seq,snd_seq_device,snd_intel8x0,snd_timer,snd_ac97_codec,snd_pcm,snd_rawmidi
vboxguest             532480  6
i2c_piix4              28672  0
cryptd                 24576  2 crypto_simd,ghash_clmulni_intel
soundcore              16384  1 snd
input_leds             12288  0
mac_hid                12288  0
serio_raw              20480  0
binfmt_misc            24576  1
vmwgfx                434176  2
drm_ttm_helper         12288  1 vmwgfx
ttm                   110592  2 vmwgfx,drm_ttm_helper
drm_kms_helper        270336  3 vmwgfx
msr                    12288  0
parport_pc             53248  0
ppdev                  24576  0
lp                     28672  0
parport                77824  3 parport_pc,lp,ppdev
efi_pstore             12288  0
drm                   761856  7 vmwgfx,drm_kms_helper,drm_ttm_helper,ttm
dmi_sysfs              20480  0
ip_tables              36864  0
x_tables               69632  1 ip_tables
autofs4                57344  2
hid_generic            12288  0
usbhid                 77824  0
hid                   180224  2 usbhid,hid_generic
crc32_pclmul           12288  0
psmouse               212992  0
video                  73728  0
pata_acpi              12288  0
e1000                 180224  0
ahci                   49152  1
libahci                57344  1 ahci
wmi                    40960  1 video
```

4. Просмотреть информацию о процессоре и модулях оперативной памяти

   Процессор
```
ales@ales-None:~$ sudo lshw -class processor -class memory
  *-firmware                
       description: BIOS
       vendor: Phoenix Technologies LTD
       physical id: 0
       version: 6.00
       date: 07/22/2020
       size: 86KiB
       capabilities: isa pci pcmcia pnp apm upgrade shadowing escd cdboot bootselect edd int5printscreen int9keyboard int14serial int17printer int10video acpi smartbattery biosbootspecification netboot
  *-cpu:0
       description: CPU
       product: Intel(R) Xeon(R) CPU E3-1225 V2 @ 3.20GHz
       vendor: Intel Corp.
       physical id: 1
       bus info: cpu@0
       version: 6.58.9
       slot: CPU #000
       size: 3200MHz
       capacity: 4230MHz
       width: 64 bits
       capabilities: lm fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx rdtscp x86-64 constant_tsc arch_perfmon nopl xtopology tsc_reliable nonstop_tsc cpuid tsc_known_freq pni pclmulqdq ssse3 cx16 pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm cpuid_fault pti ssbd ibrs ibpb stibp fsgsbase tsc_adjust smep arat md_clear flush_l1d arch_capabilities
       configuration: cores=1 enabledcores=1 microcode=33
```
   И память
```
*-memory
       description: System Memory
       physical id: 1a2
       slot: System board or motherboard
       size: 4GiB
     *-bank:0
          description: DIMM DRAM EDO
          physical id: 0
          slot: RAM slot #0
          size: 4GiB
          width: 32 bits
```

5. Получить информацию о жестком диске

```
ales@ales-None:~$ sudo fdisk -l
Disk /dev/loop0: 74.11 MiB, 77713408 bytes, 151784 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop1: 73.9 MiB, 77492224 bytes, 151352 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop2: 4 KiB, 4096 bytes, 8 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop3: 240.51 MiB, 252190720 bytes, 492560 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop4: 262.09 MiB, 274821120 bytes, 536760 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop5: 11.2 MiB, 11747328 bytes, 22944 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop6: 496.98 MiB, 521121792 bytes, 1017816 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop7: 91.69 MiB, 96141312 bytes, 187776 sectors
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


Disk /dev/loop9: 10.52 MiB, 11026432 bytes, 21536 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop8: 9.72 MiB, 10194944 bytes, 19912 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop10: 40.86 MiB, 42840064 bytes, 83672 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop11: 452 KiB, 462848 bytes, 904 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

```

6. Добавить в виртуальную машину второй сетевой интерфейс (вывести информацию о нем в виртуалках)

```
   ales@ales-1-2:~$ ifconfig
enp0s3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.2.15  netmask 255.255.255.0  broadcast 10.0.2.255
        inet6 fe80::a00:27ff:fe2e:5f3b  prefixlen 64  scopeid 0x20<link>
        ether 08:00:27:2e:5f:3b  txqueuelen 1000  (Ethernet)
        RX packets 266  bytes 270400 (270.4 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 258  bytes 31905 (31.9 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

enp0s8: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.3.15  netmask 255.255.255.0  broadcast 10.0.3.255
        inet6 fe80::78ad:5b51:9cc2:f98a  prefixlen 64  scopeid 0x20<link>
        ether 08:00:27:2e:20:84  txqueuelen 1000  (Ethernet)
        RX packets 100  bytes 15756 (15.7 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 167  bytes 16577 (16.5 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

7. (**) Узнать полную информацию об использованной и неиспользованной оперативной памяти

```
   ales@ales-1-2:~$ free -h
               total        used        free      shared  buff/cache   available
Память:        3,8Gi       1,1Gi       2,2Gi        40Mi       850Mi       2,7Gi
Подкачка:      3,8Gi          0B       3,8Gi
```

8. (**) Создать пользователя new_admin_user, Настроить ssh доступ пользователю по ключу на VM, запретить ему авторизацию по паролю
   
   Создаем пользователя
```
ales@ales-None:~$ sudo adduser new_admin_user
info: Adding user `new_admin_user' ...
info: Selecting UID/GID from range 1000 to 59999 ...
info: Adding new group `new_admin_user' (1001) ...
info: Adding new user `new_admin_user' (1001) with group `new_admin_user (1001)' ...
info: Creating home directory `/home/new_admin_user' ...
info: Copying files from `/etc/skel' ...
New password: 
BAD PASSWORD: The password is shorter than 8 characters
Retype new password: 
Sorry, passwords do not match.
New password: 
BAD PASSWORD: The password is shorter than 8 characters
Retype new password: 
passwd: password updated successfully
Changing the user information for new_admin_user
Enter the new value, or press ENTER for the default
	Full Name []: new_admin_user
	Room Number []: 1
	Work Phone []: 1
	Home Phone []: 1
	Other []: 
Is the information correct? [Y/n] y
info: Adding new user `new_admin_user' to supplemental / extra groups `users' ...
info: Adding user `new_admin_user' to group `users' ...

```
   Даем ему права админа
```
ales@ales-None:~$ sudo usermod -aG sudo new_admin_user
```
   Переключаемся на новосозданного пользователя
```
ales@ales-None:~$ su - new_admin_user
```
   Создаем для него SSH-ключ
```
new_admin_user@ales-None:~$ ssh-keygen -t rsa -b 2048
Generating public/private rsa key pair.
Enter file in which to save the key (/home/new_admin_user/.ssh/id_rsa): 
Created directory '/home/new_admin_user/.ssh'.
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/new_admin_user/.ssh/id_rsa
Your public key has been saved in /home/new_admin_user/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:I7zwHtPPSzaiiFUw3zYbkyiOjOJxkTPCtF7wTpaA6Do new_admin_user@ales-None
The key's randomart image is:
+---[RSA 2048]----+
|                 |
|o                |
|o+  o            |
|+ = o= o .       |
| = @o * S        |
|oo*o+= = *       |
|Eoooo = + +      |
|o.oo o + * .     |
| .. . o   +.     |
+----[SHA256]-----+

```
   Копируем ключ в файл
```
new_admin_user@ales-None:~$ cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
```
   Через nano редактируем конфигурацию SSH запретив взод по паролю и разрешив по ключу
   PasswordAuthentication no
   PubkeyAuthentication yes
```
new_admin_user@ales-None:~$ sudo nano /etc/ssh/sshd_config
```
   Перезапускаем демона SSH для применения новой конфигурации
```
new_admin_user@ales-None:~$ sudo systemctl restart ssh
```

9. (**) Вывести список файловых систем, которые поддерживаются ядром

```
ales@ales-1-2:~$ cat /proc/filesystems
nodev	sysfs
nodev	tmpfs
nodev	bdev
nodev	proc
nodev	cgroup
nodev	cgroup2
nodev	cpuset
nodev	devtmpfs
nodev	configfs
nodev	debugfs
nodev	tracefs
nodev	securityfs
nodev	sockfs
nodev	bpf
nodev	pipefs
nodev	ramfs
nodev	hugetlbfs
nodev	devpts
	ext3
	ext2
	ext4
	squashfs
	vfat
nodev	ecryptfs
	fuseblk
nodev	fuse
nodev	fusectl
nodev	efivarfs
nodev	mqueue
nodev	pstore
nodev	autofs
nodev	binfmt_misc
```
