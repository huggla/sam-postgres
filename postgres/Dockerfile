# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG TAG="20190911"
ARG PGAGENT_VERSION="4.0.0"
ARG TDS_FDW_VERSION="2.0.0-alpha3"
ARG CONTENTIMAGE1="huggla/pgagent:$PGAGENT_VERSION"
ARG CONTENTSOURCE1="/app/usr/share/postgresql/extension"
ARG CONTENTDESTINATION1="/finalfs/usr/share/postgresql/extension"
ARG CONTENTIMAGE2="huggla/tds_fdw:$TDS_FDW_VERSION"
ARG CONTENTSOURCE2="/app"
ARG CONTENTDESTINATION2="/finalfs/"
ARG RUNDEPS="postgresql postgresql-contrib libressl2.7-libssl unixodbc"
ARG FINALCMDS=\
"   cd /finalfs/usr/local "\
"&& ln -s ../lib ../share ./ "\
"&& cd /finalfs/usr/local/bin "\
"&& find ../../bin ! -type l ! -name postgres ! -name ../../bin -maxdepth 1 -exec ln -s {} ./ + "\
"&& chmod g+X /finalfs/usr/bin/*"
ARG STARTUPEXECUTABLES="/usr/bin/postgres"
ARG REMOVEDIRS="/usr/include"
ARG REMOVEFILES="/etc/freetds.conf"
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
ARG CONFIG_DIR="/etc/postgres"

ENV VAR_LINUX_USER="postgres" \
    VAR_INIT_CAPS="cap_chown" \
    VAR_CONFIG_FILE="$CONFIG_DIR/postgresql.conf" \
    VAR_LOCALE="en_US.UTF-8" \
    VAR_ENCODING="UTF8" \
    VAR_TEXT_SEARCH_CONFIG="english" \
    VAR_HBA="local all all trust, host all all 127.0.0.1/32 trust, host all all ::1/128 trust, host all all all md5" \
    VAR_CREATE_EXTENSION_PGAGENT="yes" \
    VAR_param_data_directory="'/pgdata'" \
    VAR_param_hba_file="'$CONFIG_DIR/pg_hba.conf'" \
    VAR_param_ident_file="'$CONFIG_DIR/pg_ident.conf'" \
    VAR_param_unix_socket_directories="'/var/run/postgresql'" \
    VAR_param_listen_addresses="'*'" \
    VAR_param_timezone="'UTC'" \
    VAR_FINAL_COMMAND="postgres --config_file=\"\$VAR_CONFIG_FILE\"" \
    VAR_FREETDS_CONF="[global]\\ntds version=auto\\ntext size=64512"

STOPSIGNAL SIGINT

# Generic template (don't edit) <BEGIN>
USER starter
ONBUILD USER root
# Generic template (don't edit) </END>

