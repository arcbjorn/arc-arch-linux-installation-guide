#!/bin/bash

sudo timedatectl set-ntp true
sudo hwclock --systohc

sudo reflector -c Russia -a 12 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syy

sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --reload
# sudo virsh net-autostart default

echo "MAIN PACKAGES FOR SWAY"

# install Window Manager Sway, App Launcher Wofi, App for theme customization, Status Bar, Terminal emulator
sudo pacman -S sway wofi lxappearance waybar kitty

# install Login Manager LY
paru -S --noconfirm ly-git

# enable login screen on boot
sudo systemctl enable ly.service

mkdir -p .config/{sway,dunst,ly,waybar,kitty}

cp /etc/sway/config ~/.config/sway/
cp /etc/dunst/dunstrc ~/.config/dunst/
cp /etc/ly/config.ini ~/.config/ly/

touch~/.config/waybar/config
touch ~/.config/kitty/kitty.conf

# install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc
# install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc

printf "\e[1;32mCHANGE NECESSARY FILES BEFORE REBOOT\e[0m"
