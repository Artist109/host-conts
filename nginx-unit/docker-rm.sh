#!/bin/bash

docker stop 7hs-keyunit01
docker rm 7hs-keyunit01
docker rm heuristic_ardinghelli
sudo docker rmi 7hs-keyunit01-image
sudo docker rmi unit
sudo docker volume rm unit-config.json
docker network rm backend_net
sudo docker system df
