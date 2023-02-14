#!/bin/sh

#https://github.com/wolandark/FreeBSD_Post_Install
#Written by Woland
#A post installation script for FreeBSD
#Configures FreeBSD for Desktop Use
#Run as root

#Check if root
if [ "$(id -u)" -ne 0 ]
  then echo -e "\033[33mPlease run as root\033[0m"
  exit
fi

#Get user info and store in vars
echo -e "\033[32mWhat is your normal user's username?\033[0m" 
read normal
echo -e "\033[32mWhat is your normal user's shell?\033[0m" 
read nshell

#Update and Upgrade 
echo -e "\033[35mPreparing to Update...\033[0m"
pkg update
echo -e "\033[32mDone\033[0m"
echo -e "\033[35mUpgrading...\033[0m"
pkg upgrade -y
echo -e "\033[32mDone\033[0m"

#Doas
echo -e "\033[33mConfiguring doas\033[0m"
echo -e "\033[32mDone\033[0m"
echo -e "permit nopass keepenv :$normal\npermit nopass :$normal cmd reboot\npermit nopass :$normal cmd poweroff\npermit :wheel" >> /usr/local/etc/doas.conf

#Boot
echo -e "\033[33mConfiguring boot\033[0m"
echo -e "\033[32mDone\033[0m"
echo -e "autoboot_delay=3\nloader_logo=\"beastie\"\ncoretemp_load\"YES\"\ntmpfs_load=\"YES\"\naio_load=\"YES\"\nfuse_load=\"YES\"hw.syscond.bell=0" >> /boot/loader.conf

#Kern 
echo -e "\033[33mTuning for desktop\033[0m"
echo -e "\033[32mDone\033[0m"
echo -e "vfs.usermount=1\nkern.shed_threshold=4\nkern.sched.preempt_thresh=64\nkern.ipc.shm_allow_removed=1\nkern.vt.enable_bell=0" >> /etc/sysctl.conf

#Fuse & Automount
echo -e "\033[33mConfiguring fuse\033[0m"
echo -e "\033[32mDone\033[0m"
echo -e "ntpd_flags=\"-g\"\nfuse_enable=\"YES\"" >> /etc/rc.conf 

echo -e "\033[33mConfiguring automount\033[0m"
echo -e "\033[32mDone\033[0m"
echo -e "USERMOUNT=YES\nATIME=NO\nREMOVEDIRS=YES\nFM=\"pcmanfm\"\nUSER=woland\nENCODING=en_US.UTF-8" >> /usr/local/etc/automount.conf

#Xinit
echo -e "\033[33mConfiguring xinitrc\033[0m"
echo -e "\033[32mDone\033[0m"
echo -e "xsetroot -cursor_name left_ptr\nxset r rate 250 60\nxset b off\nxmodmap -e \"keycode 147 = Super_L\"\nfeh --bg-scale ~/freebsd-wallpaper.jpg\nexec icewm\n" >> /home/$normal/.xinitrc

#Shell
echo -e "\033[33mConfiguring shellrc\033[0m"
echo -e "\033[32mDone\033[0m"
echo -e "export TERM=xterm-256color\nexport VISUAL=vim\nexport LANG=en_US.UTF-8\nexport LANGUAGE=en_US.UTF-8\nexport GTK2_RC_FILES="$HOME/.gtkrc-2.0"\nexport BROWSER=firefox\nexport QT_QPA_PLATFORMTHEME=\"qt5ct\"\nMOZ_X11_EGL=1\nexport MM_CHARSET=UTF-8\nexport LC_ALL=en_US.UTF-8" >> /home/$normal/.$nshell"rc"

#Installing PKGs
echo -e "\033[35mPreparing to Download Essential Packages...\033[0m"
pkg install -y automount fusefs-exfat fusefs-ext2 fusefs-gphotofs fusefs-hfsfuse fusefs-jmtpfs fusefs-ntfs dbus papirus-icon-theme xviewer feh pcmanfm vim-X11 wget curl bash py39-ranger htop pfetch git doas xorg icewm w3m w3m-img exa scrot firefox menumaker
echo -e "\033[32mDone\033[0m"

#Load fuse
echo -e "\033[35mLoading the fuse module and restarting devd\033[0m"
kldload fusefs
/etc/rc.d/devd restart
echo -e "\033[32mDone\033[0m"

#Enable Dbus
echo -e "\033[35mEnabling dbus\033[0m"
sysrc dbus_enable="YES"
echo -e "\033[32mDone\033[0m"

#Clone the repo
echo -e "\033[35mCloning git repo for icewm files\033[0m"
git clone https://github.com/wolandark/FreeBSD_Post_Install FreeBSD_Post_Install
echo -e "\033[32mDone\033[0m"
echo -e "\033[32mMoving .icewm directory to your normal user's home. Should this fail, you Must manually move the .icewm directory to your normal user's home directory\033[0m"

#Moving Files and Directories 
mkdir -p /home/$normal/.icewm 
mv FreeBSD_Post_Install/.icewm/* /home/$normal/.icewm/
mv FreeBSD_Post_Install/freebsd-wallpaper.jpg /home/$normal/freebsd-wallpaper.jpg

echo -e "\033[32mPreparing to reboot, you should be able to startx and land in icewm\033[0m"
echo -e "\033[32mChanging owenership of files\033[0m"
echo -e "\033[32mDone\033[0m"

chown $normal:$normal /home/$normal/.icewm/
chown $normal:$normal /home/$normal/.xinitrc

reboot
