## 1. Познакомиться с веб-приложением
- backend

- frontend


## 2. Познакомиться с вариантами хостинга этого веб-приложения:



## 3. Установить веб-приложение (backend + frontend) на Linux VM и настроить запуск через SystemD

- В первую очередь скачиваем репозитории 
```
$ git clone https://github.com/bezkoder/django-rest-api.git
$ git clone https://github.com/bezkoder/react-crud-web-api.git
```
### Конфигурация frontend 
Для корректной работы требуется установка npm-менеджера, node.js, а также применить команду npm install в папке с проектом для установки зависимостей, которые прописаны в package.json.
Теперь запустим сервер - npm start и получим вывод:
```
Compiled successfully!

You can now view react-crud in the browser.

  Local:            http://localhost:8081
  On Your Network:  http://10.0.2.15:8081

Note that the development build is not optimized.
To create a production build, use yarn build.

webpack compiled successfully
```
- Теперь создадим службу frontend.service:
```
[Unit]
Description=React-crud-web-api

[Service]
Type=simple
ExecStart=/usr/bin/npm --prefix /home/ales/react-crud-web-api start
Restart=always

[Install]
WantedBy=multi-user.target
```
### Конфигурация backend
- Для корректной работы требуется установка python3, pip-менеджер, django, nginx.
Обновляем схему базы данных командой python manage.py migrate, а затем пробуем запустить:
```
root@ales:/home/ales/django-rest-api/DjangoRestApi# python3 manage.py runserver 0.0.0.0:8080

Watching for file changes with StatReloader
Performing system checks...

System check identified some issues:

WARNINGS:
tutorials.Tutorial: (models.W042) Auto-created primary key used when not defining a primary key type, by default 'django.db.models.AutoField'.
	HINT: Configure the DEFAULT_AUTO_FIELD setting or the TutorialsConfig.default_auto_field attribute to point to a subclass of AutoField, e.g. 'django.db.models.BigAutoField'.

System check identified 1 issue (0 silenced).
May 13, 2024 - 21:47:54
Django version 3.2.10, using settings 'DjangoRestApi.settings'
Starting development server at http://0.0.0.0:8080/
Quit the server with CONTROL-C.
Error: That port is already in use.
```
- Создаем службу для beckend:
```
[Unit]
Description=DjangoRestApi

[Service]
Type=simple
ExecStart=/usr/bin/python3 /home/ales/django-rest-api/DjangoRestApi/manage.py runserver 0.0.0.0:8080
Restart=always

[Install]
WantedBy=multi-user.target
```
### Запускаем службы одновременно и тестируем:
```
systemctl start frontend.service backend.service
```
- Создаю второй сетевой адаптер у вируталки с типом "Виртуальный адаптер хоста", чтобы иметь возможность иметь доступ из вне
При запуске вебки получаю ошибку Disallowed Host
Решение: в файле settings.py меняю конфигурацию на
```
ALLOWED_HOSTS = ['*']
```
- Следующая ошибка ругается на CORS
Решение: в файлике settings.py меняю конфигурацию на
```
CORS_ORIGIN_ALLOW_ALL = True
```
- Следующая ошибка ругается на localhost:8080
Решение: http-common.js меняем localhost на актуальный айпишник и перезапускаем службы

- По итогу все работает!
![Результат](image.png)

 ## 4. (**) Познакомиться с инструментом для создания образов VM - Packer - на примерах создания образов для Virtualbox & Hyper-V. Попробовать написать свой шаблон для создания образа VM. 

- На основе конфигурации для virtualbox сделал шаблон для установки 24 версии убунту, а также изменил другие параметры автонастройки 
```

variable "cpu" {
  type    = string
  default = "2"
}

variable "disk_size" {
  type    = string
  default = "25500"
}

variable "iso_checksum" {
  type    = string
  default = "b8f31413336b9393ad5d8ef0282717b2ab19f007df2e9ed5196c13d8f9153c8b"
}

variable "iso_checksum_type" {
  type    = string
  default = "sha256"
}

variable "iso_url" {
  type    = string
  default = "https://releases.ubuntu.com/24.04/ubuntu-24.04-desktop-amd64.iso"
}

variable "password" {
  type    = string
  default = "1111"
}

variable "ram_size" {
  type    = string
  default = "2048"
}

variable "username" {
  type    = string
  default = "ales"
}

variable "vm_name" {
  type    = string
  default = "ubuntu-24"
}

source "virtualbox-iso" "ubuntu" {
    boot_command = [
    "<enter><wait><enter><f6><esc><wait> ",
    "autoinstall<wait>",
    " ip=dhcp<wait>",
    " cloud-config-url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/user-data<wait>",
    " ds='nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/'",
    "<wait5><enter>"
  ]

  boot_wait            = "7s"
  communicator         = "ssh"
  cpus                 = "${var.cpu}"
  disk_size            = "${var.disk_size}"
  guest_os_type        = "Ubuntu_64"
  guest_additions_mode = "disable"
  http_directory       = "./http/24.04/"
  iso_checksum         = "${var.iso_checksum_type}:${var.iso_checksum}"
  iso_url              = "${var.iso_url}"
  memory               = "${var.ram_size}"
  shutdown_command     = "echo '${var.password}' | sudo -S -E shutdown -P now"
  ssh_password         = "${var.password}"
  ssh_timeout          = "4h"
  ssh_username         = "${var.username}"
  vboxmanage           = [
    ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"], 
  ]
  vm_name              = "${var.vm_name}"
}

build {
  sources = ["source.virtualbox-iso.ubuntu"]

  provisioner "shell" {
    execute_command = "echo 'ubuntu' | sudo -S -E sh {{ .Path }}"
    scripts         = [
      "./scripts/cleanup.sh"
    ]
  }
}
```
