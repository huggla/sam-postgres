ARG TAG="20181204"
ARG BASEIMAGE="huggla/postgres-alpine:postgis-$TAG"
ARG CITYDBVERSION="v4.0.1"
ARG CLONEGITS="'-b \"${CITYDBVERSION}\" --depth 1 https://github.com/3dcitydb/3dcitydb.git'"
ARG BUILDCMDS=\
"   cp -a \$cloneGitsDir/PostgreSQL/SQLScripts/* /imagefs/initdb/ "\
"&& rm -f /imagefs/initdb/DROP_DB.sql "\
"&& mv /imagefs/initdb/CREATE_DB.sql /imagefs/initdb/40.template_postgis.sql "\
"&& sed -i 's/:srsno/\$VAR_SRID/' /imagefs/initdb/40.template_postgis.sql "\
"&& sed -i 's/:gmlsrsname/\$VAR_SRSNAME/' /imagefs/initdb/40.template_postgis.sql"

#--------Generic template (don't edit)--------
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${INITIMAGE:-${BASEIMAGE:-huggla/base:$TAG}} as init
FROM ${BUILDIMAGE:-huggla/build} as build
FROM ${BASEIMAGE:-huggla/base:$TAG} as image
ARG CONTENTSOURCE1="${CONTENTSOURCE1:-/}"
ARG CONTENTDESTINATION1="${CONTENTDESTINATION1:-/buildfs/}"
ARG CONTENTSOURCE2="${CONTENTSOURCE2:-/}"
ARG CONTENTDESTINATION2="${CONTENTDESTINATION2:-/buildfs/}"
ARG CLONEGITSDIR
ARG DOWNLOADSDIR
ARG MAKEDIRS
ARG MAKEFILES
ARG EXECUTABLES
ARG EXPOSEFUNCTIONS
COPY --from=build /imagefs /
#---------------------------------------------

ENV VAR_SRID="4326" \
    VAR_SRSNAME="urn:ogc:def:crs:EPSG::4326"
    
#--------Generic template (don't edit)--------
USER starter
ONBUILD USER root
#---------------------------------------------
