#!/bin/sh

# Set in parent scripts:
# ---------------------------------------------------------
# set -e +a +m +s +i +f
# VAR_*
# ---------------------------------------------------------

createPgagentExtension(){
   local prio="010"
   local dbname="postgres"
   local sql_file="/initdb/$prio.$dbname.sql"
   echo "CREATE EXTENSION IF NOT EXISTS pgagent;" > "$sql_file"
}

if [ "$VAR_CREATE_EXTENSION_PGAGENT" == "yes" ]
then
   createPgagentExtension
fi
