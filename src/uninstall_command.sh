
# Script will remove itself

sed -i '/simple-docker-run completions/d' "$HOME/.bashrc"

trap script_uninstall_itself EXIT
