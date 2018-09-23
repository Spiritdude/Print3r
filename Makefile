all::
	@echo "make requirements install deinstall"

requirements::
	sudo cpan Time::HiRes Device::SerialPort

install::
	cp gcodetool ~/bin/

deinstall::
	rm -f ~/bin/gcodetool	

edit::
	dee4 gcodetool Makefile
