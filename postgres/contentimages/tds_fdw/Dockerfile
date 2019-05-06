ARG TAG="20190503"
ARG DESTDIR="/tds_fdw"

FROM huggla/freetds:$TAG as freetds
FROM huggla/alpine as alpine

ARG BUILDDEPS="postgresql-dev git make g++ libressl2.7-libssl unixodbc gettext"
ARG DESTDIR

COPY --from=freetds /freetds /freetds-dev /

RUN apk add $BUILDDEPS \
 && buildDir="$(mktemp -d)" \
 && cd $buildDir \
 && git clone https://github.com/tds-fdw/tds_fdw.git \
 && cd tds_fdw \
 && make USE_PGXS=1 \
 && make USE_PGXS=1 install

COPY --from=freetds /freetds $DESTDIR
COPY --from=freetds /RUNDEPS-freetds.txt $DESTDIR/RUNDEPS-tds_fdw

FROM huggla/busybox:$TAG as image

ARG DESTDIR

COPY --from=alpine $DESTDIR $DESTDIR
