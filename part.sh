parted /dev/sda "mklabel msdos yes"
parted /dev/sda "mkpart primary ext4 1MiB 100%"
parted /dev/sda "set 1 boot on"

mkfs.ext4 /dev/sda1
mount /dev/sda1 /mnt 
pacstrap -i /mnt base base-devel
genfstab -U /mnt > /mnt/etc/fstab

#TODO
#This will probably be a problem for you when since it is only english. Working on a better solution with user interaction.
cp /etc/locale.gen /mnt/etc/
arch-chroot /mnt /bin/bash "locale-gen"
echo 'LANG=en_US.UTF-8' > /mnt/etc/locale.conf
arch-chroot /mnt /usr/bin/ln -s /usr/share/zoneinfo/Africa/Johannesburg /etc/localtime
arch-chroot /mnt mkinitcpio -p linux
arch-chroot /mnt pacman -S --noconfirm grub
arch-chroot /mnt grub-install --target=i386-pc --recheck /dev/sda
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
arch-chroot /mnt echo virtual > /etc/hostname
arch-chroot /mnt pacman -S --noconfirm networkmanager
arch-chroot /mnt systemctl enable NetworkManager.service
arch-chroot /mnt pacman -S --noconfirm virtualbox-guest-utils
arch-chroot /mnt modprobe -a vboxguest vboxsf vboxvideo
arch-chroot /mnt systemctl enable vboxservice
arch-chroot /mnt pacman -S --noconfirm xfce4

arch-chroot /mnt useradd -m -G wheel -s /bin/bash YourUsername





