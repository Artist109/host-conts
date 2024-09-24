#!/bin/bash

IMAGE_NAME="postgre-image"

CONTAINER_NAME="postgre"

HOST_PORT=5432  # Порт на хосте, который будет использоваться для связи с контейнером
CONTAINER_PORT=5432  # Порт внутри контейнера, на котором работает nginx-unit

docker stop postgre
docker rm postgre
export $(grep -v '^#' ../.env | xargs)

docker run -d \
  --name $CONTAINER_NAME \
  --ip 10.207.7.2 \
  --network db_net \
  -p $HOST_PORT:$CONTAINER_PORT \
  -e POSTGRES_PASSWORD \
  -e POSTGRES_DB_T \
  -e POSTGRES_T_P \
  -e POSTGRES_T_U \
  -e ALT_PASSWORD \
  -v pgdata:/var/lib/postgresql/data \
  $IMAGE_NAME


docker network connect backend_net $CONTAINER_NAME

docker logs $CONTAINER_NAME