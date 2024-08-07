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
simple-dev-containers create $CONTAINER_NAME $BASE_IMAGE
# Example:
simple-dev-containers create openwrt-build-container ubuntu:22.04
```
- Script automatically mounts the current directory under the same path:
```
/home/ubuntu/my/git/repo -> /home/ubuntu/my/git/repo
```
- Run the container using:
```
simple-dev-containers run $CONTAINER_NAME
# Example:
simple-dev-containers run openwrt-build-container
```
- Attach to running container as another user:
```
simple-dev-containers run $CONTAINER_NAME $USER
# Example:
simple-dev-containers run openwrt-build-container root
```
- Once you are done, clean all related Docker files using:
```
simple-dev-containers remove $CONTAINER_NAME
# Example:
simple-dev-containers remove openwrt-build-container
```

## Installation

Install the script using the following command:
```
curl https://raw.githubusercontent.com/Tomiyou/docker_image_runner/master/install.sh | bash
```
The script is installed under `$HOME/.local/bin/simple-dev-containers`

## Uninstall

Uninstall the script using the following command:
```
simple-dev-containers uninstall
```

## How to build script from source

To build the script from source we need Bashly, which is a CLI that lets you generate feature-rich bash command line tools.
```
alias bashly='docker run --rm -it --user $(id -u):$(id -g) --volume "$PWD:/app" dannyben/bashly'
```
Then simply run
```
bashly generate
bashly generate --upgrade
```
