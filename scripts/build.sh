#!/bin/bash
# build.sh - Full build: documentation + C++ project + tests

set -e

# Source common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

# Dependency checks
print_info "Checking dependencies..."
require_uv
require_cmake
require_cpp_compiler
print_success "All dependencies available"

echo ""
echo "============================================"
echo "Full Build: C++ Project + Documentation"
echo "Project Root: ${PROJECT_ROOT}"
echo "============================================"
echo ""

# Build C++ project
"${PROJECT_ROOT}/scripts/build_app.sh"

# Build documentation
"${PROJECT_ROOT}/scripts/build_doc.sh"

echo ""
print_success "Full build completed successfully!"
