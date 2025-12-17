@ECHO OFF
SETLOCAL
SET MVNW_DIR=%~dp0
SET WRAPPER_DIR=%MVNW_DIR%\.mvn\wrapper
SET JAR=%WRAPPER_DIR%\maven-wrapper.jar
SET PROPS=%WRAPPER_DIR%\maven-wrapper.properties

IF NOT EXIST "%WRAPPER_DIR%" MKDIR "%WRAPPER_DIR%"

FOR /F "tokens=1* delims==" %%A IN ('findstr "^wrapperUrl=" "%PROPS%"') DO SET WRAPPER_URL=%%B
FOR /F "tokens=1* delims==" %%A IN ('findstr "^distributionUrl=" "%PROPS%"') DO SET DIST_URL=%%B

IF NOT EXIST "%JAR%" (
  ECHO [mvnw] Downloading Maven Wrapper jar from %WRAPPER_URL%
  powershell -Command "Invoke-WebRequest -Uri '%WRAPPER_URL%' -OutFile '%JAR%'"
)

SET DIST_DIR=%WRAPPER_DIR%\dists
FOR %%I IN ("%DIST_URL%") DO SET "DIST_NAME=%%~nI"
SET INSTALL_DIR=%DIST_DIR%\%DIST_NAME%

IF NOT EXIST "%INSTALL_DIR%" (
  IF NOT EXIST "%DIST_DIR%" MKDIR "%DIST_DIR%"
  SET TMP_ZIP=%TEMP%\mvnw-dist.zip
  ECHO [mvnw] Downloading Maven distribution from %DIST_URL%
  powershell -Command "Invoke-WebRequest -Uri '%DIST_URL%' -OutFile '%TMP_ZIP%'"
  powershell -Command "Expand-Archive -Path '%TMP_ZIP%' -DestinationPath '%DIST_DIR%' -Force"
  DEL /Q "%TMP_ZIP%"
  FOR /D %%D IN ("%DIST_DIR%\apache-maven-*") DO (
    IF /I NOT "%%~fD"=="%INSTALL_DIR%" (
      MOVE "%%~fD" "%INSTALL_DIR%" >NUL
      GOTO :doneMove
    )
  )
  :doneMove
)

SET MVN_BIN=%INSTALL_DIR%\bin\mvn.cmd
"%MVN_BIN%" %*
ENDLOCAL
