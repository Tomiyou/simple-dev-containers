## Code here runs inside the initialize() function
## Use it for anything that you need to run before any other function, like
## setting environment variables:
## CONFIG_FILE=settings.ini
##
## Feel free to empty (but not delete) this file.

CURRENT_USER="$(whoami)"
LOCAL_CACHE="/home/$CURRENT_USER/.local/share/simple_docker_run"

mkdir -p "$LOCAL_CACHE"
