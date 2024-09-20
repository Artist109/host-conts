#!/bin/bash

docker stop 7lbdmz-keyng01
docker rm -v 7lbdmz-keyng01
sudo docker rmi 7lbdmz-keyng01
docker volume rm pgdata
#sudo docker volume rm $(docker volume ls -q)
docker network rm db_net
sudo docker system df

