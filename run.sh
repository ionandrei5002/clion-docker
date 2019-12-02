#!/bin/bash

cache="/home/andrei/dockerbuilds/clion-docker/.cache"
clion="/home/andrei/dockerbuilds/clion-docker/.CLion2019.3"
java="/home/andrei/dockerbuilds/clion-docker/.java"
projects="/home/andrei/CLionProjects"

if [ -d  "$cache" ]
then 
    echo "Directory $cache exists."
else
    mkdir -p $cache
    echo "Directory $cache created."
fi

if [ -d  "$clion" ]
then 
    echo "Directory $clion exists."
else
    mkdir -p $clion
    echo "Directory $clion created."
fi

if [ -d  "$java" ]
then 
    echo "Directory $java exists."
else
    mkdir -p $java
    echo "Directory $java created."
fi

if [ -d  "$projects" ]
then 
    echo "Directory $projects exists."
else
    mkdir -p $projects
    echo "Directory $projects created."
fi

docker run --rm -it -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $cache:/home/andrei/.cache \
    -v $clion:/home/andrei/.CLion2019.3 \
    -v $java:/home/andrei/.java \
    -v $projects:/home/andrei/CLionProjects \
    --env _JAVA_AWT_WM_NONREPARENTING=1 \
    --env AWT_TOOLKIT=MToolkit \
    clion-docker:latest
