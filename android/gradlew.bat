@echo off
@rem ------------------------------------------------------------------------------
@rem Gradle start up script for Windows
@rem ------------------------------------------------------------------------------
setlocal

@rem ------------------------------------------------------------------------------
@rem Copyright 2011-2023 the original author or authors.
@rem
@rem Licensed under the Apache License, Version 2.0 (the "License");
@rem you may not use this file except in compliance with the License.
@rem You may obtain a copy of the License at
@rem
@rem      https://www.apache.org/licenses/LICENSE-2.0
@rem
@rem Unless required by applicable law or agreed to in writing, software
@rem distributed under the License is distributed on an "AS IS" BASIS,
@rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@rem See the License for the specific language governing permissions and
@rem limitations under the License.
@rem ------------------------------------------------------------------------------

@rem Determine the Java command to use to launch the JVM.
@if not "%JAVA_HOME%"=="" (
    @if exist "%JAVA_HOME%\jre\sh\java.exe" (
        @rem IBM's JDK on AIX uses "%JAVA_HOME%\jre\sh\java" as the system Java executable.
        set JAVACMD="%JAVA_HOME%\jre\sh\java.exe"
    ) else (
        set JAVACMD="%JAVA_HOME%\bin\java.exe"
    )
    @if not exist "%JAVACMD%" (
        echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
        echo.
        echo Please set the JAVA_HOME environment variable in your shell to the correct location of your Java Development Kit (JDK).
        exit /b 1
    )
) else (
    set JAVACMD=java.exe
)

@rem Determine the script directory.
@for /f "delims=" %%i in ("%~dp0") do set SCRIPT_DIR=%%i

@rem Determine the Gradle distribution properties.
set GRADLE_DIR=%SCRIPT_DIR%\gradle
set GRADLE_JAR=%GRADLE_DIR%\wrapper\gradle-wrapper.jar
set GRADLE_PROPERTIES=%GRADLE_DIR%\wrapper\gradle-wrapper.properties

@if not exist "%GRADLE_JAR%" (
    echo ERROR: Gradle wrapper JAR not found: %GRADLE_JAR%
    exit /b 1
)
@if not exist "%GRADLE_PROPERTIES%" (
    echo ERROR: Gradle wrapper properties not found: %GRADLE_PROPERTIES%
    exit /b 1
)

@rem Read the distributionUrl from gradle-wrapper.properties.
for /f "usebackq tokens=*" %%a in (`findstr /R /C:"^distributionUrl=" "%GRADLE_PROPERTIES%"`) do (
    set DISTRIBUTION_URL=%%a
)
for /f "delims== tokens=2*" %%a in ("%DISTRIBUTION_URL%") do set DISTRIBUTION_URL=%%a
set DISTRIBUTION_URL=%DISTRIBUTION_URL:^/=/%
set DISTRIBUTION_URL=%DISTRIBUTION_URL:%%\\=/%
if "%DISTRIBUTION_URL%"=="" (
    echo ERROR: distributionUrl not found in %GRADLE_PROPERTIES%
    exit /b 1
)

@rem Calculate the wrapper checksum, if present.
for /f "usebackq tokens=*" %%a in (`findstr /R /C:"^wrapperChecksum=" "%GRADLE_PROPERTIES%"`) do (
    set WRAPPER_CHECKSUM=%%a
)
for /f "delims== tokens=2*" %%a in ("%WRAPPER_CHECKSUM%") do set WRAPPER_CHECKSUM=%%a

@if not "%WRAPPER_CHECKSUM%"=="" (
    @rem Verify the checksum of the wrapper JAR.
    set CURRENT_CHECKSUM=
    for /f "usebackq" %%a in (`certutil -hashfile "%GRADLE_JAR%" SHA256 ^| findstr /B /C:"%GRADLE_JAR% SHA256 Hash:"`) do set CURRENT_CHECKSUM=%%a
    set CURRENT_CHECKSUM=%CURRENT_CHECKSUM:*SHA256 Hash:=%
    set CURRENT_CHECKSUM=%CURRENT_CHECKSUM: =%
    if not "%CURRENT_CHECKSUM%"=="%WRAPPER_CHECKSUM%" (
        echo ERROR: Gradle wrapper JAR checksum mismatch!
        echo Expected: %WRAPPER_CHECKSUM%
        echo Actual: %CURRENT_CHECKSUM%
        echo Please delete %GRADLE_JAR% and try again.
        exit /b 1
    )
)

@rem Determine the classpath.
set CLASSPATH=%GRADLE_JAR%

@rem Set Gradle options (optional).
set DEFAULT_JVM_OPTS=-Xmx64m -Xms64m
set GRADLE_OPTS=%GRADLE_OPTS% %DEFAULT_JVM_OPTS%

@rem Execute Gradle.
"%JAVACMD%" %GRADLE_OPTS% -classpath "%CLASSPATH%" org.gradle.wrapper.GradleWrapperMain %*
