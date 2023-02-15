# FreeBSD Post Install

This is my personal FreeBSD post-installation script that automates the process of downloading and installing the necessary packages and performing various tasks. 
# Usage
Dont clone the repo because the script will do that itself. Instead use fetch to download the script and run it as root. 
```
fetch https://raw.githubusercontent.com/wolandark/FreeBSD_Post_Install/main/FreeBSD_Post_Install.sh
```
# Looks
![image](https://github.com/wolandark/FreeBSD_Post_Install/blob/main/screenshot.jpg)

This script will download the following packages:
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
feh --bg-scale ~/freebsd-wallpaper.jpg
exec icewm
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

This is a very basic shell script that aims to aid users who want to experince FreeBSD in a graphical enviorment. This script assumes the following but will work just fine in any case:

- You are on a clean install of FreeBSD 13.1+
- You are familiar with how unix operating systems work and are able to alter the script should you need to
- You know what you're doing
- You prefer to startx instead of using a display manager although any display manager can be installed and enabled by the user if needed
- You are connected to the internet 
- You have atleast 5gb of storage 

Please feel free to use, distribute and change the script to your needs. Also please feel free to make suggestions and pull requests and fork the repo.

# Discalimer
I do not claim the credit for the icewm theme. The nord icewm theme is available for download from [here](https://www.box-look.org/p/1952840) and the credit goes to the amazing person who made the theme. I have of course added my own keybinindg and certain customizations to the icewm files.

