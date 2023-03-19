
IMAGE_NAME="${args[container_name]}_image"
CONTAINER_NAME="${args[container_name]}_container"
SOURCE_IMAGE="${args[source_image]}"

# Create temporary Dockerfile
TMP_DOCKERFILE="/tmp/simple_docker_run_$(date +%s)"
touch "$TMP_DOCKERFILE"

echo "FROM $SOURCE_IMAGE" >> "$TMP_DOCKERFILE"
echo "RUN apt-get update" >> "$TMP_DOCKERFILE"
echo "RUN apt-get install -y git fakeroot build-essential ncurses-dev \
xz-utils libssl-dev bc flex libelf-dev bison gcc llvm clang curl \
wget vim" >> "$TMP_DOCKERFILE"
echo "RUN useradd --create-home --shell /bin/bash $CURRENT_USER" >> "$TMP_DOCKERFILE"
echo "USER $CURRENT_USER" >> "$TMP_DOCKERFILE"
echo "WORKDIR /home/$CURRENT_USER" >> "$TMP_DOCKERFILE"
echo "CMD bash -i" >> "$TMP_DOCKERFILE"

# Build docker image
docker build -t "$IMAGE_NAME" - < "$TMP_DOCKERFILE"
add_image_to_cache "$IMAGE_NAME"

# Remove tepmporary Dockerfile
rm "$TMP_DOCKERFILE"

# Create a docker container using the built image
CURRENT_PATH="$(pwd)"
CURRENT_DIRECTORY="$(basename $CURRENT_PATH)"

add_container_to_cache "$CONTAINER_NAME"
docker run --name $CONTAINER_NAME --tty --interactive \
    -v "$CURRENT_PATH:/home/$CURRENT_USER/$CURRENT_DIRECTORY" \
    $IMAGE_NAME
