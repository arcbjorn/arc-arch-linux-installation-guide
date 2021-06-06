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
# Screenlock
# Login Manager
# System backup & restore tool
# Terminal emulator

paru -S --noconfirm sway-borders-git swaylock-effects ly timeshift timeshift-autosnap foot

# install DE packages from offical repos:

# App Launcher
sudo pacman -S --noconfirm wofi
# Theme customization package
sudo pacman -S --noconfirm lxappearance
# Theme color generator
sudo pacman -S --noconfirm python-pywal
# Status Bar
sudo pacman -S --noconfirm waybar
# File manager
sudo pacman -S --noconfirm pcmanfm-qt
# Password manager
sudo pacman -S --noconfirm pass
# CLI to display system specs
sudo pacman -S --noconfirm neofetch
# System notifications manager
sudo pacman -S --noconfirm dunst
# Idle manager
sudo pacman -S --noconfirm swayidle
# Compatibility layer between xorg and wayland
sudo pacman -S --noconfirm xorg-xwayland
# Web Browser
sudo pacman -S --noconfirm firefox-developer-edition

sudo pacman -S wofi lxappearance python-pywal waybar pcmanfm-qt pass neofetch dunst swayidle xorg-xwayland 
firefox-developer-edition

# enable login screen on boot
sudo systemctl enable ly.service

# Default Configuration

mkdir -p .config/{sway,dunst,waybar,wofi}

install -Dm755 /etc/sway/config ~/.config/sway/config
install -Dm755 /etc/dunst/dunstrc ~/.config/dunst/dunstrc
install -Dm755 /usr/share/foot/foot.ini ~/.config/foot/foot.ini

touch ~/.config/waybar/config
touch ~/.config/wofi/config

# config for ly: /etc/ly/config.ini

# set environment variables to use Wayland
echo "QT_QPA_PLATFORM=wayland" >> /etc/environment
echo "MOZ_ENABLE_WAYLAND=1" >> /etc/environment
echo "MOZ_WEBRENDER=1" >> /etc/environment
echo "XDG_SESSION_TYPE=wayland" >> /etc/environment
echo "XDG_CURRENT_DESKTOP=sway" >> /etc/environment

printf "\e[1;32mCHANGE NECESSARY FILES BEFORE REBOOT, THEN RUN REBOOT COMMAND\e[0m"
