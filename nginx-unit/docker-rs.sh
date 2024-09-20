#!/bin/bash

IMAGE_NAME="7hs-keyunit01-image"

CONTAINER_NAME="7hs-keyunit01"

HOST_PORT=8300  # Порт на хосте, который будет использоваться для связи с контейнером
CONTAINER_PORT=8300  # Порт внутри контейнера, на котором работает nginx-unit

docker stop nginx-unit
docker rm nginx-unit
docker run -d \
  --name $CONTAINER_NAME \
  --network backend_net \
  -p $HOST_PORT:$CONTAINER_PORT \
  -v unit-config.json:/docker-entrypoint.d/ \
  $IMAGE_NAME

docker logs $CONTAINER_NAME