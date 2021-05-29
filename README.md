# Arch linux installation guide

Minimal archlinux installation with latest (2021) tools:

- ButterFS filesystem
- ZRAM
- Pipewire
- Wayland

1. Boot from USB drive with Arch ISO

2. Prepare the disk (partitions)

```bash
# check the disks
lsblk

# partition the disk - create GPT Labels
gdisk /dev/***

# First Partition for EFI
# choose new command:
n
# choose default partition number
# choose default First Sector memory
# choose Last Sector memory:
+300M
# enter the EFI partition code:
ef00

# Second Partition for main SSD storage
# choose new command
n
# choose default partition number
# choose default First Sector memory
# choose Last Sector memory:
(remaining SSD space - 2 GB)G
# choose default partition type (Linux Filesystem)

# Choose "write" command to overwrite exiting partitions:
w
```

3. Format partitions

```bash
# make fat32 filesystem for EFI
mkfs.vfat /dev/***1
# make butterFS filesystem for main storage
mkfs.btrfs  /dev/***2
```

3. ButterFS configuration

```bash
# mount main partition - root subvolume
mount  /dev/***2 /mnt

cd /mnt
# make btrFS subvolume for root subvolume
btrfs subvolume create @
# make btrFS subvolume for home subvolume
btrfs subvolume create @home
# make btrFS subvolume for var subvolume
btrfs subvolume create @var

cd
# mount main partition - root subvolume
umount /mnt

# mount root subvolume
mount -o noatime, compress=zstd, space_cache,discard=async,subvol=@ /dev/***2 /mnt

# directories var, home & var
mkdir /mnt/{boot,home,var}

# mount home & var subvolumes
mount -o noatime, compress=zstd, space_cache,discard=async,subvol=@home /dev/***2 /mnt/home

mount -o noatime, compress=zstd, space_cache,discard=async,subvol=@var /dev/***2 /mnt/var
```

4. Mount EFI partition

```bash
mount /dev/***1 /mnt/boot
```

5. Install the base system

```bash
pacstrap /mnt base linux linux-firmware git wget vim intel-ucode btrfs-progs
```

6. Generate filesystem table

```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

7. Make new root directory with all mounts needed

```bash
# detach from main filesystem and process tree
arch-chroot /mnt

# check the fs & table
ls
cat /etc/fstab
```

8. Run base archlinux system intall

```bash
# give exec permissions to script
git clone https://github.com/arcbjorn/arc-arch-linux-installation-guide
cd arc-arch-linux-installation-guide
chmod +x base.sh

# run from root filesystem
cd /
./arc-arch-linux-installation-guide/base.sh

# choose xdr-desktop-portal-wlr (to use with Sway)
```

9. Check system init config

```bash
vim /etc/mkinitcpio.conf
# if butterFS used on 2 disks - put "btrfs" parameter in MODULES
# if amd or nvidia card is used - put "amdgpu" or "nvidia" parameters in MODULES accordingly

# if config was changed, recreate initramfs:
mkinitcpio -p linux
```

10. Finish base packages installation

```bash
exit
umount -a
reboot
```

11. Configure ZRAM (used for SWAP)

```bash
paru -S zramd
sudo systemctl enable --now zramd.service

# check the block devices table
lsblk
```

12. Install Desktop tools

```bash
# copy the guide to the filesystem root
cp -r /arc-arch-linux-installation-guide .
```
