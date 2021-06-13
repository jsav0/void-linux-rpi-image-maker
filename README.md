# RPi Void Linux image maker by wfnintr
a script to automate the building of custom void linux images catered to the Raspberry Pi  
This tool uses drist to run the build on a remote build server and copy the image back to the local client

---

**rpi4** - minimal image  
deviates only slightly from the default void-linux image in that:  
- sudo is replaced with doas  
- dhcpcd, chronyd, and sshd enabled on boot  
- ssh root login is permitted  
- hostname is set to the raspberry pi's serial number  

---

**rpi4-lxd** - lxd appliance  
deviates from the default void-linux image in that:
- sudo is replaced with doas
- LXD and ZFS are installed
- dhcpcd, chronyd, sshd and lxd enabled on boot
- new user is added: 'void' and joined to group: 'lxd'
- passwords are disabled for 'void' and 'root'
- ssh login is permitted for both users by way of placing your pubkey in files/ssh_keys/ before running make.
- hostname is set to the raspberry pi's serial number


## Makefile Usage
```
Usage:
  make <target>

Targets:
  - rpi3, rpi4, rpi3-lxd, rpi4-lxd

Examples:
  make rpi3      # rpi3 minimal image
  make rpi4      # rpi4 minimal image
  make rpi3-lxd  # rpi3 LXD appliance image
  make rpi4-lxd  # rpi4 LXD appliance image
  ```
