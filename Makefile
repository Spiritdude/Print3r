NAME=Print3r
VERSION=0.0.6
#DEST_BIN=~/bin/
DEST_BIN=/usr/local/bin
CMD=print3r

all::
	@echo "make requirements install deinstall"

requirements::
	sudo cpan Time::HiRes Device::SerialPort
	sudo apt install libgd-perl

install::
	sudo cp ${CMD} ${DEST_BIN}/

deinstall::
	sudo rm -f ${DEST_BIN}/${CMD}

# ---------------------------------------------------------------------------------------------------------------
# -- developer(s) only:

edit::
	dee4 print3r Makefile README.md LICENSE

backup::
	cd ..; tar cfz ${NAME}-${VERSION}.tar.gz "--exclude=*/Cura/*" "--exclude=*/CuraEngine/*" "--exclude=*/Slic3r/*" ${NAME}; mv ${NAME}-${VERSION}.tar.gz ~/Backup; scp ~/Backup/${NAME}-${VERSION}.tar.gz backup:Backup/

change::
	git commit -am "..."

pull::
	git pull

push::
	git push
