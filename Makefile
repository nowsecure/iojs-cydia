IOJS_VERSION=2.2.2
IOJS=iojs-$(IOJS_VERSION)
IOJS_NPM=iojs-npm-$(IOJS_VERSION)

ROOT=$(shell pwd)/root

all: $(IOJS)/root $(IOJS_NPM)/root
	$(MAKE) -C $(IOJS)
	$(MAKE) -C $(IOJS_NPM)

$(IOJS)/root:
	mkdir -p $(IOJS)/root/usr/bin
	cp -a $(ROOT)/usr/bin/iojs $(IOJS)/root/usr/bin
	cp -a $(ROOT)/usr/bin/node $(IOJS)/root/usr/bin
	mkdir -p $(IOJS)/root/usr/share/man/man1
	cp -a $(ROOT)/usr/share/man/man1/iojs.1 $(IOJS)/root/usr/share/man/man1
	mkdir -p $(IOJS)/root/usr/share/systemtap/tapset
	cp -a $(ROOT)/usr/share/systemtap/tapset/node.stp \
		$(IOJS)/root/usr/share/systemtap/tapset

$(IOJS_NPM)/root:
	cp -a $(ROOT)/* $(IOJS_NPM)/root/
	rm -f $(IOJS_NPM)/root/usr/bin/iojs
	rm -f $(IOJS_NPM)/root/usr/bin/node
	rm -rf $(IOJS_NPM)/root/usr/share
	cd $(IOJS_NPM) ; tar czvf ../iojs-ios.tar.gz *
	rm -rf $(IOJS_NPM)/root/*
	mkdir -p $(IOJS_NPM)/root/private/var/mobile/
	mv $(ROOT)/iojs-ios.tar.gz \
		$(IOJS_NPM)/root/private/var/mobile/

$(ROOT):
	git clone git@github.com:/nowsecure/io.js
	cd io.js ; git checkout ios ; ./ios-build.sh
	mkdir -p $(ROOT)
	mv /tmp/iojs-ios $(ROOT)
