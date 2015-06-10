include ./CONFIG
DEPENDS=
PACKAGE_DIR?=${PWD}

all:
	rm -rf control data
	${MAKE} clean
	mkdir -p data
	cp -a root/* data
	${MAKE} control
	${MAKE} deb

include ../deb_hand.mak
