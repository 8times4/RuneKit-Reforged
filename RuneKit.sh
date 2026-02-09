#!/bin/bash
# RuneKit Launcher
# Double-click this file or run it from a terminal to start RuneKit

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

export PATH="$HOME/.local/bin:$PATH"

# Check for required system library (Qt6 xcb platform plugin)
if ! ldconfig -p 2>/dev/null | grep -q libxcb-cursor; then
    echo "Installing required system library (libxcb-cursor0)..."
    sudo apt install -y libxcb-cursor0
fi

# Check if poetry is installed
if ! command -v poetry &>/dev/null; then
    echo "Poetry not found. Installing via pipx..."
    pipx install poetry
fi

# Check if dependencies are installed
if [ ! -f "poetry.lock" ] || ! poetry env info -p &>/dev/null; then
    echo "Installing dependencies..."
    poetry install
fi

# Build resources if needed
if [ ! -f "runekit/_resources.py" ]; then
    echo "Building resources..."
    poetry run make runekit/_resources.py
fi

echo "Starting RuneKit..."
echo "Logs: ~/.config/cupco.de/RuneKit/logs/runekit.log"
exec poetry run python main.py "$@"
