#!/bin/sh
#n0
# file: post-script
# description: performs additional configuration necessary before booting 
# author: wfnintr
#a110w

# Enable dhcpcd, ntpd, sshd, lxd as a service
chroot "$1" sh -c "ln -s /etc/sv/lxd /etc/runit/runsvdir/default"
chroot "$1" sh -c "ln -s /etc/sv/dhcpcd /etc/runit/runsvdir/default"
chroot "$1" sh -c "ln -s /etc/sv/ntpd /etc/runit/runsvdir/default"
chroot "$1" sh -c "ln -s /etc/sv/sshd /etc/runit/runsvdir/default"

# Add a new user, disable password
chroot "$1" sh -c "useradd void"
chroot "$1" sh -c "usermod -aG lxd void"
chroot "$1" sh -c "passwd -dl void && passwd -dl root"

# Replace sudo with doas
echo "ignorepkg=sudo" > "$1/usr/share/xbps.d/xbps-ignore.conf"
ln -sf $1/bin/doas $1/bin/sudo
chmod 4755 "$1/bin/sudo"
echo "permit nopass keepenv void" > "$1/etc/doas.conf"
chroot "$1" sh -c "xbps-remove -y sudo"

# Enable root ssh login and disable password authentication
sed -i "$1/etc/ssh/sshd_config" -e 's|^#\(PermitRootLogin\) .*|\1 yes|g'
sed -i "$1/etc/ssh/sshd_config" -e 's|^#\(PasswordAuthentication\) .*|\1 no|g'

# Add ssh pubkey to the user and root accounts
mkdir -p "$1/home/void/.ssh"
cat ../ssh_keys/*.pub > "$1/home/void/.ssh/authorized_keys"
mkdir -p "$1/root/.ssh"
cat ../ssh_keys/*.pub > "$1/root/.ssh/authorized_keys"

# Set hostname to the pi's serial number
cat >> "$1/etc/runit/core-services/005-hostname.sh" << EOF
sed 's/^0*//' /sys/firmware/devicetree/base/serial-number > /etc/hostname
EOF
