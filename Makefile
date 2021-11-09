NAME=Print3r
VERSION=0.3.12
#DEST_BIN=~/bin/
DEST_BIN=/usr/bin
DEST_SHARE=/usr/share
CMD=print3r
NICK=print3r
CPAN=cpan

all::
	@echo "make requirements install deinstall"
	@echo "-- on low RAM systems use 'apt install cpanminus' and then 'make CPAN=cpanm requirements'"

requirements::
	sudo apt install libexpat-dev libcurses-perl libncurses5-dev libreadline-dev
	sudo ${CPAN} File::Which IO::Zlib Time::HiRes Device::SerialPort XML::Simple JSON IO::Termios Term::ReadLine::Gnu Linux::Termios2 Algorithm::BinPack::2D 
	sudo apt install libgd-perl ser2net socat slic3r
	sudo apt install yagv

install::
	sudo cp ${CMD} ${DEST_BIN}/
	mkdir -p ${HOME}/.config/${NICK}; cd ${HOME}/.config/${NICK}; mkdir -p printer macro macro/filament slicer gconsole gconsole/commands 
	sudo mkdir -p ${DEST_SHARE}/${NICK}
	cd settings; tar cf - printer/*.ini macro/*.ini macro/filament/*.ini slicer/*.json slicer/*/base.ini slicer/*/map.ini slicer/*/*.def.json gconsole | (cd ${DEST_SHARE}/${NICK}/; sudo tar xf -)

deinstall::
	sudo rm -f ${DEST_BIN}/${CMD}

# ---------------------------------------------------------------------------------------------------------------
# -- developer(s) only:

edit::
	dee4 print3r Makefile README.md LICENSE settings/slicer/*.json settings/*/*.ini settings/*/*/*.ini settings/gconsole/commands/*

backup::
	cd ..; tar cfz ${NAME}-${VERSION}.tar.gz "--exclude=*/slicers/*" ${NAME}; mv ${NAME}-${VERSION}.tar.gz ~/Backup; scp ~/Backup/${NAME}-${VERSION}.tar.gz backup:Backup/

backup-settings::
	cd ~/; tar cfz ${NAME}-Config-`date +%F`.tar.gz .config/print3r; mv ${NAME}-Config-`date +%F`.tar.gz ~/Backup/; scp ~/Backup/${NAME}-Config-`date +%F`.tar.gz backup:Backup/

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

logdb::	logdb-setup
	sqltk --uri=pg://print3r --input=jsonl --filter=ascii --keys=@ -- "insert into parts (data) values (?)" < ~/.print3r/log.json

logdb-setup::
	createdb print3r
	sqltk --uri=pg://print3r "create table parts ( data jsonb )"

logdb-test::
	sqltk --uri=pg://print3r --output=json "select data from parts where data->'uid' = ?" '"...."'
	sqltk --uri=pg://print3r --output=json "select data from parts where data->'file_list' @> ?" '"cube.stl"'

stuffdb::	stuffdb-setup
	sqltk --uri=pg://mystuff --input=jsonl --filter=ascii --keys=@ -- "insert into print3r (data) values (?)" < ~/.print3r/log.json

stuffdb-setup::
	sqltk --uri=pg://mystuff "drop table print3r"
	sqltk --uri=pg://mystuff "create table print3r ( data jsonb )"


