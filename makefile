-include config.mk

RPI3_UPSTREAM_DIR	= rpi3-upstream
RPI3_LXD_DIR		= rpi3-lxd-appliance

RPI4_UPSTREAM_DIR	= rpi4-upstream
RPI4_MINIMAL_DIR	= rpi4-minimal
RPI4_LXD_DIR		= rpi4-lxd-appliance

usage: 
	@echo "RPi Void Linux image maker by wfnintr"
	@echo "-------------------------------------"
	@echo "This tool uses drist to run the build on a remote server"
	@echo "and copy the image back to the local client"
	@echo ""
	@echo "Tell make what build server to use like so: "
	@echo "  echo \"SERVER=user@build-server\" > config.mk"
	@echo ""
	@echo "Or just specify the build server on the command line: "
	@echo "  make <target> SERVER=user@build-server"
	@echo ""
	@echo "The same goes for embedding ssh keys into images: "
	@echo "  make <target> SERVER=user@build-server SSH_KEY=~.ssh/id_ed25519.pub"
	@echo ""
	@echo "Usage:"
	@echo "  make <target> <SERVER> [SSH_KEY]"
	@echo ""
	@echo "Targets:"
	@echo "  - rpi3-upstream, rpi3-lxd"
	@echo "  - rpi4-upstream, rpi4-minimal, rpi4-lxd"
	@echo ""
	@echo "Examples:"
	@echo "  make rpi4-upstream SERVER=void@192.34.56.171"
	@echo "  make rpi4-minimal SERVER=void@192.34.56.171"
	@echo "  make rpi4-lxd SERVER=void@192.34.56.171 SSH_KEY=~/.ssh/id_ed25519.pub"

rpi3-upstream: 
	cd $(RPI3_UPSTREAM_DIR) && drist -p -s $(SERVER)
rpi3-lxd: 
	mkdir -p $(RPI3_LXD_DIR)/files/ssh_keys && cp $(SSH_KEY) $(RPI3_LXD_DIR)/files/ssh_keys/
	cd $(RPI3_LXD_DIR) && drist -p -s $(SERVER)
	-rm -rf $(RPI3_LXD_DIR)/files/ssh_keys/

rpi4-upstream: 
	cd $(RPI4_UPSTREAM_DIR) && drist -p -s $(SERVER)
rpi4-minimal: 
	cd $(RPI4_MINIMAL_DIR) && drist -p -s $(SERVER)
rpi4-lxd: 
	mkdir -p $(RPI4_LXD_DIR)/files/ssh_keys && cp $(SSH_KEY) $(RPI4_LXD_DIR)/files/ssh_keys/
	cd $(RPI4_LXD_DIR) && drist -p -s $(SERVER)
	-rm -rf $(RPI4_LXD_DIR)/files/ssh_keys/

clean: 
	find . -type d -name 'ssh_keys' | xargs rm -rf
	-rm -rf results config.mk 

.PHONY: rpi3-upstream rpi3-lxd rpi4-upstream rpi4-minimal rpi4-lxd
