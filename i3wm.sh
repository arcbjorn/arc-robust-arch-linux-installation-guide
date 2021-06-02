#!/bin/bash

sudo timedatectl set-ntp true
sudo hwclock --systohc

sudo reflector -a 12 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syy

sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --reload
# sudo virsh net-autostart default

echo "MAIN PACKAGES FOR i3wm"

# install DE packages from offical repos:

# xorg display server
sudo pacman -S --noconfirm xorg
# window manager i3wm (i3-gaps fork)
sudo pacman -S --noconfirm i3-gaps
# login manager
sudo pacman -S --noconfirm lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
# window compositor
sudo pacman -S --noconfirm picom
# app launcher & dynamic menu
sudo pacman -S --noconfirm rofi
# system notifications manager
sudo pacman -S --noconfirm dunst
# theme customization, colour generator, wallpaper manager
sudo pacman -S --noconfirm lxappearance python-pywal nitrogen
# terminal emulator, file manager, password manager
sudo pacman -S --noconfirm kitty pcmanfm-qt pass
# CLI to display system specs
sudo pacman -S --noconfirm neofetch

# remove default lockscreen for i3wm
sudo pacman -R --noconfirm i3lock

# install DE packages from AUR:

# status bar & lockscreen packages
paru -S --noconfirm polybar betterlockscreen
# web browser, system backup & restore tool
paru -S --noconfirm firefox-nightly timeshift timeshift-autosnap

# enable login screen on boot
sudo systemctl enable lightdm

# Default Configuration

mkdir -p .config/{dunst,i3,rofi,polybar}

install -Dm755 /etc/xdg/picom.conf ~/.config/picom.conf
install -Dm755 /usr/share/doc/betterlockscreen/examples/betterlockscreenrc ~/.config/betterlockscreenrc

install -Dm755 /etc/dunst/dunstrc ~/.config/dunst/dunstrc
# i3 config: run i3-config-wizard or edit manually
install -Dm755 /etc/i3/config ~/.config/i3/config
# rofi config: generate config or check the config commands: rofi -dump-config
rofi -dump-config > ~/.config/rofi/config.rasi
# kitty config: ~/.config/kitty/kitty.conf
install -Dm755 /usr/share/doc/polybar/config ~/.config/polybar/config

# manual config for lightdm: /etc/lightdm/lightdm.conf.d/50-myconfig.conf
# otherwise lightdm-gtk-greeter-settings preferred
# example:
# [Seat:*]
# user-session=mysession

printf "\e[1;32mCHANGE NECESSARY FILES BEFORE REBOOT, THEN RUN REBOOT COMMAND\e[0m"
