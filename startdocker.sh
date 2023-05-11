#!/bin/bash
################ params #########################
# Change to docker image you build in with the Dockerfile
docker_image="aa3025/python3_10"

container_name=${USER}_python3
# do you have GPUs? (Nvidia docker support plugin must be installed on the system), otherwise leave empty
gpus=" --gpus all"
# gpus="" # if you dont need GPUs

share=/home/$USER/share
# Change to UID/GID of the local user who will run the container
u_id=1000
g_id=1000
port=8888 #start jupyter on this port and expose this port number in container
ports="-p $port:$port"

# change to the jupyterlab token you want
token=qwerty
#############################################

mkdir -p $share

docker pull $docker_image
docker run --rm -it -d $gpus -v ${share}:/share --name ${container_name} --hostname ${container_name} $ports -e TZ=Europe/London ${docker_image} /bin/bash
docker exec -u $u_id:$g_id ${container_name} /home/user/.conda/envs/jup/bin/jupyter lab --ip=0.0.0.0 --port=$port --NotebookApp.token=$token
