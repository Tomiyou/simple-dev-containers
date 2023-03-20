
# Script will remove itself
SCRIPT_NAME="simple-docker-run"
SCRIPT_PATH="$(pwd)/$SCRIPT_NAME"
SCRIPT_SYMLINK="$HOME/.local/bin/$SCRIPT_NAME"

if [ -e "$SCRIPT_SYMLINK" ]; then
	rm $SCRIPT_SYMLINK
	sed -i '/simple-docker-run completions/d' "$HOME/.bashrc"
fi
trap script_uninstall_itself EXIT
