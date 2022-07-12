NAME=ni
VERSION=1.0

PREFIX=/usr/local
BINDIR=$(PREFIX)/bin
SYSCONFDIR=$(PREFIX)/etc
DATADIR=$(PREFIX)/share/ni
TARGETDIR=/target

all: src/ni src/ni.conf

src/ni: src/ni.in
	sed 's|@VERSION@|$(VERSION)|g ; \
	     s|@SYSCONFDIR@|$(SYSCONFDIR)|g ; \
	     s|@DATADIR@|$(DATADIR)|g' src/ni.in > src/ni
src/ni.conf: src/ni.conf.in
	sed 's|@TARGETDIR@|$(TARGETDIR)|g' src/ni.conf.in > src/ni.conf


install: all
	install -d $(BINDIR) $(SYSCONFDIR) $(DATADIR)
	install src/ni $(BINDIR)
	install -m 644 src/ni.conf $(SYSCONFDIR)
	install -m 644 src/comps src/etc* $(DATADIR)

clean:
	rm -f src/ni src/ni.conf

dist:
	make clean
	tar zcvf ../$(NAME)-$(VERSION).tar.gz -C .. $(NAME)-$(VERSION)
