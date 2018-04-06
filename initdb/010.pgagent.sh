#!/bin/sh

# set -e +a +m +s +i -f
# readonly BIN_DIR="$(/usr/bin/dirname "$0")"
# . "$BIN_DIR/start.stage2.functions"

if [ -z "$CREATE_EXTENSION_PGAGENT" ]
then
   readonly CREATE_EXTENSION_PGAGENT="$(var - CREATE_EXTENSION_PGAGENT)"
fi
if [ "$CREATE_EXTENSION_PGAGENT" == "yes" ]
then
   readonly CREATE_LANGUAGE_PLPGSQL="yes"
   prio="010"
   dbname="postgres"
   sql_file="$prio.$dbname.sql"
   echo "CREATE EXTENSION IF NOT EXISTS pgagent;" > "$sql_file"
fi
