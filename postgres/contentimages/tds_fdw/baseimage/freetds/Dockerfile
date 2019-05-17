ARG TAG="20190517"
ARG BASEIMAGE="huggla/busybox:$TAG"
ARG FREETDS_VERSION="1.1.6"
ARG MAKEDIRS="\$DESTDIR-dev/usr/lib"
ARG DOWNLOADS="http://www.freetds.org/files/stable/freetds-$FREETDS_VERSION.tar.gz"
ARG BUILDDEPS="build-base libressl-dev linux-headers readline-dev unixodbc-dev libtool gettext"
ARG RUNDEPS="libressl2.7-libssl unixodbc"
ARG BUILDCMDS=\
"   cd freetds-$FREETDS_VERSION "\
"&& sed -i '95i#endif' ./src/tds/tls.c "\
"&& sed -i '96i' ./src/tds/tls.c "\
"&& sed -i '97i#ifndef TLS_ST_OK' ./src/tds/tls.c "\
"&& sed -i '28i#include <sys/stat.h>' ./src/apps/fisql/fisql.c "\
"&& ./configure --prefix=/usr --sysconfdir=/etc --mandir=/usr/share/man --infodir=/usr/share/info --enable-msdblib --with-openssl=/usr --enable-odbc --with-unixodbc=/usr "\
"&& make "\
"&& make install "\
"&& mv \$DESTDIR/usr/include \$DESTDIR-dev/usr/ "\
"&& mv \$DESTDIR/usr/lib/*.so \$DESTDIR/usr/lib/*.a \$DESTDIR-dev/usr/lib/"
ARG REMOVEDIRS="\$DESTDIR/usr/share"

#--------Generic template (don't edit)--------
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${CONTENTIMAGE3:-scratch} as content3
FROM ${INITIMAGE:-${BASEIMAGE:-huggla/base:$TAG}} as init
FROM ${BUILDIMAGE:-huggla/build} as build
FROM ${BASEIMAGE:-huggla/base:$TAG} as image
ARG CONTENTSOURCE1
ARG CONTENTSOURCE1="${CONTENTSOURCE1:-/}"
ARG CONTENTDESTINATION1
ARG CONTENTDESTINATION1="${CONTENTDESTINATION1:-/}"
ARG CONTENTSOURCE2
ARG CONTENTSOURCE2="${CONTENTSOURCE2:-/}"
ARG CONTENTDESTINATION2
ARG CONTENTDESTINATION2="${CONTENTDESTINATION2:-/}"
ARG CONTENTSOURCE3
ARG CONTENTSOURCE3="${CONTENTSOURCE3:-/}"
ARG CONTENTDESTINATION3
ARG CONTENTDESTINATION3="${CONTENTDESTINATION3:-/}"
ARG CLONEGITSDIR
ARG DOWNLOADSDIR
ARG MAKEDIRS
ARG MAKEFILES
ARG EXECUTABLES
ARG STARTUPEXECUTABLES
ARG EXPOSEFUNCTIONS
ARG GID0WRITABLES
ARG GID0WRITABLESRECURSIVE
ARG LINUXUSEROWNED
ARG LINUXUSEROWNEDRECURSIVE
COPY --from=build /imagefs /
#---------------------------------------------

#--------Generic template (don't edit)--------
USER starter
ONBUILD USER root
#---------------------------------------------
