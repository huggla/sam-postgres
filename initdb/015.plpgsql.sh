if [ -z "$CREATE_LANGUAGE_PLPGSQL" ]
then
   readonly CREATE_LANGUAGE_PLPGSQL="$(var - CREATE_LANGUAGE_PLPGSQL)"
fi
if [ "$CREATE_LANGUAGE_PLPGSQL" == "yes" ]
then
   echo "CREATE LANGUAGE IF NOT EXISTS plpgsql;" >> "$sql_file"
fi
