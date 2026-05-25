@echo off
setlocal

:: Locate vswhere.exe
set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
if not exist "%VSWHERE%" set "VSWHERE=%ProgramFiles%\Microsoft Visual Studio\Installer\vswhere.exe"
if not exist "%VSWHERE%" (
    echo ERROR: vswhere.exe not found. Is Visual Studio installed?
    exit /b 1
)

:: Query the latest VS installation that has MSBuild
for /f "usebackq tokens=*" %%i in (
    `"%VSWHERE%" -latest -requires Microsoft.Component.MSBuild -property installationVersion`
) do set VS_VERSION=%%i

if "%VS_VERSION%"=="" (
    echo ERROR: No Visual Studio installation found.
    exit /b 1
)

:: Extract the major version number (e.g. "17.x.x" -> "17")
for /f "tokens=1 delims=." %%v in ("%VS_VERSION%") do set VS_MAJOR=%%v

:: Map major version
if "%VS_MAJOR%"=="16" (
    set "CMAKE_GEN=Visual Studio 16 2019"
    set "BUILD_DIR=build\msvc2019-x86"
) else if "%VS_MAJOR%"=="17" (
    set "CMAKE_GEN=Visual Studio 17 2022"
    set "BUILD_DIR=build\msvc2022-x86"
) else if "%VS_MAJOR%"=="18" (
    set "CMAKE_GEN=Visual Studio 18 2026"
    set "BUILD_DIR=build\msvc2026-x86"
) else (
    echo ERROR: Unrecognised Visual Studio major version: %VS_MAJOR%
    exit /b 1
)

echo Detected: %CMAKE_GEN% ^(version %VS_VERSION%^)
echo Build dir: %BUILD_DIR%
echo.

mkdir "%BUILD_DIR%" 2>nul
pushd "%BUILD_DIR%"
cmake -G "%CMAKE_GEN%" -A Win32 %* ../../code
popd
pause