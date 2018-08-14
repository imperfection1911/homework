# Загрузка #
centos с lvm на которой буду выполнять дз. Таблица разделов имеет следующий вид.
![partitions](https://github.com/imperfection1911/homework/blob/boot/4/partitions.png)

## Задача 1. 3 способами попасть в систему без пароля ##
### Способ 1 ###
При загрузке в grub добавляю параметр rd.break в строку linux16.
![rd.break](https://github.com/imperfection1911/homework/blob/boot/4/rdbreak.png)
Загружаюсь. Перемонтирую /sysroot на чтение и запись и меняю пароль. С первого раза не получилось, так как забыл выключить selinux после установки. 
В итоге порядок действий следующий.
1. Добавить rd.break в root
2. mount -o remount, rw /sysroot
3. chroot /sysroot
4. passwd
5. Добавить в корень файл ./.autorelabel
6. reboot
7. Выключить selinux!
### Способ 2 ###
Добавить в grub параметр rw init=/sysroot/bin/sh
![/bin/sh](https://github.com/imperfection1911/homework/blob/boot/4/binsh.png)
1. Убрать rhgb и quiet, ro. Добавить rw init=/sysroot/bin/sh. Загрузится
2. делаю все то же самое, что и при первом способе, кроме создания .autorelabel т. к. selinux уже выключен.
### Способ 3 ###
Загрузка с livecd. 
1.выбор troubleshouting и загрузка в rescеue режиме.
2. chroot на /mnt/sysimage Дальше все как обычно.

## Задача 2. Переименовать Volume group ##
![vgrename](https://github.com/imperfection1911/homework/blob/boot/4/vgrename.png)
Меняю имя vg в файлах
* /etc/fstab
* /etc/default/grub
* /boot/grub2/grub.cfg
Пересоздаю initramfs командой dracut --force и перезагружаюсь

## Задача 3. Добавить модуль в initrd ##

Создал скрипты аналогичные тем что были на слайдах(мой просто hi выводит). 
Пересоздал initrd командой dracut --force. Результат

![hi](https://github.com/imperfection1911/homework/blob/boot/4/hi.png)
