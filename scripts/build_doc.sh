#!/bin/bash
# build_doc.sh - Build Sphinx documentation

set -e

# Source common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

# Dependency checks
require_uv

echo ""
echo "============================================"
echo "Building Sphinx & Sphinx-Needs Documentation"
echo "Project Root: ${PROJECT_ROOT}"
echo "============================================"
echo ""

cd "${PROJECT_ROOT}"

# Ensure dependencies are synced
print_info "Syncing Python dependencies..."
uv sync --quiet

# Build documentation
print_info "Generating documentation..."
uv run sphinx-build -a -E -W -b html docs docs/_build/html

echo ""
print_success "Documentation built successfully!"
echo "  Output: ${PROJECT_ROOT}/docs/_build/html/index.html"
