NAME=Print3r
VERSION=0.1.6
#DEST_BIN=~/bin/
DEST_BIN=/usr/local/bin
DEST_SHARE=/usr/share/
CMD=print3r

all::
	@echo "make requirements install deinstall"

requirements::
	sudo cpan Time::HiRes Device::SerialPort XML::Simple JSON Algorithm::BinPack::2D
	sudo apt install libgd-perl yagv

install::
	sudo cp ${CMD} ${DEST_BIN}/
	mkdir -p ${HOME}/.config/print3r; cd ${HOME}/.config/print3r; mkdir printer macro macro/filament slicer
	sudo mkdir -p ${DEST_SHARE}/print3r
	cd settings; tar cf - printer/*.ini macro/*.ini macro/filament/*.ini slicer/*/base.ini slicer/*/map.ini slicer/*/*.def.json | (cd ${DEST_SHARE}/print3r/; tar xf -)

deinstall::
	sudo rm -f ${DEST_BIN}/${CMD}

# ---------------------------------------------------------------------------------------------------------------
# -- developer(s) only:

edit::
	dee4 print3r Makefile README.md LICENSE settings/*/*.ini gconsole/commands/*

backup::
	cd ..; tar cfz ${NAME}-${VERSION}.tar.gz "--exclude=*/slicers/*" ${NAME}; mv ${NAME}-${VERSION}.tar.gz ~/Backup; scp ~/Backup/${NAME}-${VERSION}.tar.gz backup:Backup/

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

