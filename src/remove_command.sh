
get_container_image_name "${args[container_name]}"

echo "Removing container $CONTAINER_NAME"
docker rm "$CONTAINER_NAME"

echo "Removing image $IMAGE_NAME"
docker rmi "$IMAGE_NAME"
