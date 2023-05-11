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
# gpus=" --gpus all"
gpus="" # if you dont need GPUs

# do you want to share the local folder to the container?
  local_share=/home/$USER/share
  share="-v ${share}:/share"
# if not enable below line: 
  # share=""

port=8888 #start jupyter on this port and expose this port number in container
ports="-p $port:$port"

# get UID and GID defined in Dockerfile:
u_id=$(cat Dockerfile | grep "ARG uid" | cut -d'=' -f2)
g_id=u_id=$(cat Dockerfile | grep "ARG gid" | cut -d'=' -f2)

# change to the jupyterlab token you want
token=qwerty
#############################################

mkdir -p $share

docker run --rm -it -d $gpus $share --name ${container_name} --hostname ${container_name} $ports -e TZ=Europe/London ${docker_image} /bin/bash
docker exec -u $u_id:$g_id ${container_name} /home/user/.conda/envs/jup/bin/jupyter lab --ip=0.0.0.0 --port=$port --NotebookApp.token=$token
