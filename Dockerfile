ARG TAG="20181113-edge"
ARG BASEIMAGE="huggla/postgres-alpine:postgis-$TAG"
ARG RUNDEPS="postgresql-plpython3"

#---------------Don't edit----------------
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${BASEIMAGE:-huggla/base:$TAG} as base
FROM huggla/build:$TAG as build
FROM ${BASEIMAGE:-huggla/base:$TAG} as image
COPY --from=build /imagefs /
#-----------------------------------------

#---------------Don't edit----------------
USER starter
ONBUILD USER root
#-----------------------------------------
