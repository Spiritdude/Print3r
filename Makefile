all::
	@echo "make requirements install deinstall"

requirements::
	sudo cpan Device::Serial

install::
	cp gcodetool ~/bin/

deinstall::
	rm -f ~/bin/gcodetool	
