@echo off 
 
set DIRNAME=%%~dp0 
if "%%DIRNAME%%" == "" set DIRNAME=. 
set APP_BASE_NAME=%%~n0 
set APP_HOME=%%DIRNAME%% 
 
@rem Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass JVM options to this script. 
set DEFAULT_JVM_OPTS= 
 
@rem Find java.exe 
if defined JAVA_HOME goto findJavaFromJavaHome 
 
set JAVA_EXE=java.exe 
%%JAVA_EXE%% -version 
if "%0%" == "0" goto execute 
 
echo. 
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH. 
echo. 
echo Please set the JAVA_HOME variable in your environment to match the 
echo location of your Java installation. 
 
goto fail 
 
:findJavaFromJavaHome 
set JAVA_HOME=%C:\Program Files\Eclipse Adoptium\jdk-17.0.16.8-hotspot% 
set JAVA_EXE=%C:\Program Files\Eclipse Adoptium\jdk-17.0.16.8-hotspot%/bin/java.exe 
 
if exist "%%JAVA_EXE%%" goto execute 
 
echo. 
echo ERROR: JAVA_HOME is set to an invalid directory: %C:\Program Files\Eclipse Adoptium\jdk-17.0.16.8-hotspot% 
echo. 
echo Please set the JAVA_HOME variable in your environment to match the 
echo location of your Java installation. 
 
goto fail 
 
:execute 
@rem Setup the command line 
set CLASSPATH=%%APP_HOME%%\gradle\wrapper\gradle-wrapper.jar 
 
@rem Execute Gradle 
"%%JAVA_EXE%%" %%DEFAULT_JVM_OPTS%% -classpath "%%CLASSPATH%%" org.gradle.wrapper.GradleWrapperMain %%* 
 
:fail 
exit /b 1 
