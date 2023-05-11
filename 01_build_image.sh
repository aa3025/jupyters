#!/bin/bash
# build image and start the container

docker build . -t my/image:last | tee build.log

# get id of the built image
image_id=$(tail -n1 build.log | cut -d' ' -f3)

# optionally upload to your dockerhub account
# docker logn
# docker push my/image:last

sh ./02_startdocker.sh $image_id
