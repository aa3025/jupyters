#!/bin/bash
# build image and start the container

docker build . -t my/image:last | tee build.log

# get id of build image
image_id=$(tail -n1 build.log | cut -d' ' -f3)

sh ./02_startdocker.sh $image_id
