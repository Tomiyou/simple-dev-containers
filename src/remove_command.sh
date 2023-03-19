
IMAGE_NAME="${args[container_name]}_image"
CONTAINER_NAME="${args[container_name]}_container"

echo "Removing container $CONTAINER_NAME"
docker rm "$CONTAINER_NAME"
remove_container_from_cache "$CONTAINER_NAME"

echo "Removing image $IMAGE_NAME"
docker rmi "$IMAGE_NAME"
remove_image_from_cache "$IMAGE_NAME"
