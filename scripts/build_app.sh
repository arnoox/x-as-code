#!/bin/bash
# build_app.sh - Build C++ project and run tests

set -e

# Source common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

# Dependency checks
require_cmake
require_cpp_compiler

# Configuration
COVERAGE_ENABLED=${ENABLE_COVERAGE:-false}
SRC_DIR="${PROJECT_ROOT}/src"
BUILD_DIR="${SRC_DIR}/build"

echo ""
echo "============================================"
echo "Building C++ project with CMake"
echo "Project Root: ${PROJECT_ROOT}"
echo "Coverage enabled: ${COVERAGE_ENABLED}"
echo "============================================"
echo ""

# Navigate to source directory
cd "${SRC_DIR}"

# Configure CMake
if [ "${COVERAGE_ENABLED}" = "true" ]; then
    check_lcov || true  # Warn if lcov not available but continue
    print_info "Configuring with coverage support..."
    cmake -S . -B build -DENABLE_COVERAGE=ON
else
    print_info "Configuring without coverage..."
    cmake -S . -B build
fi

# Build the project
echo ""
print_info "Compiling C++ project..."
cmake --build build

# Run tests
echo ""
print_info "Running C++ tests..."
cd build
./eac_test --gtest_output=xml:test-results.xml

# Generate coverage report if enabled
if [ "${COVERAGE_ENABLED}" = "true" ]; then
    echo ""
    print_info "Generating coverage report..."

    # Check if coverage target exists
    if make -n coverage &>/dev/null; then
        make coverage

        echo ""
        echo "============================================"
        print_success "Coverage report generated!"
        echo "  Open: ${BUILD_DIR}/coverage_html/index.html"
        echo "============================================"
    else
        print_warning "Coverage target not available."
        echo "  Make sure lcov and genhtml are installed:"
        echo "    macOS: brew install lcov"
        echo "    Linux: sudo apt-get install lcov"
        echo ""
        echo "  Coverage data files (.gcda, .gcno) are generated and can be"
        echo "  processed manually or with other coverage tools."
    fi
fi

echo ""
print_success "Build and tests completed successfully!"
