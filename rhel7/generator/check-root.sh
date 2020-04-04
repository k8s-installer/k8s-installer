if [ "$(id -u)" -ne 0 ]; then
    echo "ERROR: You must execute with sudo."
    exit 1
fi
