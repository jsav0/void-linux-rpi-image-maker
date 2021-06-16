# RPi Void Linux image maker by wfnintr
a script to automate the building of custom void linux images for the Raspberry Pi  
This tool uses my modified version of [drist]() to run the build on a remote build server and copy the image back to the local client.

---

**rpi3-upstream** - default official image

---

**rpi3-lxd** - lxd appliance (cluster node)
deviates from the default void-linux image in that:
- sudo is replaced with doas
- LXD and ZFS are installed
- dhcpcd, chronyd, sshd and lxd enabled on boot
- new user is added: 'void' and joined to group: 'lxd'
- passwords are disabled for 'void' and 'root'
- ssh login is permitted for both users by way of creating and placing your pubkey in ssh_keys/ before running make.
- hostname is set to the raspberry pi's serial number

---

**rpi4-upstream** - default official image

---

**rpi4-minmal** - minimal image  
deviates only slightly from the default void-linux image in that:  
- sudo is replaced with doas  
- dhcpcd, chronyd, and sshd enabled on boot  
- ssh root login is permitted  
- hostname is set to the raspberry pi's serial number  

---

**rpi4-lxd** - lxd appliance (cluster node)
deviates from the default void-linux image in that:
- sudo is replaced with doas
- LXD and ZFS are installed
- dhcpcd, chronyd, sshd and lxd enabled on boot
- new user is added: 'void' and joined to group: 'lxd'
- passwords are disabled for 'void' and 'root'
- ssh login is permitted for both users by way of creating and placing your pubkey in ssh_keys/ before running make.
- hostname is set to the raspberry pi's serial number


## Makefile Usage
```
RPi Void Linux image maker by wfnintr
-------------------------------------
This tool uses drist to run the build on a remote server
and copy the image back to the local client

Tell make what build server to use like so:
  echo "SERVER=user@build-server" > config.mk

Or just specify the build server on the command line:
  make <target> SERVER=user@build-server

The same goes for embedding ssh keys into images:
  make <target> SERVER=user@build-server SSH_KEY=~.ssh/id_ed25519.pub

Usage:
  make <target> <SERVER> [SSH_KEY]

Targets:
  - rpi3-upstream, rpi3-lxd
  - rpi4-upstream, rpi4-minimal, rpi4-lxd

Examples:
  make rpi4-upstream SERVER=void@192.34.56.171
  make rpi4-minimal SERVER=void@192.34.56.171
  make rpi4-lxd SERVER=void@192.34.56.171 SSH_KEY=~/.ssh/id_ed25519.pub
```
