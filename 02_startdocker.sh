#!/bin/bash
# run as "sh ./startdocker.sh IMAGEID"
################ params #########################

if [ -z "$1" ]; then
# change to another existing docker image name you have built with the provided Dockerfile
  docker_image="my/image:last"
else  
# if $1 exists supply imageid as an external parameter:
docker_image=$1
fi


# name to give to your container:
container_name=${USER}_python3
# remove previously created containers with the same name:
docker rm -f $container_name


# do you have GPUs? (Nvidia docker support plugin must be installed on the system), otherwise leave empty as gpus=""
# gpus=" --gpus all"
gpus="" # if you dont need GPUs

# do you want to share the local folder to the container?
  local_share=$HOME/share
  share="-v ${local_share}:/share"
  mkdir -p $local_share
# if no share needed, enable the below line: 
  # share=""

port=8888 #start jupyter on this port and expose this port number in container
ports="-p $port:$port"

# get UID and GID defined in Dockerfile:
u_id=$(cat Dockerfile | grep "ARG uid" | cut -d'=' -f2)
g_id=$(cat Dockerfile | grep "ARG gid" | cut -d'=' -f2)
user=$(cat Dockerfile | grep "ARG user" | cut -d'=' -f2)
pass=$(cat Dockerfile | grep "ARG pass" | cut -d'=' -f2)
# venv name we created in Dockerfile
venv=$(cat Dockerfile | grep "ARG venv" | cut -d'=' -f2)

# change the jupyterlab token if you want
token=$pass
#############################################

docker run --rm -it -d $gpus $share --name ${container_name} --hostname ${container_name} $ports -e TZ=Europe/London ${docker_image} /bin/bash
docker exec -u $u_id:$g_id ${container_name} /home/$user/.conda/envs/$venv/bin/jupyter lab --ip=0.0.0.0 --port=$port --NotebookApp.token=$token
