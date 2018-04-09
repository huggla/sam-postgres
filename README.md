**Note! I use Docker latest tag for development, which means that it isn't allways working. Date tags are stable.**

# postgres-alpine
A small and secure Docker image of Postgresql 10.3.

## Environment variables
### pre-set runtime variables
* REV_LOCALE="en_US.UTF-8"
* REV_ENCODING="UTF8"
* REV_TEXT_SEARCH_CONFIG="english"
* REV_HBA="local all all trust, host all all 127.0.0.1/32 trust, host all all ::1/128 trust, host all all all md5"
* REV_CREATE_EXTENSION_PGAGENT="yes"
* REV_password_postgres=generated, random
* REV_param_data_directory="'/pgdata'"
* REV_param_hba_file="'/etc/postgres/pg_hba.conf'"
* REV_param_ident_file="'/etc/postgres/pg_ident.conf'"
* REV_param_unix_socket_directories="'/var/run/postgresql'"
* REV_param_listen_addresses="'*'"
* REV_param_timezone="'UTC'"

### Optional runtime variables
* REV_param_&lt;postgres parameter name&gt;_&lt;

## Capabilities
Can drop all but CHOWN, DAC_OVERRIDE, FOWNER, SETGID and SETUID.

## Tips
Works with huggla/pgagent-alpine and huggla/pgbouncer-alpine.
