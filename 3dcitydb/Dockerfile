ARG TAG="20190517"
ARG BASEIMAGE="huggla/postgres-alpine:postgis-$TAG"
ARG MAKEDIRS="/initdb/dropdb"
ARG CITYDBVERSION="v4.0.1"
ARG CLONEGITS="'-b $CITYDBVERSION --depth 1 https://github.com/3dcitydb/3dcitydb.git'"
ARG BUILDCMDS=\
"   cp -a \$CLONEGITSDIR/3dcitydb/PostgreSQL/SQLScripts/* /imagefs/initdb/ "\
"&& mv /imagefs/initdb/DROP_DB.sql /imagefs/initdb/dropdb/ "\
"&& mv /imagefs/initdb/CREATE_DB.sql /imagefs/initdb/045.template_3dcitydb.sql"

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

ENV VAR_SRID="4326" \
    VAR_SRSNAME="urn:ogc:def:crs:EPSG::4326"
    
#--------Generic template (don't edit)--------
USER starter
ONBUILD USER root
#---------------------------------------------
