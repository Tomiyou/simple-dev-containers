#!/bin/bash

SCRIPT_PATH="$HOME/.local/bin/simple-docker-run"

# Download script and place it into local bin
curl https://raw.githubusercontent.com/Tomiyou/docker_image_runner/master/simple-docker-run --output "$SCRIPT_PATH"
chmod +x "$SCRIPT_PATH"

# Add bash completion to .bashrc
echo $'eval "$(simple-docker-run completions)"' >> "$HOME/.bashrc"
