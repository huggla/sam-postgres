#!/bin/sh

# Set in parent script:
# ---------------------------------------------------------
# set -e +a +m +s +i +f
# readonly BIN_DIR="$(/usr/bin/dirname "$0")"
# . "$BIN_DIR/start.stage2.functions"
# readonly NAME="$(var - NAME)"
# readonly CONFIG_FILE="$(var - CONFIG_FILE)"
# readonly CONFIG_DIR="$(/usr/bin/dirname "$CONFIG_FILE")"
# readonly sql_dir="$CONFIG_DIR/initdb/sql"
# ---------------------------------------------------------

readonly CREATE_EXTENSION_PGAGENT="$(var - CREATE_EXTENSION_PGAGENT)"
if [ "$CREATE_EXTENSION_PGAGENT" == "yes" ]
then
   prio="010"
   dbname="$NAME"
   sql_file="$sql_dir/$prio.$dbname.sql"
   echo "CREATE EXTENSION IF NOT EXISTS pgagent;" > "$sql_file"
fi
