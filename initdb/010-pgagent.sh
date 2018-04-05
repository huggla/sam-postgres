#!/bin/sh
set -e

readonly CREATE_EXTENSION_PGAGENT
if [ "$CREATE_EXTENSION_PGAGENT" == "yes" ]
then
   CREATE_LANGUAGE_PLPGSQL="yes"
   echo "CREATE EXTENSION pgagent;" >> "$sql_file"
fi
readonly CREATE_LANGUAGE_PLPGSQL
if [ "$CREATE_LANGUAGE_PLPGSQL" == "yes" ]
then
   echo "CREATE LANGUAGE plpgsql;" >> "$sql_file"
fi
