@echo off

if "%1"=="admin" (
    echo Started with admin rights
) else (
    echo Requesting admin rights...
    powershell -Command "Start-Process 'cmd.exe' -ArgumentList '/c \"\"%~f0\" admin\"' -Verb RunAs"
    exit /b
)

title GTAV User Music Junction Uninstaller

echo ============================================
echo     Choose GTA V version to uninstall:
echo ============================================
echo [1] GTAV Legacy
echo [2] GTAV Enhanced
echo.

set /p choice=Enter number (1 or 2): 

if "%choice%"=="1" (
    set target="C:\Users\%USERNAME%\Documents\Rockstar Games\GTAV\User Music"
) else if "%choice%"=="2" (
    set target="C:\Users\%USERNAME%\Documents\Rockstar Games\GTAV Enhanced\User Music"
) else (
    echo Invalid choice!
    pause
    exit /b
)

set target_noquote=%target:"=%
rmdir /s /q "%target_noquote%"

echo.
echo Done!
pause