# Secure and Minimal image of Postgres, 3dcitydb
# https://hub.docker.com/repository/docker/huggla/sam-postgres

# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG SaM_VERSION="2.0.1"
ARG IMAGETYPE="application"
ARG CITYDBVERSION="4.0.2"
ARG POSTGRES_VERSION="12.2"
ARG POSTGIS_VERSION="3.0.1"
ARG BASEIMAGE="huggla/sam-postgres:$POSTGRES_VERSION-postgis-$POSTGIS_VERSION"
ARG MAKEDIRS="/initdb/dropdb"
ARG CLONEGITS="'-b v$CITYDBVERSION --depth 1 https://github.com/3dcitydb/3dcitydb.git'"
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
FROM ${INITIMAGE:-${BASEIMAGE:-huggla/secure_and_minimal:$SaM_VERSION-base}} as init
# Generic template (don't edit) </END>

# =========================================================================
# Build
# =========================================================================
# Generic template (don't edit) <BEGIN>
FROM ${BUILDIMAGE:-huggla/secure_and_minimal:$SaM_VERSION-build} as build
FROM ${BASEIMAGE:-huggla/secure_and_minimal:$SaM_VERSION-base} as final
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
