:Start
test&cls
@echo off
color 1F

echo.
echo 1. Previous/Back
echo 2. Game Launchers (Epic Games, Steam, EA App, Ubisoft Connect)
echo 3. Browsers (Chrome & Firefox)
echo.

set /p choices=Enter choices separated by space (e.g., 1 3 5): 

for %%a in (%choices%) do (
    IF %%a==1 call start Menu.cmd
    IF %%a==2 call start powershell -executionpolicy remotesigned gamelaunchers.ps1
    IF %%a==3 call start ..\Winget\browser.cmd

)

test&cls
GOTO Start
