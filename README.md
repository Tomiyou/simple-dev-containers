# Script for easily creating development containers

* Extremely simple
* No configuration or json required
* Supports bash completion for easier use
* Current directory ($PWD) automatically mounted inside the container
* Keeps the same username and UID inside the container (permissions...)
* Default user has access to sudo, password is "password123"

Tested on Ubuntu, not sure how well other distros work.

### How to use

- Spin up Docker image in seconds as the current user by running:
```
simple-docker-run create $CONTAINER_NAME $BASE_IMAGE
# Example:
simple-docker-run create openwrt-build-container ubuntu:22.04
```
- Script automatically mounts the current directory under the same path:
```
/home/ubuntu/my/git/repo -> /home/ubuntu/my/git/repo
```
- Run the container using:
```
simple-docker-run run $CONTAINER_NAME
# Example:
simple-docker-run run openwrt-build-container
```
- Attach to running container as another user:
```
simple-docker-run run $CONTAINER_NAME $USER
# Example:
simple-docker-run run openwrt-build-container root
```
- Once you are done, clean all related Docker files using:
```
simple-docker-run remove $CONTAINER_NAME
# Example:
simple-docker-run remove openwrt-build-container
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
