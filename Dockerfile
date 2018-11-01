ARG CONTENTIMAGE1="huggla/pgagent"
ARG CONTENTSOURCE1="/pgagent/usr/share/postgresql/extension"
ARG CONTENTDESTINATION1="/usr/share/postgresql/extension"
ARG CONTENTIMAGE2="huggla/tds_fdw"
ARG CONTENTSOURCE2="/tds_fdw/usr"
ARG CONTENTDESTINATION2="/usr"
ARG RUNDEPS="postgresql"
ARG BUILDCMDS=\
"   mkdir -p /imagefs/usr/local /imagefs/pgdata "\
"&& cd /imagefs/usr/local "\
"&& rm -rf bin "\
"&& ln -s ../../usr/* ./ "\
"&& rm bin "\
"&& mkdir bin "\
"&& cd bin "\
"&& ln -s ../../bin/* ./ "\
"&& rm postgres "\
"&& chmod g+w /pgdata"
ARG EXECUTABLES="/usr/bin/postgres"

#---------------Don't edit----------------
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${BASEIMAGE:-huggla/base} as base
FROM huggla/build as build
FROM ${BASEIMAGE:-huggla/base} as image
COPY --from=build /imagefs /
#-----------------------------------------

RUN chown 102 /pgdata

ARG CONFIG_DIR="/etc/postgres"

ENV VAR_LINUX_USER="postgres" \
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
    VAR_FINAL_COMMAND="postgres --config_file=\"\$VAR_CONFIG_FILE\""

#---------------Don't edit----------------
USER starter
ONBUILD USER root
#-----------------------------------------

STOPSIGNAL SIGINT
