@echo off
echo ===================================================
echo Building Time-Tracker Linux Binaries via Docker
echo ===================================================

:: Ensure Docker is running
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Docker is not installed or not running. Please start Docker Desktop.
    exit /b 1
)

:: Run electron-builder inside the official builder container
echo Running electron-builder via Docker...
docker run --rm -ti ^
  -v "%cd%:/project" ^
  -v "%cd%/.npm-cache:/root/.npm" ^
  electronuserland/builder:20 ^
  sh -c "npm ci && npm run build"

if %errorlevel% neq 0 (
    echo.
    echo Build failed! Check the errors above.
    exit /b %errorlevel%
)

echo.
echo ===================================================
echo Build Successful!
echo Linux packages (.deb and .AppImage) are in:
echo %cd%\dist
echo ===================================================
pause
