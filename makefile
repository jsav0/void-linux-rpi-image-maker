-include config.mk

RPI4_UPSTREAM_DIR	= rpi4-upstream
RPI4_MINIMAL_DIR	= rpi4-minimal
RPI4_LXD_DIR		= rpi4-lxd-appliance

SSH_KEYS := $(shell ls ssh_keys/*.pub 2>/dev/null)

usage: 
	@echo "RPi Void Linux image maker by wfnintr"
	@echo "-------------------------------------"
	@echo "This tool uses drist to run the build on a remote server"
	@echo "and copy the image back to the local client"
	@echo ""
	@echo "Tell make what build server to use like so: "
	@echo "  echo \"SERVER=void@build-server\" > config.mk"
	@echo ""
	@echo "Or just specify the build server on the command line like so: "
	@echo "  make <target> SERVER=void@build-server"
	@echo ""
	@echo "Usage:"
	@echo "  make <target>"
	@echo ""
	@echo "Targets:"
	@echo "  - rpi4-upstream, rpi4-minimal, rpi4-lxd"
	@echo ""
	@echo "Examples:"
	@echo "  make rpi4-upstream	# rpi4 official upstream image"
	@echo "  make rpi4-minimal	# rpi4 minimal image"
	@echo "  make rpi4-lxd		# rpi4 LXD appliance image"
	@echo ""	
	@echo "Note: SSH keys inside of ./ssh_keys will be embedded into images when applicable"

rpi4-upstream: 
	cd $(RPI4_UPSTREAM_DIR) && drist -p -s $(SERVER)
rpi4-minimal: 
	cd $(RPI4_MINIMAL_DIR) && drist -p -s $(SERVER)
rpi4-lxd: 
	-cp $(SSH_KEYS) $(RPI4_LXD_DIR)/files/ssh_keys/
	cd $(RPI4_LXD_DIR) && drist -p -s $(SERVER)
	-rm -rf $(RPI4_LXD_DIR)/files/ssh_keys/

clean: 
	find . -type d -name 'ssh_keys' | xargs rm -rf
	-rm -rf results config.mk 

.PHONY: rpi4-upstream rpi4-minimal rpi4-lxd
