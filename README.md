# RPi Void Linux image maker by wfnintr
a script to automate the building of custom void linux images catered to the Raspberry Pi  
This tool uses drist to run the build on a remote build server

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
