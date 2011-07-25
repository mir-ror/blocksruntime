API=posix
AR=/usr/bin/ar
BINDIR=$(PREFIX)/bin
CC=/usr/bin/cc
CFLAGS=
INCLUDEDIR=$(PREFIX)/include
INSTALL=/usr/bin/install
LDADD=
LDFLAGS=
LIBDIR=$(PREFIX)/lib
LN=/bin/ln
MANDIR=$(PREFIX)/share/man
PREFIX=/usr/local
SBINDIR=$(PREFIX)/sbin
TAR=/bin/tar
TARGET=linux
VERSION=0.1

default: all

all: libBlocksRuntime.so.0.0

check: all

clean:
	rm -f libBlocksRuntime.so.0.0

dist: all
	rm -f libBlocksRuntime-0.1.tar.gz
	rm -rf libBlocksRuntime-0.1
	mkdir libBlocksRuntime-0.1
	$(INSTALL) -m 755 configure libBlocksRuntime-0.1
	$(INSTALL) -m 644 config.yaml libBlocksRuntime-0.1
	$(INSTALL) -m 644 runtime.c data.c libBlocksRuntime-0.1
	$(INSTALL) -m 644 Block.h Block_private.h libBlocksRuntime-0.1
	$(INSTALL) -m 644 ChangeLog libBlocksRuntime-0.1
	tar cf libBlocksRuntime-0.1.tar libBlocksRuntime-0.1
	gzip libBlocksRuntime-0.1.tar
	rm -rf libBlocksRuntime-0.1

distclean: clean
	rm -f Makefile config.h

install: all
	$(INSTALL) -m 644 libBlocksRuntime.so.0.0 $(DESTDIR)$(LIBDIR)
	$(LN) -sf libBlocksRuntime.so.0.0 $(DESTDIR)$(LIBDIR)/libBlocksRuntime.so.0
	$(LN) -sf libBlocksRuntime.so.0.0 $(DESTDIR)$(LIBDIR)/libBlocksRuntime.so
	$(INSTALL) -m 644 Block.h $(DESTDIR)$(INCLUDEDIR)
	$(INSTALL) -m 644 Block_private.h $(DESTDIR)$(INCLUDEDIR)

libBlocksRuntime.so.0.0: runtime.c data.c
	$(CC) -o $@ -DBlocksRuntime_EXPORTS -DHAVE_SYNC_BOOL_COMPARE_AND_SWAP_INT -DHAVE_SYNC_BOOL_COMPARE_AND_SWAP_LONG -std=c99 -Wall -Wextra -W -pedantic -Wno-unused-parameter -shared -fPIC -fwhole-program $(LDFLAGS) runtime.c data.c $(LDADD)

package: all

uninstall:
	rm $(DESTDIR)$(LIBDIR)/libBlocksRuntime.so.0.0
	rm $(DESTDIR)$(LIBDIR)/libBlocksRuntime.so.0
	rm $(DESTDIR)$(LIBDIR)/libBlocksRuntime.so
	rm $(DESTDIR)$(INCLUDEDIR)/Block.h
	rm $(DESTDIR)$(INCLUDEDIR)/Block_private.h
