#!/bin/bash

SCRIPT_BASE_DIR="$HOME/.local/bin"
mkdir -p "$SCRIPT_BASE_DIR"
SCRIPT_PATH="$SCRIPT_BASE_DIR/simple-dev-containers"

# Download script and place it into local bin
curl https://raw.githubusercontent.com/Tomiyou/docker_image_runner/master/simple-dev-containers --output "$SCRIPT_PATH"
chmod +x "$SCRIPT_PATH"

# Add bash completion to .bashrc
echo $'which simple-dev-containers &> /dev/null && eval "$(simple-dev-containers completions)"' >> "$HOME/.bashrc"
