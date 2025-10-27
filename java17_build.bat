@echo off
echo ========================================
echo    JAVA 17 APK BUILD
echo ========================================

echo 1. Setting Java 17 environment...
set "JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.16.8-hotspot"
set "PATH=%JAVA_HOME%\bin;%PATH%"
set "PATH=C:\KeyLoggerApp\android-sdk\cmdline-tools\bin;%PATH%"

echo 2. Fixing SDK path...
echo sdk.dir=C:/KeyLoggerApp/android-sdk > local.properties

echo 3. Installing Android packages with Java 17...
echo y | sdkmanager.bat --sdk_root="C:\KeyLoggerApp\android-sdk" "platform-tools" "platforms;android-30" "build-tools;30.0.3"

echo 4. Building APK...
if exist "gradle-6.7.1" (
    gradle-6.7.1\bin\gradle.bat assembleDebug
) else (
    echo Downloading Gradle...
    powershell -Command "Invoke-WebRequest -Uri 'https://services.gradle.org/distributions/gradle-6.7.1-bin.zip' -OutFile 'gradle.zip'"
    powershell -Command "Expand-Archive -Path 'gradle.zip' -DestinationPath '.' -Force"
    del gradle.zip
    gradle-6.7.1\bin\gradle.bat assembleDebug
)

if %errorlevel% == 0 (
    echo.
    echo ========================================
    echo   ✅ BUILD SUCCESSFUL!
    echo ========================================
    echo 📱 APK: app\build\outputs\apk\debug\app-debug.apk
    echo.
    echo 🎉 FINALLY SUCCESS!
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