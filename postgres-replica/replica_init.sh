#!/bin/bash
set -e

REPLICATOR_USER="replicator"
REPLICATOR_PASSWORD="ReplicatorPass123"

until pg_isready -h "$PG_PRIMARY_HOST" -p "$PG_PRIMARY_PORT"; do
  echo "Waiting for master PostgreSQL..."
  sleep 2
done

mkdir -p /var/lib/postgresql/pg_backup
#chown postgres:postgres /var/lib/postgresql/pg_backup
chmod 700 -R /var/lib/postgresql/pg_backup

pg_basebackup -h "$PG_PRIMARY_HOST" -D /var/lib/postgresql/pg_backup -U "$REPLICATOR_USER" -v -P -Xs

cp /tmp/postgresql.conf $PGDATA/postgresql.conf
cp /tmp/pg_hba.conf $PGDATA/pg_hba.conf
echo "primary_conninfo = 'host=$PG_PRIMARY_HOST port=$PG_PRIMARY_PORT user=$REPLICATOR_USER password=$REPLICATOR_PASSWORD'" >> /var/lib/postgresql/data/postgresql.conf


touch /var/lib/postgresql/data/standby.signal

chown postgres:postgres $PGDATA/standby.signal
chmod u=rwx $PGDATA/standby.signal