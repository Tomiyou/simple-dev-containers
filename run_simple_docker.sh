#!/bin/bash

CURRENT_USER="$(whoami)"

# Make sure we are given a container name
if [ -z "$1" ]; then
    echo "To create a docker container:  ./run_docker.sh \$container_name \$source_image"
    echo "To start a docker container:   ./run_docker.sh \$container_name [\$user]"
    echo "To cleanup a docker container: ./run_docker.sh remove \$container_name"
    exit 0
fi

if [[ "$1" == "remove" ]]; then
    if [[ -z $2 ]]; then
        echo "Please provide a container name: ./run_docker.sh remove \$container_name"
        exit 0
    fi
    IMAGE_NAME="$2_image"
    CONTAINER_NAME="$2_container"
    docker rm "$CONTAINER_NAME"
    docker rmi "$IMAGE_NAME"
    exit 0
fi

IMAGE_NAME="$1_image"
CONTAINER_NAME="$1_container"

# If a container with the given name exists, start it instead
EXISTING_CONTAINER=$(docker ps -aqf "name=$CONTAINER_NAME")
if [[ $EXISTING_CONTAINER ]]; then
    if [ "$( docker container inspect -f '{{.State.Running}}' $EXISTING_CONTAINER )" == "true" ]; then
        DOCKER_USER="${2:-$CURRENT_USER}"
        echo "Attaching to an existing docker container as $DOCKER_USER"
        docker exec --user $DOCKER_USER -it $EXISTING_CONTAINER /bin/bash
    else
        echo "Starting an existing docker container"
        docker start -a -i $EXISTING_CONTAINER
    fi

    exit 0
fi

# Make sure we are given source image name
if [ -z "$2" ]; then
    echo "Please provide a source image when running a container for the first time"
    exit 0
fi
SOURCE_IMAGE="$2"

# Build docker image
TMP_DOCKERFILE="/tmp/run_docker_$(date +%s)"
touch "$TMP_DOCKERFILE"

echo "FROM $SOURCE_IMAGE" >> "$TMP_DOCKERFILE"
echo "RUN useradd --create-home --shell /bin/bash $CURRENT_USER" >> "$TMP_DOCKERFILE"
echo "USER $CURRENT_USER" >> "$TMP_DOCKERFILE"
echo "WORKDIR /home/$CURRENT_USER" >> "$TMP_DOCKERFILE"
echo "CMD bash -i" >> "$TMP_DOCKERFILE"

docker build -t "$IMAGE_NAME" - < "$TMP_DOCKERFILE"

rm "$TMP_DOCKERFILE"

# Create docker container
CURRENT_PATH="$(pwd)"
CURRENT_DIRECTORY="$(basename $CURRENT_PATH)"

docker run --name $CONTAINER_NAME --tty --interactive \
    -v "$CURRENT_PATH:/home/$CURRENT_USER/$CURRENT_DIRECTORY" \
    $IMAGE_NAME
