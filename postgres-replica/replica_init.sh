#!/bin/bash
set -e

REPLICA_PASSWORD=$(cat /run/secrets/postgres/replicator_pass)

# Ждем, пока мастер не будет готов
until pg_isready -h "$PG_PRIMARY_HOST" -p "$PG_PRIMARY_PORT"; do
  echo "Waiting for master PostgreSQL..."
  sleep 2
done

# Настройка параметров для репликации
echo "primary_conninfo = 'host=$PG_PRIMARY_HOST port=$PG_PRIMARY_PORT user=replicator password=$REPLICA_PASSWORD'" >> /var/lib/postgresql/data/postgresql.conf

# Запуск pg_basebackup для клонирования данных
pg_basebackup -h "$PG_PRIMARY_HOST" -D /var/lib/postgresql/data -U replicator -v -P --wal-method=stream

# Создание файла сигнализации для реплики
touch /var/lib/postgresql/data/standby.signal
