#!/bin/sh

# set -e +a +m +s +i -f
# readonly BIN_DIR="$(/usr/bin/dirname "$0")"
# . "$BIN_DIR/start.stage2.functions"

if [ -z "$CREATE_LANGUAGE_PLPGSQL" ]
then
   readonly CREATE_LANGUAGE_PLPGSQL="$(var - CREATE_LANGUAGE_PLPGSQL)"
fi
if [ "$CREATE_LANGUAGE_PLPGSQL" == "yes" ]
then
   prio="015"
   dbname="postgres"
   sql_file="$prio.$dbname.sql
   echo "CREATE LANGUAGE IF NOT EXISTS plpgsql;" >> "$sql_file"
fi
