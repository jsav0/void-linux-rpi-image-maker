#!/bin/sh
#n0
# file: post-script
# description: performs additional configuration necessary before booting 
# author: wfnintr
#a110w

# Enable dhcpcd, chronyd, sshd as a service
chroot "$1" sh -c "ln -s /etc/sv/dhcpcd /etc/runit/runsvdir/default"
chroot "$1" sh -c "ln -s /etc/sv/ntpd /etc/runit/runsvdir/default"
chroot "$1" sh -c "ln -s /etc/sv/sshd /etc/runit/runsvdir/default"

# Replace sudo with doas
echo "ignorepkg=sudo" > "$1/usr/share/xbps.d/xbps-ignore.conf"
ln -sf $1/bin/doas $1/bin/sudo
chmod 4755 "$1/bin/sudo"
echo "permit nopass keepenv void" > "$1/etc/doas.conf"
chroot "$1" sh -c "xbps-remove -y sudo"

# Enable root ssh login 
sed -i "$1/etc/ssh/sshd_config" -e 's|^#\(PermitRootLogin\) .*|\1 yes|g'

# Add ssh pubkey to the root account
mkdir -p "$1/root/.ssh"
cat ../ssh_keys/*.pub > "$1/root/.ssh/authorized_keys"

# Set hostname to the pi's serial number
cat >> "$1/etc/runit/core-services/005-hostname.sh" << EOF
sed 's/^10*//' /sys/firmware/devicetree/base/serial-number > /etc/hostname
EOF
