
get_container_image_name "${args[container_name]}"
USER="${args[user]}"

echo "Given user $USER"

# If a container with the given name exists, start it instead
EXISTING_CONTAINER=$(docker ps -aqf "name=$CONTAINER_NAME")
if [[ $EXISTING_CONTAINER ]]; then
    if [ "$( docker container inspect -f '{{.State.Running}}' $EXISTING_CONTAINER )" == "true" ]; then
        DOCKER_USER="${USER:-$CURRENT_USER}"
        echo "Attaching to an existing docker container as $DOCKER_USER"
        docker exec --user $DOCKER_USER -it $EXISTING_CONTAINER /bin/bash
    else
        echo "Starting an existing docker container"
        docker start -a -i $EXISTING_CONTAINER
    fi
fi
