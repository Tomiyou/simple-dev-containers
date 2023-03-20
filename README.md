# Script for easily creating/running/cleaning docker containers
- Spin up Docker image in seconds as the current user by running:
```
simple-docker-run create $CONTAINER_NAME $BASE_IMAGE
```
- Script automatically mounts the current directory under:
```
$HOME/$curent_directory_name
```
- Run the container using:
```
simple-docker-run run $CONTAINER_NAME
```
- Attach to running container as another user (root) to install any additional packages:
```
simple-docker-run run $CONTAINER_NAME root
```
- Once you are done, clean all related Docker files using:
```
simple-docker-run remove $CONTAINER_NAME
```
- If you update source code, run the following commands to update the script:
```
bashly generate
bashly generate --upgrade
```

## Installation

Install the script using the following command:
```
curl https://raw.githubusercontent.com/Tomiyou/docker_image_runner/master/install.sh | bash
```
The script is installed under `$HOME/.local/bin/simple-docker-run`

## Uninstall

Uninstall the script using the following command:
```
simple-docker-run uninstall
```
