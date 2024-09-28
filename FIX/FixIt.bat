@echo off
title Delete Files in Startup Folder

:: Check for administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Set the Startup folder path
set startupFolder="C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"

:: Check if the Startup folder exists
if not exist %startupFolder% (
    echo The Startup folder does not exist! Exiting...
    pause
    exit /b
)

:: Change directory to the Startup folder
cd /d %startupFolder%

:: Delete all files and folders in the Startup folder (including hidden)
for /f "delims=" %%f in ('dir /b /a-d') do (
    del /f /q "%%f"
)

for /f "delims=" %%d in ('dir /b /ad') do (
    rmdir /s /q "%%d"
)

:: Inform the user
echo All files and folders in %startupFolder% have been deleted.
pause
