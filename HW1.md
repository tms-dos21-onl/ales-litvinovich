Развернуть две виртуальные машины (кто еще не сделал, можно последовательно)
- Ubuntu
- Centos

Затем:
1. Произвести минимальную настройку (время, локаль, custom motd)
   
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
   
5. Получить информацию о жестком диске
   
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
8. (**) Узнать полную информацию об использованной и неиспользованной оперативной памяти

```
   ales@ales-1-2:~$ free -h
               total        used        free      shared  buff/cache   available
Память:        3,8Gi       1,1Gi       2,2Gi        40Mi       850Mi       2,7Gi
Подкачка:      3,8Gi          0B       3,8Gi
```
8. (**) Создать пользователя new_admin_user, Настроить ssh доступ пользователю по ключу на VM, запретить ему авторизацию по паролю
    
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
