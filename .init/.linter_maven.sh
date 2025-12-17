#!/usr/bin/env bash
set -euo pipefail
# Simple linter/build helper that uses Maven instead of Gradle after conversion.

# Move to workspace root of backend and run a quiet, fast build without tests to validate structure.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

echo "[linter] Using Maven to validate build..."
mvn -f "${REPO_ROOT}/springboot_backend/pom.xml" -q -DskipTests=true clean package

echo "[linter] Success."
