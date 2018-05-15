#!/bin/sh

# Set in parent script:
# ---------------------------------------------------------
# set -e +a +m +s +i +f
# . /start/stage2.functions
# ---------------------------------------------------------

createPgagentExtension(){
   local prio="010"
   local dbname="postgres"
   local sql_file="/init/initdb/$prio.$dbname.sql"
   echo "CREATE EXTENSION IF NOT EXISTS pgagent;" > "$sql_file"
}

if [ "$VAR_CREATE_EXTENSION_PGAGENT" == "yes" ]
then
   createPgagentExtension
fi
