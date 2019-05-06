ARG TAG="20190503"
ARG FREETDS_VERSION="1.1.6"
ARG CONTENTIMAGE1="huggla/freetds:$FREETDS_VERSION"
ARG CONTENTSOURCE1="/freetds*"
ARG CLONEGITS="https://github.com/tds-fdw/tds_fdw.git"
ARG BUILDDEPS="postgresql-dev git make g++ libressl2.7-libssl unixodbc gettext"
ARG DESTDIR="/tds_fdw"
ARG BUILDCMDS=\
"   mv /freetds/* /freetds-dev/* / "\
"&& cd tds_fdw "\
"&& make USE_PGXS=1 "\
"&& make USE_PGXS=1 install"

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
ARG CONTENTDESTINATION1="${CONTENTDESTINATION1:-/buildfs/}"
ARG CONTENTSOURCE2
ARG CONTENTSOURCE2="${CONTENTSOURCE2:-/}"
ARG CONTENTDESTINATION2
ARG CONTENTDESTINATION2="${CONTENTDESTINATION2:-/buildfs/}"
ARG CONTENTSOURCE3
ARG CONTENTSOURCE3="${CONTENTSOURCE3:-/}"
ARG CONTENTDESTINATION3
ARG CONTENTDESTINATION3="${CONTENTDESTINATION3:-/buildfs/}"
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
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${BUILDIMAGE:-huggla/alpine} as build
ARG NAME
ARG DESTDIR="/imagefs/$NAME"
COPY --from=build /imagefs /
#---------------------------------------------




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
