#!/bin/bash

# addgroup --system www-data && adduser --system --ingroup www-data www-data

IMAGE_NAME="7hs-keyunit01-image"

CONTAINER_NAME="7hs-keyunit01"

HOST_PORT=8300  # Порт на хосте, который будет использоваться для связи с контейнером
CONTAINER_PORT=8300  # Порт внутри контейнера, на котором работает nginx-unit

docker network create --subnet=10.219.7.0/24 backend_net

# Сборка образа из Dockerfile
docker build -t $IMAGE_NAME .

  #--restart always \
docker run -d \
  --name $CONTAINER_NAME \
  --ip 10.219.7.2 \
  --network backend_net \
  -p $HOST_PORT:$CONTAINER_PORT \
  -v unit-config.json:/docker-entrypoint.d/ \
  $IMAGE_NAME

docker system df

docker logs $CONTAINER_NAME

docker ps -a