
get_container_image_name "${args[container_name]}"
SOURCE_IMAGE="${args[source_image]}"

# Create temporary Dockerfile
TMP_DOCKERFILE="/tmp/simple_docker_run_$(date +%s)"
touch "$TMP_DOCKERFILE"

echo "FROM $SOURCE_IMAGE" >> "$TMP_DOCKERFILE"
echo "LABEL simple_docker_run='true'" >> "$TMP_DOCKERFILE"
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

# Remove tepmporary Dockerfile
rm "$TMP_DOCKERFILE"

# Create a docker container using the built image
CURRENT_PATH="$(pwd)"
CURRENT_DIRECTORY="$(basename $CURRENT_PATH)"

docker run --name $CONTAINER_NAME --tty --interactive \
    -v "$CURRENT_PATH:/home/$CURRENT_USER/$CURRENT_DIRECTORY" \
    $IMAGE_NAME
