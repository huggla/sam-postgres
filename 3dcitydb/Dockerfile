# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG SaM_VERSION="1.0"
ARG TAG="20191018"
ARG IMAGETYPE="application"
ARG CITYDBVERSION="v4.0.2"
ARG POSTGRES_VERSION="12.0"
ARG POSTGIS_VERSION="2.5.3"
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
FROM ${CONTENTIMAGE5:-scratch} as content5
FROM ${INITIMAGE:-${BASEIMAGE:-huggla/base:$SaM_VERSION-$TAG}} as init
# Generic template (don't edit) </END>

# =========================================================================
# Build
# =========================================================================
# Generic template (don't edit) <BEGIN>
FROM ${BUILDIMAGE:-huggla/build:$SaM_VERSION-$TAG} as build
FROM ${BASEIMAGE:-huggla/base:$SaM_VERSION-$TAG} as final
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
