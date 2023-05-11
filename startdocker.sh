#!/bin/bash
# run as sh ./startdocker.sh IMAGEID
################ params #########################

if [ -z "$1" ]; then
# change to another existing docker image name you have built with the provided Dockerfile
  docker_image="my/image:last"
else  
# if $1 exists supply imageid as an external parameter:
docker_image=$1
fi


# name to gove to your container:
container_name=${USER}_python3

# do you have GPUs? (Nvidia docker support plugin must be installed on the system), otherwise leave empty as gpus=""
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

docker run --rm -it -d $gpus -v ${share}:/share --name ${container_name} --hostname ${container_name} $ports -e TZ=Europe/London ${docker_image} /bin/bash
docker exec -u $u_id:$g_id ${container_name} /home/user/.conda/envs/jup/bin/jupyter lab --ip=0.0.0.0 --port=$port --NotebookApp.token=$token
