ARG TAG="20181204"
ARG BASEIMAGE="huggla/postgres-alpine:$TAG"
ARG RUNDEPS="postgresql-plpython3"

#---------------Don't edit----------------
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${INITIMAGE:-${BASEIMAGE:-huggla/base:$TAG}} as init
FROM ${BUILDIMAGE:-huggla/build:$TAG} as build
FROM ${BASEIMAGE:-huggla/base:$TAG} as image
COPY --from=build /imagefs /
#-----------------------------------------

#---------------Don't edit----------------
USER starter
ONBUILD USER root
#-----------------------------------------
