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

# install DE packages from offical repos:

# Window Manager Sway
sudo pacman -S --noconfirm sway
# App Launcher
sudo pacman -S --noconfirm wofi
# Theme customization package
sudo pacman -S --noconfirm lxappearance qt5ct
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
# Compatibility layer between Qt and wayland
sudo pacman -S --noconfirm qt5-wayland
# Web Browser
sudo pacman -S --noconfirm firefox-developer-edition

# install paru
pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
cd ..

# install DE packages from AUR:

# Screenlock
# Login Manager
# System backup & restore tool
# Terminal emulator

paru -S --noconfirm swaylock-effects ly timeshift timeshift-autosnap foot

# enable login screen on boot
sudo systemctl enable ly.service
sudo systemctl disable getty@tty2.service

# Default Configuration

mkdir -p .config/{sway,dunst,waybar,wofi}

install -Dm755 /etc/sway/config ~/.config/sway/config
install -Dm755 /etc/dunst/dunstrc ~/.config/dunst/dunstrc
install -Dm755 /usr/share/foot/foot.ini ~/.config/foot/foot.ini

touch ~/.config/waybar/config
touch ~/.config/wofi/config

# config for ly: /etc/ly/config.ini

# install a Nerd Font patched version of JetBrains Mono
paru -S nerd-fonts-jetbrains-mono

printf "\e[1;32mCHANGE NECESSARY FILES BEFORE REBOOT, THEN RUN REBOOT COMMAND\e[0m"
