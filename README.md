# FreeBSD Post Install

This is my personal FreeBSD post-installation script that automates the process of downloading and installing the necessary packages and performing various tasks. The following packages will be installed:
# Usage
Dont clone the repo because the script will do that itself. Instead use fetch to download the script and run it as root. 
```
https://raw.githubusercontent.com/wolandark/FreeBSD_Post_Install/main/FreeBSD_Post_Install.sh
```

- automount
- fusefs-exfat
- fusefs-ext2
- fusefs-gphotofs
- fusefs-hfsfuse
- fusefs-jmtpfs
- firefox
- fusefs-ntfs
- dbus
- papirus-icon-theme
- xviewer
- feh
- pcmanfm
- vim-X11
- wget
- curl
- bash
- py39-ranger
- htop
- pfetch
- git
- doas
- xorg
- icewm
- w3m
- w3m-img
- exa
- scrot
- menumaker

The script performs the following tasks:

- Adds the following lines to [/usr/local/etc/doas.conf]():

```
permit nopass keepenv :$USER
permit nopass :$USER cmd reboot
permit nopass :$USER cmd poweroff
permit :wheel
```
- Adds the following lines to [/boot/loader.conf]():
```
echo -e "autoboot_delay=3
loader_logo="beastie
coretemp_load"YES"
tmpfs_load="YES"
aio_load="YES"
fuse_load="YES"
hw.syscond.bell=0
```
- Adds the following lines to [/etc/sysctl.conf]():
```
vfs.usermount=1
kern.shed_threshold=4
kern.sched.preempt_thresh=64
kern.ipc.shm_allow_removed=1
kern.vt.enable_bell=0
```
- Adds the following lines to [/etc/rc.conf]():
```
ntpd_flags="-g"
fuse_enable="YES"
```
- Adds the following lines to [/usr/local/etc/automount.conf]():
```
USERMOUNT=YES
ATIME=NO
REMOVEDIRS=YES
FM="pcmanfm"
USER=woland
ENCODING=en_US.UTF-8
```

- Adds the following lines to [/home/$USER/.xinitrc]():
```
xsetroot -cursor_name left_ptr
xset r rate 250 60
xset b off
xmodmap -e "keycode 147 = Super_L"
```
- Adds the following lines to [/home/$USER/.bashrc]():
```
export TERM=xterm-256color
export VISUAL=vim
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export BROWSER=firefox
export QT_QPA_PLATFORMTHEME="qt5ct"
MOZ_X11_EGL=1
export LC_ALL=en_US.UTF-8
export MM_CHARSET=UTF-8
```
- Loads the following kernel module:
```
fusefs
```
- Enables the following service:
```
dbus
```







