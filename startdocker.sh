#!/bin/bash

docker_image="aa3025/python3_10"
container_name=${USER}_python3
gpus=" --gpus all"
share=/home/$USER/share
u_id=1000
g_id=1000
port=8888 #expose this port number
ports="-p $port:$port"
token=qwerty

mkdir -p $share

docker pull $docker_image
docker run --rm -it -d $gpus -v ${share}:/share --name ${container_name} --hostname ${container_name} $ports -e TZ=Europe/London ${docker_image} /bin/bash
docker exec -u $u_id:$g_id ${container_name} /home/user/.conda/envs/jup/bin/jupyter lab --ip=0.0.0.0 --port=8888 --NotebookApp.token=$token

#docker exec -u $u_id:$g_id ${container_name} jupyter lab --ip=0.0.0.0 --port=8888 --NotebookApp.token=$token
