:: Script: `.\Wise-Astrology-Calc.Bat`

:: Initialization
@echo off
setlocal enabledelayedexpansion
title Wise-Astrology-Calc
set "scriptTitle=Wise-Astrology-Calc"
color 80
echo Initialization Complete.
timeout /t 1 >nul

:: Skip past headers and function definitions
goto :main_logic

:: Function to print a header
:printHeader
echo ========================================================================================================================
echo    %~1
echo ========================================================================================================================
goto :eof

:: Main Logic
:main_logic
:: DP0 TO SCRIPT BLOCK, DO NOT, MODIFY or MOVE: START
set "ScriptDirectory=%~dp0"
set "ScriptDirectory=%ScriptDirectory:~0,-1%"
cd /d "%ScriptDirectory%"
echo Dp0'd to Script.
:: DP0 TO SCRIPT BLOCK, DO NOT, MODIFY or MOVE: END

:: CHECK ADMIN BLOCK, DO NOT, MODIFY or MOVE: START transcribe this section as is
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo Error: This script requires administrator privileges.
    echo Please right-click the script and select 'Run as Administrator'.
    timeout /t 3 >nul
    goto :end_of_file
)
echo Status: Administrator
timeout /t 1 >nul
:: CHECK ADMIN BLOCK, DO NOT, MODIFY or MOVE: END

:: Script Execution Section
:main_logic_part2
cls
call :printHeader "Run %scriptTitle%"
echo.
echo Launching `launcher.ps1`...
echo.
powershell -ExecutionPolicy Bypass -File .\launcher.ps1
echo ...`launcher.ps1` exited.
pause
goto :end_of_file

:end_of_file
cls  :: do not remove line
call :printHeader "Exit %scriptTitle%"
echo.
timeout /t 1 >nul
echo Exiting %scriptTitle%
timeout /t 1 >nul
echo All processes finished.
timeout /t 1 >nul
exit /b