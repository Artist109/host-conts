#!/bin/bash

#SCRIPT_DIR="$(dirname "$(realpath "$0")")"
#ENV_FILE="$SCRIPT_DIR/../.env"
#
#if [ -f "$ENV_FILE" ]; then
#    set -o allexport
#    source "$ENV_FILE"
#    set +o allexport
#else
#    echo "Файл .env не найден по пути $ENV_FILE."
#    exit 1
#fi

if [ -z "$POSTGRES_USER" ] || [ -z "$ALT_PASSWORD" ] || [ -z "$POSTGRES_T_U" ] || [ -z "$POSTGRES_T_P" ] ||
    [ -z "$POSTGRES_DB_T" ]; then
    echo "Одна или несколько переменных POSTGRES_USER, ALT_PASSWORD, POSTGRES_T_U, POSTGRES_T_P, POSTGRES_DB_T не установлены в файле .env."
    exit 1
fi

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    ALTER USER postgres WITH PASSWORD '$ALT_PASSWORD';
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE $POSTGRES_DB_T;
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER test WITH PASSWORD '$POSTGRES_T_P';
    GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB_T TO $POSTGRES_T_U;
EOSQL

cp /var/lib/postgresql/conf/pg_hba.conf /var/lib/postgresql/data/pg_hba.conf

cp /var/lib/postgresql/conf/postgresql.conf /var/lib/postgresql/data/postgresql.conf
