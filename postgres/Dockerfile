ARG TAG="20190503"
ARG TDS_FDW_VERSION="2.0.0-alpha3"
ARG CONTENTIMAGE1="huggla/pgagent:$TAG"
ARG CONTENTSOURCE1="/pgagent/usr/share/postgresql/extension"
ARG CONTENTDESTINATION1="/initfs/usr/share/postgresql/extension"
ARG CONTENTIMAGE2="huggla/tds_fdw:$TDS_FDW_VERSION"
ARG CONTENTSOURCE2="/app"
ARG RUNDEPS="postgresql postgresql-contrib libressl2.7-libssl unixodbc"
ARG BUILDCMDS=\
"   cd /buildfs/usr "\
"&& ls -la /initfs/lib /buildfs/lib ./ ./local "\
"&& find * -type d ! -name include ! -name bin ! -name local -maxdepth 1 -exec ln -s ./{} ./local/ ; "\
"&& cd /buildfs/usr/bin "\
"&& find * ! -type l ! -name postgres -maxdepth 1 -exec ln -s ./{} ../local/bin/ ; "\
"&& chmod g+X /buildfs/usr/bin/*"
ARG STARTUPEXECUTABLES="/usr/bin/postgres"
ARG REMOVEDIRS="/usr/include"
ARG REMOVEFILES="/usr/local/postgres /etc/freetds.conf /RUNDEPS.txt"

#--------Generic template (don't edit)--------
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${CONTENTIMAGE3:-scratch} as content3
FROM ${INITIMAGE:-${BASEIMAGE:-huggla/base:$TAG}} as init
FROM ${BUILDIMAGE:-huggla/build} as build
FROM ${BASEIMAGE:-huggla/base:$TAG} as image
ARG CONTENTSOURCE1
ARG CONTENTSOURCE1="${CONTENTSOURCE1:-/}"
ARG CONTENTDESTINATION1
ARG CONTENTDESTINATION1="${CONTENTDESTINATION1:-/}"
ARG CONTENTSOURCE2
ARG CONTENTSOURCE2="${CONTENTSOURCE2:-/}"
ARG CONTENTDESTINATION2
ARG CONTENTDESTINATION2="${CONTENTDESTINATION2:-/}"
ARG CONTENTSOURCE3
ARG CONTENTSOURCE3="${CONTENTSOURCE3:-/}"
ARG CONTENTDESTINATION3
ARG CONTENTDESTINATION3="${CONTENTDESTINATION3:-/}"
ARG CLONEGITSDIR
ARG DOWNLOADSDIR
ARG MAKEDIRS
ARG MAKEFILES
ARG EXECUTABLES
ARG STARTUPEXECUTABLES
ARG EXPOSEFUNCTIONS
ARG GID0WRITABLES
ARG GID0WRITABLESRECURSIVE
ARG LINUXUSEROWNED
ARG LINUXUSEROWNEDRECURSIVE
COPY --from=build /imagefs /
#---------------------------------------------

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

#--------Generic template (don't edit)--------
USER starter
ONBUILD USER root
#---------------------------------------------

STOPSIGNAL SIGINT
