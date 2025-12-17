#!/usr/bin/env bash
# Apache Maven Wrapper startup script, simplified for CI usage.
# Fix: ensure correct extraction path and mvn binary resolution.

set -euo pipefail

MVNW_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WRAPPER_DIR="${MVNW_DIR}/.mvn/wrapper"
JAR="${WRAPPER_DIR}/maven-wrapper.jar"
PROPS="${WRAPPER_DIR}/maven-wrapper.properties"

# Ensure wrapper jar exists; download if missing
if [ ! -f "${JAR}" ]; then
  mkdir -p "${WRAPPER_DIR}"
  WRAPPER_URL=$(grep -E '^wrapperUrl=' "${PROPS}" | cut -d'=' -f2-)
  echo "[mvnw] Downloading Maven Wrapper jar from ${WRAPPER_URL}"
  curl -fsSL "${WRAPPER_URL}" -o "${JAR}"
fi

# Ensure Maven distribution exists; download if missing
DIST_URL=$(grep -E '^distributionUrl=' "${PROPS}" | cut -d'=' -f2-)
DIST_DIR="${WRAPPER_DIR}/dists"

if [ ! -d "${DIST_DIR}" ]; then
  mkdir -p "${DIST_DIR}"
fi

# Download and extract Maven distribution under dists/apache-maven-<ver>
TMP_ZIP="$(mktemp)"
echo "[mvnw] Downloading Maven distribution from ${DIST_URL}"
curl -fsSL "${DIST_URL}" -o "${TMP_ZIP}"

# Determine final extraction folder name (apache-maven-<ver>)
ZIP_BASENAME="$(basename "${DIST_URL}" .zip)"
# Expected inner dir inside the zip is "apache-maven-<ver>"
EXPECTED_DIR_NAME="${ZIP_BASENAME%-bin}" # strip trailing '-bin'
EXTRACT_ROOT="${DIST_DIR}"

# Extract
unzip -q -o "${TMP_ZIP}" -d "${EXTRACT_ROOT}"
rm -f "${TMP_ZIP}"

MVN_HOME="${EXTRACT_ROOT}/${EXPECTED_DIR_NAME}"
MVN_BIN="${MVN_HOME}/bin/mvn"

if [ ! -x "${MVN_BIN}" ]; then
  echo "[mvnw] ERROR: mvn binary not found at ${MVN_BIN}"
  echo "[mvnw] Listing extracted directories for debugging:"
  ls -la "${EXTRACT_ROOT}" || true
  # Try to find mvn fallback
  FOUND_MVN="$(find "${EXTRACT_ROOT}" -type f -path "*/bin/mvn" | head -n1 || true)"
  if [ -n "${FOUND_MVN}" ]; then
    MVN_BIN="${FOUND_MVN}"
  else
    echo "[mvnw] Failed to locate mvn binary. Exiting."
    exit 127
  fi
fi

exec "${MVN_BIN}" "$@"
