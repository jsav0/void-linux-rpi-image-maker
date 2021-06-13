# RPi Void Linux image maker by wfnintr
a script to automate the building of custom void linux images catered to the Raspberry Pi  
This tool uses drist to run the build on a remote build server and copy the image back to the local client

---

**rpi4-upstream** - default official image

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
  echo "SERVER=void@build-server" > config.mk

Or just specify the build server on the command line like so:
  make <target> SERVER=void@build-server

Usage:
  make <target>

Targets:
  - rpi4-upstream, rpi4-minimal, rpi4-lxd

Examples:
  make rpi4-upstream	# rpi4 official upstream image
  make rpi4-minimal	# rpi4 minimal image
  make rpi4-lxd		# rpi4 LXD appliance image

Note: SSH keys inside of ./ssh_keys will be embedded into images when applicable
```
