NAME=Print3r
VERSION=0.0.3

all::
	@echo "make requirements install deinstall"

requirements::
	sudo cpan Time::HiRes Device::SerialPort

install::
	cp gcodetool ~/bin/

deinstall::
	rm -f ~/bin/gcodetool	

edit::
	dee4 print3r Makefile

backup::
	cd ..; tar cfz ${NAME}-${VERSION}.tar.gz ${NAME}; mv ${NAME}-${VERSION}.tar.gz ~/Backup; scp ~/Backup/${NAME}-${VERSION}.tar.gz backup:Backup/
