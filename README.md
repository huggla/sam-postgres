**Note! I use Docker latest tag for development, which means that it isn't allways working. Date tags are stable.**

# postgres-alpine
A small and secure Docker image of Postgresql 10.4.

## Environment variables
### pre-set runtime variables
* VAR_LOCALE="en_US.UTF-8"
* VAR_ENCODING="UTF8"
* VAR_TEXT_SEARCH_CONFIG="english"
* VAR_HBA="local all all trust, host all all 127.0.0.1/32 trust, host all all ::1/128 trust, host all all all md5"
* VAR_CREATE_EXTENSION_PGAGENT="yes"
* VAR_password_postgres=generated, random
* VAR_param_data_directory="'/pgdata'"
* VAR_param_hba_file="'/etc/postgres/pg_hba.conf'"
* VAR_param_ident_file="'/etc/postgres/pg_ident.conf'"
* VAR_param_unix_socket_directories="'/var/run/postgresql'"
* VAR_param_listen_addresses="'*'"
* VAR_param_timezone="'UTC'"

### Optional runtime variables
* VAR_param_&lt;postgres parameter name&gt;_&lt;

## Capabilities
Can drop all but CHOWN, DAC_OVERRIDE, FOWNER, SETGID and SETUID.

## Tips
Works with huggla/pgagent-alpine, huggla/pgadmin-alpine and huggla/pgbouncer-alpine.
