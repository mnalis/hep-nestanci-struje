PROG=hep-nestanak
PREFIX=/usr/local
BINDIR=${PREFIX}/bin

all:
	@echo Do "make install" or "make uninstall"

install: 
	install ${PROG} ${BINDIR}/${PROG}
	
uninstall:
	rm -f ${BINDIR}/${PROG}
