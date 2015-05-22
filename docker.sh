#!/bin/bash

IMAGE_NAME=amurf/perl6-interactive
DOCKERFILE=$PWD/Dockerfile

case $1 in
    start)
        docker run -it $IMAGE_NAME /bin/bash
    ;;

    build)
        docker build -f $DOCKERFILE -t $IMAGE_NAME .
    ;;
esac

