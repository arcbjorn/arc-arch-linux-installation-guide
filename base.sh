#!/bin/bash

# set system time
ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen

# set keyboard layout
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "arch" >> /etc/hostname

# set local host address
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts

# set root password
echo root:password | chpasswd

# install packages for booting
pacman -S grub grub-btrfs efibootmgr

# install packages for network
pacman -S networkmanager network-manager-applet wpa_supplicant

# install DOS filesystem utilities & disk tools
pacman -S dialog mtools dosfstools

# install shell dialog box, arch mirrorlist, service discovery tools
pacman -S dialog reflector avahi

# install linux system group packages
pacman -S base-devel linux-headers

# install user directories & command line tools
pacman -S xdg-user-dirs xdg-utils

# install additional support network & dns packages
pacman -S nfs-utils inetutils dnsutils openbsd-netcat iptables-nft ipset nss-mdns

# install bluetooth protocol stack packages
pacman -S bluez bluez-utils

# install support packages & drivers for printers
# pacman -S cups hplip

# install sound system packages
pacman -S alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack sof-firmware pavucontrol

# install SSH protocol support & sync packages
pacman -S openssh rsync

# install support for  battery, power, and thermals
pacman -S acpi acpi_call tlp acpid

# install support for Virtual machines & emulators
# virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2

# install firewall support
pacman -S firewalld

# install GRUB as bootloader
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# install paru
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
cd ..

# install a Nerd Font patched version of JetBrains Mono
paru -S nerd-fonts-jetbrains-mono

# For Discrete Graphics Cards
# pacman -S --noconfirm xf86-video-amdgpu
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

# enable services to always start at system boot
systemctl enable NetworkManager
# systemctl enable bluetooth
# systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable tlp
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid

# add user and give priviliges
useradd -m example-user
echo example-user:password | chpasswd
usermod -aG libvirt example-user

echo "example-user ALL=(ALL) ALL" >> /etc/sudoers.d/example-user


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
