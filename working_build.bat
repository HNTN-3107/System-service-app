@echo off
echo ========================================
echo    WORKING APK BUILD
echo ========================================

echo 1. Setting environment...
set "JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-8.0.462.8-hotspot"
set "PATH=%JAVA_HOME%\bin;%PATH%"
set "PATH=C:\KeyLoggerApp\android-sdk\cmdline-tools\bin;%PATH%"

echo 2. Setting SDK path...
echo sdk.dir=C:\\KeyLoggerApp\\android-sdk > local.properties

echo 3. Installing Android packages...
echo This will take 3-5 minutes...
echo y | sdkmanager.bat --sdk_root="C:\KeyLoggerApp\android-sdk" "platform-tools" "platforms;android-30" "build-tools;30.0.3"

echo 4. Downloading Gradle...
if not exist "gradle-6.7.1" (
    powershell -Command "Invoke-WebRequest -Uri 'https://services.gradle.org/distributions/gradle-6.7.1-bin.zip' -OutFile 'gradle.zip'"
    powershell -Command "Expand-Archive -Path 'gradle.zip' -DestinationPath '.' -Force"
    del gradle.zip
)

echo 5. Building APK...
gradle-6.7.1\bin\gradle.bat assembleDebug

if %errorlevel% == 0 (
    echo.
    echo ========================================
    echo   ✅ BUILD SUCCESSFUL!
    echo ========================================
    echo 📱 APK: app\build\outputs\apk\debug\app-debug.apk
    echo.
    echo 🎉 CONGRATULATIONS!
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