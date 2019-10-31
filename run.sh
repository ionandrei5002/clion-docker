#!/bin/bash

docker run --rm -it -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /home/andrei/dockerbuilds/clion-docker/.cache:/home/andrei/.cache \
    -v /home/andrei/dockerbuilds/clion-docker/.CLion2019.2:/home/andrei/.CLion2019.2 \
    -v /home/andrei/dockerbuilds/clion-docker/.java:/home/andrei/.java \
    -v /home/andrei/CLionProjects:/home/andrei/CLionProjects \
    clion-docker:latest
