# aws-containerized-springboot-configuration-manager-1738-1747

Backend: Spring Boot (Maven)

Build and Run
- Package: mvn -f springboot_backend/pom.xml clean package
- Run (dev): mvn -f springboot_backend/pom.xml spring-boot:run -Pdev
- Run (prod jar): java -jar springboot_backend/target/springbootbackend-0.1.0.jar

Port
- The service is expected to run on port 3001.
- When using mvn spring-boot:run, the dev profile sets -Dserver.port=3001. You can override with SERVER_PORT or -Dserver.port.

Endpoints
- Base: /
- Docs redirect: /docs -> /swagger-ui.html (OpenAPI at /api-docs)
- Health: /health
- Info: /api/info

Notes
- Gradle build files and wrappers have been removed as part of the conversion to Maven.
- Dependencies include AWS SDK v2 (S3, Lambda, Secrets Manager, KMS) to match the project’s AWS integration goals.
- If you have automation/scripts that call ./gradlew in this workspace (e.g., .init/.linter.sh), update them to use Maven:
  - Build: mvn -f springboot_backend/pom.xml -q -DskipTests=true clean package
  - Test: mvn -f springboot_backend/pom.xml -q test
  - Run: mvn -f springboot_backend/pom.xml -q spring-boot:run -Dspring-boot.run.jvmArguments="-Dserver.port=3001"