#!/usr/bin/env bash
# Compatibility shim: Gradle wrapper was removed after migrating to Maven.
# This shim prevents CI/scripts that still invoke ./gradlew from failing.
echo "[compat] Gradle wrapper removed. Delegating to Maven for backend module..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mvn -f "${SCRIPT_DIR}/springboot_backend/pom.xml" -q -DskipTests=true clean package
