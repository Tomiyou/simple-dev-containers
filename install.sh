#!/bin/bash
SCRIPT_NAME="simple-docker-run"
SCRIPT_PATH="$(pwd)/$SCRIPT_NAME"
SCRIPT_SYMLINK="$HOME/.local/bin/$SCRIPT_NAME"

if [ "$1" = "-u" ]; then
	echo "Uninstalling $SCRIPT_NAME"
	if [ -e "$SCRIPT_SYMLINK" ]; then
		rm $SCRIPT_SYMLINK
		sed -i '/simple-docker-run completions/d' "$HOME/.bashrc"
	fi
else
	echo "Installing $SCRIPT_NAME"
	if [ ! -e "$SCRIPT_SYMLINK" ]; then
		ln -s $SCRIPT_PATH $SCRIPT_SYMLINK
		echo $'which simple-docker-run &> /dev/null && eval "$(simple-docker-run completions)"' >> "$HOME/.bashrc"
	fi
fi