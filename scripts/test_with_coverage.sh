#!/bin/bash
# test_with_coverage.sh - Build and run tests with code coverage

set -e

# Source common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

# Dependency checks
require_cmake
require_cpp_compiler

echo ""
echo "============================================"
echo "Building with Code Coverage"
echo "Project Root: ${PROJECT_ROOT}"
echo "============================================"
echo ""

# Check for coverage tools
if ! check_lcov; then
    echo ""
    print_warning "Coverage report generation may fail without lcov/genhtml"
    echo ""
fi

# Run build with coverage enabled
export ENABLE_COVERAGE=true
"${PROJECT_ROOT}/scripts/build_app.sh"

echo ""
echo "============================================"
echo "Coverage Summary"
echo "============================================"

# Display summary if lcov is available
BUILD_DIR="${PROJECT_ROOT}/src/build"
if command -v lcov &>/dev/null && [[ -f "${BUILD_DIR}/coverage_filtered.info" ]]; then
    cd "${BUILD_DIR}"
    lcov --list coverage_filtered.info 2>/dev/null || true
fi

echo ""
print_success "Coverage build completed!"
echo "  Open: ${BUILD_DIR}/coverage_html/index.html"
