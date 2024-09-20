#!/bin/bash

# addgroup --system www-data && adduser --system --ingroup www-data www-data

IMAGE_NAME="7lbdmz-keyng01-image"

CONTAINER_NAME="7lbdmz-keyng01"

HOST_PORT=5432  # Порт на хосте, который будет использоваться для связи с контейнером
CONTAINER_PORT=5432  # Порт внутри контейнера, на котором работает nginx-unit

export $(grep -v '^#' ../.env | xargs)

docker network create --subnet=10.207.7.0/24 db_net

# Сборка образа из Dockerfile
docker build -t $IMAGE_NAME .

  #--restart always \
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

docker system df

docker logs $CONTAINER_NAME

docker ps -a