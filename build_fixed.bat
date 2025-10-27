@echo off
echo ========================================
echo    BUILDING KEYLOGGER APK - FIXED
echo ========================================

echo 1. Setting Java environment...
set "JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-8.0.462.8-hotspot"
set "PATH=%JAVA_HOME%\bin;%PATH%"

echo 2. Downloading Gradle Wrapper...
if not exist "gradle\wrapper\gradle-wrapper.jar" (
    echo Downloading gradle-wrapper.jar...
    powershell -Command "Invoke-WebRequest -Uri 'https://github.com/gradle/gradle/raw/v6.7.1/gradle/wrapper/gradle-wrapper.jar' -OutFile 'gradle\wrapper\gradle-wrapper.jar'"
)

echo 3. Creating simple gradlew script...
(
echo @echo off
echo set "JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-8.0.462.8-hotspot"
echo "%%JAVA_HOME%%\bin\java.exe" -classpath "%%~dp0\gradle\wrapper\gradle-wrapper.jar" org.gradle.wrapper.GradleWrapperMain %%*
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
    pause
) else (
    echo.
    echo ========================================
    echo   ❌ BUILD FAILED!
    echo ========================================
    echo.
    pause
)