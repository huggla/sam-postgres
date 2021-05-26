# Secure and Minimal image of Postgresql prepared for Guacamole.
# https://hub.docker.com/repository/docker/huggla/sam-postgres

# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG SaM_VERSION="2.0.4"
ARG POSTGRES_VERSION="12.2"
ARG IMAGETYPE="application,base"
ARG BASEIMAGE="huggla/sam-postgres:$POSTGRES_VERSION"
ARG CONTENTIMAGE1="guacamole/guacamole"
ARG CONTENTSOURCE1="/opt/guacamole/postgresql/schema/*.sql"
ARG CONTENTDESTINATION1="/tmp/"
ARG BUILDCMDS=\
"   echo 'SET SESSION AUTHORIZATION guacamole_user;' > /finalfs/initdb/025.guacamole_db.sql "\
"&& cat /tmp/*.sql >> /finalfs/initdb/025.guacamole_db.sql"
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
# Generic template (don't edit) <BEGIN>
USER starter
ONBUILD USER root
# Generic template (don't edit) </END>
