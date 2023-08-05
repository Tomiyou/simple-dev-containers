echo "Avaliable containers:"
docker ps -a --filter "label=simple_docker_run" --format '{{.Names}}'
