FROM postgres:16-bookworm

RUN apt-get update && apt-get install -y iputils-ping nano

COPY replica_init.sh /docker-entrypoint-initdb.d/

RUN chmod +x /docker-entrypoint-initdb.d/replica_init.sh
