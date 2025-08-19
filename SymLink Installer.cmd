@echo off

if "%1"=="admin" (
    echo Started with admin rights
) else (
    echo Requesting admin rights...
    powershell -Command "Start-Process 'cmd.exe' -ArgumentList '/c \"\"%~f0\" admin\"' -Verb RunAs"
    exit /b
)

title GTAV User Music Junction Creator

echo ============================================
echo     Choose GTA V version to install:
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

if exist %target_noquote% (
    echo.
    echo WARNING! User Music folder options (it may exist):
    echo %target_noquote%
    echo.
    echo You can:
    echo   [S] Skip (if folder is not exist)
    echo   [D] Delete it permanently
    echo   [B] Backup (rename to "User Music_bak")
    echo   [C] Cancel
    echo.

    choice /c SDBC /m "Choose action"

    if errorlevel 4 (
        echo Operation cancelled.
        pause
        exit /b
    ) else if errorlevel 3 (
        echo Creating backup...
        ren "%target_noquote%" "User Music_bak"
    ) else if errorlevel 2 (
        echo Deleting old folder...
        rmdir /s /q "%target_noquote%"
    ) else if errorlevel 1 (
        echo Skipped process.
    )
)

echo.
echo Creating junction...
mklink /j %target% "%~dp0User Music"

echo.
echo Done!
pause