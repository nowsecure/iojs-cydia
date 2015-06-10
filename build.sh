#!/bin/sh

PREFIX="/usr"
NAME="iojs-ios"
DESTDIR="/tmp/$NAME"

if [ ! -f src/node.cc ]; then
	echo run this script from iojs root directory
	exit 1
fi

if [ -z "${CPU}" ]; then
	# Build for 32bit ARM by default
	CPU=arm
	#CPU=arm64
fi

case "$CPU" in
arm)
	CPUC=armv7
	;;
arm64)
	CPUC=arm64
	;;
esac

export CC="xcrun --sdk iphoneos gcc -arch ${CPUC}"
export CXX="xcrun --sdk iphoneos g++ -arch ${CPUC} -std=c++11"
export LINK="xcrun --sdk iphoneos g++ -arch ${CPUC}"

export IPHONEOS_DEPLOYMENT_TARGET=8.3


# fix build
cp -f deps/cares/config/darwin/ares_config.h deps/cares/include/

# build iojs
./configure --prefix=/usr --dest-os=ios --dest-cpu=${CPU} --without-snapshot \
	--openssl-no-asm --without-dtrace --without-perfctr --without-etw || exit 1
make -j4 || exit 1

# install iojs and npm
make install DESTDIR="${DESTDIR}" || exit 1

cd $DESTDIR
tar czvf ../$NAME.tar.gz *
