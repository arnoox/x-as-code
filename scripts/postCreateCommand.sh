#!/bin/bash
# postCreateCommand.sh - Devcontainer post-create setup

set -e

echo ""
echo "============================================"
echo "Devcontainer Post-Create Setup"
echo "============================================"
echo ""

# Install uv if not already installed
if command -v uv &>/dev/null; then
    echo "uv is already installed: $(uv --version)"
else
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh

    # Add uv to PATH for this session
    export PATH="$HOME/.local/bin:$PATH"
fi

# Sync Python dependencies
echo ""
echo "Syncing Python dependencies..."
uv sync

echo ""
echo "============================================"
echo "Setup completed successfully!"
echo "============================================"
echo ""
echo "You can now run:"
echo "  ./scripts/build.sh      - Full build"
echo "  ./scripts/build_doc.sh  - Build documentation only"
echo "  ./scripts/build_app.sh  - Build C++ project only"
echo ""
