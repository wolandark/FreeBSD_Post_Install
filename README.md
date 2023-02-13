# FreeBSD_Post_install

This is my personal FreeBSD post install script
it downloads the following packaged and performs the following tasks

adds the following lines to [/usr/local/etc/doas.conf]()<br>
```
permit nopass keepenv :$USER
permit nopass :$USER cmd reboot
permit nopass :$USER cmd poweroff
permit :wheel 
```
