ARG TAG="20181108-edge"
ARG BASEIMAGE="huggla/postgres-alpine:$TAG"
ARG ADDREPOS="http://dl-cdn.alpinelinux.org/alpine/edge/testing"
ARG RUNDEPS="postgis"
ARG BUILDCMDS=\
"   cd /imagefs/usr/local "\
"&& rm -rf lib share "\
"&& ln -sf ../../usr/lib lib "\
"&& ln -sf ../../usr/share share "

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
