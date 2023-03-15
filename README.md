# Script for easily creating/running/cleaning docker containers
- Spin up Docker image in seconds as the current user
- Attach to running container as another user (root) to install required packages: `./run_docker.sh \$container_name root`
- Automatically mounts the current directory under: `/home/$current_user/$curent_directory_name`
- Once you are done, clean all related Docker files using: `./run_docker.sh remove $container_name`
