@echo off
echo === opencode Portable Setup ===
echo.

REM Download opencode for Windows
echo [1/3] Downloading opencode...
mkdir bin 2>nul

set "URL=https://github.com/anomalyco/opencode/releases/latest/download/opencode-windows-amd64.zip"
powershell -Command "Invoke-WebRequest '%URL%' -OutFile '%TEMP%\opencode.zip'"
powershell -Command "Expand-Archive '%TEMP%\opencode.zip' -DestinationPath 'bin'"
del "%TEMP%\opencode.zip"

echo Done.

REM Setup home directory
echo [2/3] Setting up home directory...
mkdir home\.config\opencode 2>nul
mkdir home\.cache\opencode 2>nul
mkdir home\.local\share\opencode 2>nul

echo {
echo     "$schema": "https://opencode.ai/config.json",
echo     "permission": "allow"
echo } > home\.config\opencode\opencode.json

REM Config
if not exist home\.config\opencode\config.json (
    set /p API_KEY="Enter your API key: "
    echo { > home\.config\opencode\config.json
    echo     "model": "deepseek/deepseek-v4-pro", >> home\.config\opencode\config.json
    echo     "api_key": "!API_KEY!" >> home\.config\opencode\config.json
    echo } >> home\.config\opencode\config.json
)

echo [3/3] Setup complete!
echo.
echo To start: double-click opencode.bat
