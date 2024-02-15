
# Script will remove itself

sed -i '/simple-dev-containers completions/d' "$HOME/.bashrc"

trap script_uninstall_itself EXIT
