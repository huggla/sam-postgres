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

if [ -z "$CREATE_LANGUAGE_PLPGSQL" ]
then
   readonly CREATE_LANGUAGE_PLPGSQL="$(var - CREATE_LANGUAGE_PLPGSQL)"
fi
if [ "$CREATE_LANGUAGE_PLPGSQL" == "yes" ]
then
   prio="015"
   dbname="$NAME"
   sql_file="$sql_dir/$prio.$dbname.sql"
   echo "CREATE LANGUAGE plpgsql;" > "$sql_file"
fi
