#!/bin/bash

usage() {
    echo "Usage : $0 <archlinux|debian|redhat> [interactive]"
}


if [ $# -lt 1 ]
then
    usage
    exit 1
fi

TARGET=$1
DOCKER_OPTIONS=""
DOCKER_COMMAND=""

if [ $# -gt 1 ] && [ $2 == "interactive" ]
then
    echo "Docker will be started with interactive shell"
    DOCKER_OPTIONS="-it"
    DOCKER_COMMAND="/bin/bash"
fi

DOCKERFILE="Dockerfile_$1"
CONTAINER="repetier_install_$1"

if [ ! -f $DOCKERFILE ]
then
    echo "Unsupported system or syntax error"
    usage
    exit 1
fi

echo "Building image."
docker build -f $DOCKERFILE -t $CONTAINER ..
if [ $? -ne 0 ]
then
    echo "Error building container image, abort"
    exit 1
fi
echo "Starting container for target $1"
docker run $DOCKER_OPTIONS $CONTAINER $DOCKER_COMMAND

