# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG TAG="20190925"
ARG IMAGETYPE="application"
ARG CITYDBVERSION="v4.0.2"
ARG BASEIMAGE="huggla/postgres-alpine:postgis-$TAG"
ARG MAKEDIRS="/initdb/dropdb"
ARG CLONEGITS="'-b $CITYDBVERSION --depth 1 https://github.com/3dcitydb/3dcitydb.git'"
ARG DESTDIR="/initdb"
ARG BUILDCMDS='cp -a 3dcitydb/PostgreSQL/SQLScripts/* $DESTDIR/'
ARG FINALCMDS=\
'   mv $DESTDIR/DROP_DB.sql $DESTDIR/dropdb/ '\
'&& mv $DESTDIR/CREATE_DB.sql $DESTDIR/045.template_3dcitydb.sql'
# ARGs (can be passed to Build/Final) </END>

# Generic template (don't edit) <BEGIN>
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${CONTENTIMAGE3:-scratch} as content3
FROM ${CONTENTIMAGE4:-scratch} as content4
FROM ${INITIMAGE:-${BASEIMAGE:-huggla/base:$TAG}} as init
# Generic template (don't edit) </END>

# =========================================================================
# Build
# =========================================================================
# Generic template (don't edit) <BEGIN>
FROM ${BUILDIMAGE:-huggla/build:$TAG} as build
FROM ${BASEIMAGE:-huggla/base:$TAG} as final
COPY --from=build /finalfs /
# Generic template (don't edit) </END>

# =========================================================================
# Final
# =========================================================================
ENV VAR_SRID="4326" \
    VAR_SRSNAME="urn:ogc:def:crs:EPSG::4326"
    
# Generic template (don't edit) <BEGIN>
USER starter
ONBUILD USER root
# Generic template (don't edit) </END>
