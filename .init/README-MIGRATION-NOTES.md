# Migration Notes: Gradle -> Maven

- The backend module `springboot_backend` now builds with Maven.
- If any existing automation referenced `./gradlew`, a small compatibility shim has been added at the workspace root to avoid failures. It builds the Maven module.
- Preferred commands:
  - Build: `mvn -f springboot_backend/pom.xml clean package -DskipTests=true`
  - Test: `mvn -f springboot_backend/pom.xml test`
  - Run: `mvn -f springboot_backend/pom.xml spring-boot:run -Dspring-boot.run.jvmArguments="-Dserver.port=3001"`
