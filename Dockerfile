ARG PGAGENTVERSION="4.0.0"
ARG BUILDDEPS="postgres-dev cmake build-base boost-dev"
ARG DOWNLOADS="https://ftp.postgresql.org/pub/pgadmin/pgagent/pgAgent-$PGAGENTVERSION-Source.tar.gz"
ARG RUNDEPS="postgresql"
ARG MAKEDIRS="/initdb"
ARG BUILDCMDS=\
"   cd pgAgent-$PGAGENTVERSION-Source "\
"&& cmake "\
"&& make "\
"&& cp *.sql *.control sql/* /imagefs/usr/share/postgresql/extension/ "\
"&& cd /imagefs/usr/local "\
"&& rm -rf bin "\
"&& ln -s ../../usr/* ./ "\
"&& rm bin "\
"&& mkdir bin "\
"&& cd bin "\
"&& ln -s ../../bin/* ./ "\
"&& rm postgres"
ARG EXECUTABLES="/usr/bin/postgres"

FROM huggla/busybox:20181005-edge as init

FROM huggla/build:20181005-edge as build

FROM huggla/base:20181005-edge as image

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

ONBUILD USER root
