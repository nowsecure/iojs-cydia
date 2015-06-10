iojs-cydia
==========

This repository contains the scripts necessary to build the Cydia packages of io.js.

io.js is an npm compatible platform originally based on Node.js™.

Dependencies
------------

To build this you need a Mac with the command line tools and `fakeroot` (it's in brew!)

Usage
-----

Build iojs and iojs-npm packages:

```
$ make
mv */*.deb .
```

Clean build data

```
$ make clean
```

Author
------

Sergi Alvarez Capilla <pancake@nowsecure.com>
