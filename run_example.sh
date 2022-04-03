#!/bin/bash

echo #################################################
echo #################################################
echo ### STARTING MAJESTIC CUSTOM CLOUD GAMING NOW ###
echo #################################################
echo #################################################

docker run --rm -dit --name steamcg --shm-size 256M -p 15800:5800 --volume=/tmp/.X11-unix:/tmp/.X11-unix --device=/dev/dri:/dev/dri --env="DISPLAY=$DISPLAY" --privileged --restart=unless-stopped -v steam:/steam mjsvcg
