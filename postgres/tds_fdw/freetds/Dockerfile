ARG TAG="20190503"

FROM huggla/alpine as alpine

ARG BUILDDEPS="build-base libressl-dev linux-headers readline-dev unixodbc-dev libtool gettext"
ARG RUNDEPS="libressl2.7-libssl unixodbc"
ARG FREETDS_VERSION="patched"
ARG DESTDIR="/apps/freetds"

RUN downloadDir="$(mktemp -d)" \
 && wget -O $downloadDir/freetds.tar.gz "http://www.freetds.org/files/stable/freetds-$FREETDS_VERSION.tar.gz" \
 && buildDir="$(mktemp -d)" \
 && tar -xvp -f $downloadDir/freetds.tar.gz -C $buildDir --strip-components 1 \
 && rm -rf $downloadDir \
 && apk add $BUILDDEPS \
 && cd $buildDir \
 && sed -i '95i#endif' ./src/tds/tls.c \
 && sed -i '96i' ./src/tds/tls.c \
 && sed -i '97i#ifndef TLS_ST_OK' ./src/tds/tls.c \
 && sed -i '28i#include <sys/stat.h>' ./src/apps/fisql/fisql.c \
 && ./configure --prefix=/usr --sysconfdir=/etc --mandir=/usr/share/man --infodir=/usr/share/info --enable-msdblib --with-openssl=/usr --enable-odbc --with-unixodbc=/usr \
 && make \
 && mkdir -p $DESTDIR-dev/usr/lib \
 && make -j1 install \
 && rm -rf $buildDir \
 && apk --purge del $BUILDDEPS \
 && mv $DESTDIR/usr/include $DESTDIR-dev/usr/ \
 && mv $DESTDIR/usr/lib/*.so $DESTDIR/usr/lib/*.a $DESTDIR-dev/usr/lib/ \
 && rm -rf $DESTDIR/usr/share \
 && echo "$RUNDEPS" > /apps/RUNDEPS-freetds

FROM huggla/busybox:$TAG as image

COPY --from=alpine /apps /
