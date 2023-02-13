# FreeBSD_Post_install

This is my personal FreeBSD post install script
it downloads the following packaged and performs the following tasks

<h5>Installs the following packages:</h5><br>
automount<br> fusefs-exfat<br> fusefs-ext2<br> fusefs-gphotofs<br> fusefs-hfsfuse<br> fusefs-jmtpfs<br> fusefs-ntfs<br> dbus<br> papirus-icon-theme<br> xviewer<br> feh<br> pcmanfm <br>vim-X11<br> wget <br>curl <br>bash<br> py39-ranger<br> htop<br> pfetch<br> git<br> doas<br> xorg<br> icewm<br> w3m<br> w3m-img<br> exa<br> scrot<br> 

<h5>adds the following lines to </h5>[/usr/local/etc/doas.conf]()
```
permit nopass keepenv :$USER
permit nopass :$USER cmd reboot
permit nopass :$USER cmd poweroff
permit :wheel 
```

adds the following lines to [/boot/loader.conf]()
```
echo -e "autoboot_delay=3
loader_logo="beastie
coretemp_load"YES"
tmpfs_load="YES"
aio_load="YES"
fuse_load="YES"
hw.syscond.bell=0 
```

following lines to [/etc/sysctl.conf]()
```
vfs.usermount=1
kern.shed_threshold=4
kern.sched.preempt_thresh=64
kern.ipc.shm_allow_removed=1
kern.vt.enable_bell=0
```

following lines to [/etc/rc.conf]()
```
ntpd_flags="-g"
fuse_enable="YES" 
```

following lines to[ /usr/local/etc/automount.conf]()
```
echo -e USERMOUNT=YES
ATIME=NO
REMOVEDIRS=YES
FM="pcmanfm"
USER=woland
ENCODING=en_US.UTF-8
```

following lines to [ /home/$USER/.xinitrc]()
```
xsetroot -cursor_name left_ptr
xset r rate 250 60
xset b off
xmodmap -e "keycode 147 = Super_L"
export LC_ALL=en_US.UTF-8
export MM_CHARSET=UTF-8 
```

following lines to [/home/$USER/.bashrc]()
```
export TERM=xterm-256color
export VISUAL=vim
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export BROWSER=qutebrowser
export QT_QPA_PLATFORMTHEME="qt5ct"
MOZ_X11_EGL=1  
```

Loads the following kernel module:
```
fusefs
```

Enables the following service:
```
dbus
```

