#!/bin/bash
cd /home/kavia/workspace/code-generation/aws-containerized-springboot-configuration-manager-1738-1747/springboot_backend
./gradlew checkstyleMain
LINT_EXIT_CODE=$?
if [ $LINT_EXIT_CODE -ne 0 ]; then
   exit 1
fi

