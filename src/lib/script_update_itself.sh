SCRIPT_BASE_DIR="$HOME/.local/bin"
SCRIPT_PATH="$SCRIPT_BASE_DIR/simple-docker-run"

function script_update_itself {
    # Download script and place it into local bin
    mkdir -p "$SCRIPT_BASE_DIR"
    curl https://raw.githubusercontent.com/Tomiyou/docker_image_runner/master/simple-docker-run --output "$SCRIPT_PATH"
    chmod +x "$SCRIPT_PATH"
    echo "Script updated"
}
