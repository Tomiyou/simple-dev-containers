
function script_uninstall_itself {
    echo "Uninstalling myself :)"
    shred -u "$SCRIPT_PATH"
}
