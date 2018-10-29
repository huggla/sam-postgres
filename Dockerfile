ARG BASEIMAGE="huggla/postgres-alpine"
ARG RUNDEPS="plpython3"

#---------------Don't edit----------------
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${BASEIMAGE:-huggla/base} as base
FROM huggla/build as build
FROM ${BASEIMAGE:-huggla/base} as image
COPY --from=build /imagefs /
#-----------------------------------------

#---------------Don't edit----------------
USER starter
ONBUILD USER root
#-----------------------------------------
