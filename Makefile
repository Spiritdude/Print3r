NAME=Print3r
VERSION=0.0.9
#DEST_BIN=~/bin/
DEST_BIN=/usr/local/bin
CMD=print3r

all::
	@echo "make requirements install deinstall"

requirements::
	sudo cpan Time::HiRes Device::SerialPort XML::Simple JSON
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
	git push -u origin master

examples::
	./print3r --fill-density=0 --output=examples/cube.png render Parts/cube.scad
	./print3r --fill-density=0 --scale=50mm --output=examples/cube-scaled1.png render Parts/cube.scad
	./print3r --fill-density=0 --scale=10mm,20mm,100mm --output=examples/cube-scaled2.png render Parts/cube.scad
	./print3r --fill-density=0 --output=examples/benchy.png render Parts/3DBenchy.stl
	./print3r --fill-density=0 --scale=0,0,150mm --output=examples/benchy-scaled.png render Parts/3DBenchy.stl
