Развернуть две виртуальные машины (кто еще не сделал, можно последовательно)
- Ubuntu
- Centos

Затем:
1. Произвести минимальную настройку (время, локаль, custom motd)
2. Определить точную версию ядра.
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
5. Просмотреть информацию о процессоре и модулях оперативной памяти
6. Получить информацию о жестком диске
7. Добавить в виртуальную машину второй сетевой интерфейс (вывести информацию о нем в виртуалках)
8. (**) Узнать полную информацию об использованной и неиспользованной оперативной памяти
9. (**) Создать пользователя new_admin_user, Настроить ssh доступ пользователю по ключу на VM, запретить ему авторизацию по паролю
10. (**) Вывести список файловых систем, которые поддерживаются ядром
