#!/bin/sh

#Written by Woland
#A post installation script for FreeBSD
#configures FreeBSD for desktop use
#Run as root

pkg update
pkg upgrade -y

echo -e "permit nopass keepenv :woland\npermit nopass :woland cmd reboot\npermit nopass :woland cmd poweroff\npermit :wheel" >> /usr/local/etc/doas.conf

echo -e "autoboot_delay=3\nloader_logo=\"beastie\"\ncoretemp_load\"YES\"\ntmpfs_load=\"YES\"\naio_load=\"YES\"\nfuse_load=\"YES\"hw.syscond.bell=0" >> /boot/loader.conf

echo -e "vfs.usermount=1\nkern.shed_threshold=4\nkern.sched.preempt_thresh=64\nkern.ipc.shm_allow_removed=1\nkern.vt.enable_bell=0" >> /etc/sysctl.conf

echo -e "ntpd_flags=\"-g\"\nfuse_enable=\"YES\"" >> /etc/rc.conf 

echo -e "USERMOUNT=YES\nATIME=NO\nREMOVEDIRS=YES\nFM=\"pcmanfm\"\nUSER=woland\nENCODING=en_US.UTF-8" >> /usr/local/etc/automount.conf

echo -e "xsetroot -cursor_name left_ptr\nxset r rate 250 60\nxset b off\nxmodmap -e \"keycode 147 = Super_L\"\nexport LC_ALL=en_US.UTF-8\nexport MM_CHARSET=UTF-8\n" >> /home/woland/.xinitrc

echo -e "export TERM=xterm-256color\nexport VISUAL=vim\nexport LANG=en_US.UTF-8\nexport LANGUAGE=en_US.UTF-8\nexport GTK2_RC_FILES="$HOME/.gtkrc-2.0"\nexport BROWSER=qutebrowser\nexport QT_QPA_PLATFORMTHEME=\"qt5ct\"\nMOZ_X11_EGL=1" >> /home/woland/.bashrc

pkg install -y automount fusefs-exfat fusefs-ext2 fusefs-gphotofs fusefs-hfsfuse fusefs-jmtpfs fusefs-ntfs dbus papirus-icon-theme xviewer feh pcmanfm vim-X11 wget curl bash py39-ranger htop pfetch git doas xorg icewm w3m w3m-img exa scrot 

kldload fusefs
/etc/rc.d/devd restart

sysrc dbus_enable="YES"
#sysrc sddm_enable="YES"

reboot



