#!/bin/bash
# run_http_server.sh - Serve generated HTML documentation

set -e

# Source common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

# Dependency checks
require_uv

# Configuration
DOCS_HTML_DIR="${PROJECT_ROOT}/docs/_build/html"
PORT="${HTTP_PORT:-8000}"

echo ""
echo "============================================"
echo "Starting HTTP Server for Documentation"
echo "Project Root: ${PROJECT_ROOT}"
echo "============================================"
echo ""

# Check if documentation has been built
if [[ ! -d "${DOCS_HTML_DIR}" ]]; then
    print_error "Documentation not found at ${DOCS_HTML_DIR}"
    echo ""
    echo "  Build documentation first with:"
    echo "    ${PROJECT_ROOT}/scripts/build_doc.sh"
    echo ""
    exit 1
fi

if [[ ! -f "${DOCS_HTML_DIR}/index.html" ]]; then
    print_error "index.html not found. Documentation may not be fully built."
    exit 1
fi

print_info "Serving documentation from: ${DOCS_HTML_DIR}"
print_info "Server URL: http://localhost:${PORT}"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

cd "${DOCS_HTML_DIR}"
uv run python -m http.server "${PORT}"
