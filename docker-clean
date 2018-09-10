#! /bin/bash

echo "Pruning docker images"
docker image prune -f
echo "Pruning docker volumes"
docker volume prune -f
echo "Pruning docker containers"
docker container prune -f
echo "Pruning docker system"
docker system prune -f
