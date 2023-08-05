
get_container_image_name "${args[container_name]}"
SOURCE_IMAGE="${args[source_image]}"

# Create temporary Dockerfile
TMP_DOCKERFILE="/tmp/simple_docker_run_$(date +%s)"
touch "$TMP_DOCKERFILE"

cat > "$TMP_DOCKERFILE" <<- EOF
FROM $SOURCE_IMAGE

# Label tells us which containers were created by this script
LABEL simple_docker_run='true'

RUN apt-get update
RUN apt-get install -y git fakeroot build-essential ncurses-dev \\
    xz-utils libssl-dev bc flex libelf-dev bison gcc llvm clang curl \\
    wget vim

RUN useradd --create-home --shell /bin/bash $CURRENT_USER
USER $CURRENT_USER
WORKDIR /home/$CURRENT_USER

CMD bash -i
EOF

# Build docker image
docker build -t "$IMAGE_NAME" - < "$TMP_DOCKERFILE"

# Remove temporary Dockerfile
rm "$TMP_DOCKERFILE"

# Create a docker container using the built image
CURRENT_PATH="$(pwd)"
CURRENT_DIRECTORY="$(basename $CURRENT_PATH)"

docker run --name $CONTAINER_NAME --tty --interactive \
    -v "$CURRENT_PATH:/home/$CURRENT_USER/$CURRENT_DIRECTORY" \
    $IMAGE_NAME
