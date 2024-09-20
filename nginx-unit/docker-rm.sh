#!/bin/bash

docker stop 7hs-keyunit01
docker rm 7hs-keyunit01
sudo docker rmi 7hs-keyunit01-image
sudo docker volume rm unit-config.json
docker network rm backend_net
sudo docker system df
