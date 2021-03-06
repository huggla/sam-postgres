# sam-postgres
Secure and Minimal Docker-image of Postgresql with Pgagent and tds_fdw extensions included. Separate tags with Postgis and/or Plpython3, 3DCityDB extensions available. Will execute .sh and .sql files located in /initdb when a new datastore is created.

## Environment variables
### pre-set runtime variables
* VAR_CONFIG_FILE="/etc/postgres/postgresql.conf"
* VAR_FINAL_COMMAND="/usr/local/bin/postgres --config_file=\"\$VAR_CONFIG_FILE\""
* VAR_LOCALE="en_US.UTF-8"
* VAR_ENCODING="UTF8"
* VAR_TEXT_SEARCH_CONFIG="english"
* VAR_HBA="local all all trust, host all all 127.0.0.1/32 trust, host all all ::1/128 trust, host all all all md5"
* VAR_CREATE_EXTENSION_PGAGENT="yes"
* VAR_ARGON2_PARAMS="-r" (only used if VAR_ENCRYPT_PW is set to "yes")
* VAR_SALT_FILE="/proc/sys/kernel/hostname" (only used if VAR_ENCRYPT_PW is set to "yes")
* VAR_LINUX_USER="postgres" (also database owner/superuser)
* VAR_param_data_directory="'/pgdata'" (Must be owned by UID 102)
* VAR_param_hba_file="'/etc/postgres/pg_hba.conf'"
* VAR_param_ident_file="'/etc/postgres/pg_ident.conf'"
* VAR_param_unix_socket_directories="'/var/run/postgresql'"
* VAR_param_listen_addresses="'*'"
* VAR_param_timezone="'UTC'"
* VAR_FREETDS_CONF="[global]\\ntds version=auto\\ntext size=64512" (contents of /etc/freerds.conf)
* VAR_SRID="4326" (only for 3dcitydb)
* VAR_SRSNAME="urn:ogc:def:crs:EPSG::4326" (only for 3dcitydb)

### Optional runtime variables
* VAR_param_&lt;postgres parameter name&gt;
* VAR_password_file_&lt;VAR_LINUX_USER&gt;
* VAR_password_&lt;VAR_LINUX_USER&gt;
* VAR_ENCRYPT_PW (set to "yes" to hash password with Argon2)

## Capabilities
Can drop all but SETPCAP, SETGID and SETUID.

## Tips
Works with huggla/sam-pgagent, huggla/sam-pgadmin, huggla/sam-pgbouncer and huggla/sam-backup.
