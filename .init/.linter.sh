#!/usr/bin/env bash
set -euo pipefail
# Linter/build script updated for Maven after Gradle->Maven migration.
# Uses Maven Wrapper (mvnw) so the CI environment doesn't need a preinstalled Maven.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

MVNW="${REPO_ROOT}/mvnw"
chmod +x "${MVNW}" || true

echo "[linter] Starting Maven (wrapper) validation build for springboot_backend..."
"${MVNW}" -f "${REPO_ROOT}/springboot_backend/pom.xml" -q -DskipTests=true clean package
echo "[linter] Maven validation completed successfully."
