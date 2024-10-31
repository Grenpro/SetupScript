:Start
test&cls
@echo off
color 1F

echo.
echo 1. Previous/Back
echo 2. Game Launchers (Epic Games, Steam, EA App, Ubisoft Connect)
echo 3. Browsers (Chrome, Firefox)
echo 4. OpenOffice
echo 5. LibreOffice
echo 6. Discord
echo 7. VLC
echo 8. Steam
echo 9. Epic Games
echo.

set /p choices=Enter choices separated by space (e.g., 1 3 5): 

for %%a in (%choices%) do (
    IF %%a==1 Menu.cmd
    IF %%a==2 call start powershell -executionpolicy remotesigned gamelaunchers.ps1
    IF %%a==3 call start ..\Winget\browser.bat
    IF %%a==4 winget install --id Apache.OpenOffice -e --silent
    IF %%a==5 winget install --id TheDocumentFoundation.LibreOffice -e --silent
    IF %%a==6 winget install --id Discord.Discord -e --silent
    IF %%a==7 winget install --id VideoLAN.VLC -e --silent
    IF %%a==8 winget install --id Valve.Steam -e --silent
    IF %%a==9 winget install --id EpicGames.EpicGamesLauncher -e --silent
)

test&cls
GOTO Start
