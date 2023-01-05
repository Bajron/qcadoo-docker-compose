#!/bin/bash
set -eu

# !!! THIS FILE IS CURRENTLY NOT USED, see secrets/postgres-passwd

# It will fail during init, if the postgres user cannot read this file
POSTGRES_PASSWORD=$( head -n 1 /run/secrets/postgres-passwd 2>/dev/null )
# ...hence the default here as well
POSTGRES_PASSWORD_DEFAULT="kpGpfmrQ2YrLr8wd9p"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	ALTER USER ${POSTGRES_USER} PASSWORD '${POSTGRES_PASSWORD:-${POSTGRES_PASSWORD_DEFAULT}}';
EOSQL
