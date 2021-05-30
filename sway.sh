#!/bin/bash

sudo timedatectl set-ntp true
sudo hwclock --systohc

sudo reflector -a 12 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syy

sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --reload
# sudo virsh net-autostart default

echo "MAIN PACKAGES FOR SWAY"

# install DE packages from AUR:

# Window Manager Sway (sway-borders fork)
# Login Manager
# Web Browser
# System backup & restore tool

paru -S --noconfirm sway-borders-git ly-git firefox-nightly timeshift timeshift-autosnap

# install DE packages from offical repos:

# App Launcher
# Theme customization package
# Theme color generator
# Status Bar
# File manager
# Password manager
# Terminal emulator
# CLI to display system specs
# System notifications manager

sudo pacman -S wofi lxappearance python-pywal waybar pcmanfm-qt pass foot neofetch dunst

# enable login screen on boot
sudo systemctl enable ly.service

mkdir -p .config/{sway,dunst,waybar,wofi}

cp /etc/sway/config ~/.config/sway/
cp /etc/dunst/dunstrc ~/.config/dunst/
cp /usr/share/foot/foot.ini ~/.config/foot/

touch ~/.config/waybar/config
touch ~/.config/wofi/config

# cp /etc/ly/config.ini ~/.config/ly/
# config for ly: /etc/ly/config.ini

# set environment variables to use Wayland
echo "QT_QPA_PLATFORM=wayland" >> /etc/environment
echo "MOZ_ENABLE_WAYLAND=1" >> /etc/environment
echo "MOZ_WEBRENDER=1" >> /etc/environment
echo "XDG_SESSION_TYPE=wayland" >> /etc/environment
echo "XDG_CURRENT_DESKTOP=sway" >> /etc/environment

printf "\e[1;32mCHANGE NECESSARY FILES BEFORE REBOOT, THEN RUN REBOOT COMMAND\e[0m"
