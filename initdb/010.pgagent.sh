#!/bin/sh

# Set in parent script:
# ---------------------------------------------------------
# set -e +a +m +s +i +f
# readonly BIN_DIR="$(/usr/bin/dirname "$0")"
# . "$BIN_DIR/start.stage2.functions"
# readonly CONFIG_FILE="$(var - CONFIG_FILE)"
# readonly CONFIG_DIR="$(/usr/bin/dirname "$CONFIG_FILE")"
# ---------------------------------------------------------

readonly CREATE_EXTENSION_PGAGENT="$(var - CREATE_EXTENSION_PGAGENT)"
if [ "$CREATE_EXTENSION_PGAGENT" == "yes" ]
then
   prio="010"
   dbname="postgres"
   sql_file="$CONFIG_DIR/initdb/$prio.$dbname.sql"
   echo "CREATE EXTENSION IF NOT EXISTS pgagent;" > "$sql_file"
fi
