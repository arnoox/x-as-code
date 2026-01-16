#!/bin/bash
# clean_all.sh - Remove all build artifacts

set -e

# Source common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

echo ""
echo "============================================"
echo "Cleaning Build Artifacts"
echo "Project Root: ${PROJECT_ROOT}"
echo "============================================"
echo ""

# Define directories to clean
BUILD_DIR="${PROJECT_ROOT}/src/build"
DOCS_BUILD_DIR="${PROJECT_ROOT}/docs/_build"

# Clean C++ build directory
if [[ -d "${BUILD_DIR}" ]]; then
    print_info "Removing ${BUILD_DIR}..."
    rm -rf "${BUILD_DIR}"
    print_success "C++ build artifacts removed"
else
    print_info "C++ build directory does not exist, skipping"
fi

# Clean documentation build directory
if [[ -d "${DOCS_BUILD_DIR}" ]]; then
    print_info "Removing ${DOCS_BUILD_DIR}..."
    rm -rf "${DOCS_BUILD_DIR}"
    print_success "Documentation build artifacts removed"
else
    print_info "Documentation build directory does not exist, skipping"
fi

echo ""
print_success "Clean completed!"
