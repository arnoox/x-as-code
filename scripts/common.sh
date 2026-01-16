#!/bin/bash
# common.sh - Shared utilities for x-as-code build scripts
#
# This script provides:
# - Project root detection (works in devcontainer and locally)
# - Dependency checking with helpful error messages
# - Colored output helpers
#
# Usage: Source this file at the top of other scripts
#   SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
#   source "${SCRIPT_DIR}/common.sh"

set -e

# =============================================================================
# Colored Output Helpers
# =============================================================================

print_error() { echo -e "\033[0;31mERROR:\033[0m $*" >&2; }
print_warning() { echo -e "\033[0;33mWARNING:\033[0m $*" >&2; }
print_info() { echo -e "\033[0;34mINFO:\033[0m $*"; }
print_success() { echo -e "\033[0;32m✓\033[0m $*"; }

# =============================================================================
# Project Root Detection
# =============================================================================

# Detect project root using multiple strategies:
# 1. If SCRIPT_HOME is already set (backward compatibility), use it
# 2. Try to find project root relative to this script's location
# 3. Use git to find repository root
# 4. Fall back to current directory if pyproject.toml exists
detect_project_root() {
    # Strategy 1: Environment variable override (backward compatibility)
    if [[ -n "${SCRIPT_HOME:-}" ]] && [[ -d "${SCRIPT_HOME}" ]]; then
        echo "${SCRIPT_HOME}"
        return 0
    fi

    # Strategy 2: Relative to script location (parent of scripts/)
    local script_dir
    script_dir="$(cd "$(dirname "${BASH_SOURCE[1]:-${BASH_SOURCE[0]}}")" && pwd)"
    local potential_root
    potential_root="$(dirname "${script_dir}")"

    if [[ -f "${potential_root}/pyproject.toml" ]]; then
        echo "${potential_root}"
        return 0
    fi

    # Strategy 3: Git repository root
    if command -v git &>/dev/null; then
        local git_root
        git_root="$(git rev-parse --show-toplevel 2>/dev/null)" || true
        if [[ -n "${git_root}" ]] && [[ -f "${git_root}/pyproject.toml" ]]; then
            echo "${git_root}"
            return 0
        fi
    fi

    # Strategy 4: Current directory
    if [[ -f "${PWD}/pyproject.toml" ]]; then
        echo "${PWD}"
        return 0
    fi

    # Failed to detect
    print_error "Could not detect project root."
    echo "  Please run from project directory or set SCRIPT_HOME environment variable." >&2
    return 1
}

# Export PROJECT_ROOT for use by all scripts
PROJECT_ROOT="$(detect_project_root)"
export PROJECT_ROOT

# =============================================================================
# Dependency Checking
# =============================================================================

# Check if uv is installed, with helpful installation message
require_uv() {
    # Try sourcing uv environment if it exists
    if [[ -f "$HOME/.local/bin/env" ]]; then
        # shellcheck source=/dev/null
        source "$HOME/.local/bin/env" 2>/dev/null || true
    fi

    if ! command -v uv &>/dev/null; then
        print_error "uv (Python package manager) is not installed."
        echo ""
        echo "  Install uv with:"
        echo "    curl -LsSf https://astral.sh/uv/install.sh | sh"
        echo ""
        echo "  Or on macOS with Homebrew:"
        echo "    brew install uv"
        echo ""
        return 1
    fi
    return 0
}

# Check if cmake is installed
require_cmake() {
    if ! command -v cmake &>/dev/null; then
        print_error "cmake is not installed."
        echo ""
        echo "  Install cmake with:"
        echo "    macOS:  brew install cmake"
        echo "    Ubuntu: sudo apt-get install cmake"
        echo ""
        return 1
    fi
    return 0
}

# Check if a C++ compiler is available
require_cpp_compiler() {
    if ! command -v g++ &>/dev/null && ! command -v clang++ &>/dev/null; then
        print_error "No C++ compiler found (g++ or clang++)."
        echo ""
        echo "  Install a C++ compiler with:"
        echo "    macOS:  xcode-select --install"
        echo "    Ubuntu: sudo apt-get install g++"
        echo ""
        return 1
    fi
    return 0
}

# Check for lcov/genhtml (optional - returns 1 if missing but doesn't exit)
check_lcov() {
    if ! command -v lcov &>/dev/null || ! command -v genhtml &>/dev/null; then
        print_warning "lcov/genhtml not found. Coverage reports will not be generated."
        echo "  Install with:"
        echo "    macOS:  brew install lcov"
        echo "    Ubuntu: sudo apt-get install lcov"
        return 1
    fi
    return 0
}

# Check Python version meets minimum requirement
require_python() {
    local required_version="${1:-3.12}"

    if ! command -v python3 &>/dev/null; then
        print_error "Python 3 is not installed."
        return 1
    fi

    local version
    version=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")

    if ! python3 -c "import sys; exit(0 if sys.version_info >= tuple(map(int, '${required_version}'.split('.'))) else 1)"; then
        print_error "Python ${required_version}+ is required. Found Python ${version}."
        return 1
    fi
    return 0
}

# =============================================================================
# Directory Utilities
# =============================================================================

get_src_dir() { echo "${PROJECT_ROOT}/src"; }
get_docs_dir() { echo "${PROJECT_ROOT}/docs"; }
get_build_dir() { echo "${PROJECT_ROOT}/src/build"; }
get_docs_build_dir() { echo "${PROJECT_ROOT}/docs/_build"; }
get_scripts_dir() { echo "${PROJECT_ROOT}/scripts"; }
