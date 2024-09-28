:Start
test&cls
@echo off
echo Press Number Then Enter
echo Fortnite Account: User: Knowhow@armyspy.com PW: Knowhow1
@echo off
color 0A


echo.
echo 1.Fortnite
echo 2.Minecraft
echo 3.Discord
echo 4.Steam
echo 5.Game Launchers
echo 6.Back
echo.

set /p a=
IF %a%==1 call start C:\Users\Public\Startupscript\Ninites\Epic.cmd
IF %a%==2 call start C:\Users\Public\Startupscript\Ninites\Minecraft.cmd
IF %a%==3 call start C:\Users\Public\Startupscript\Ninites\discord.exe
IF %a%==4 call start C:\Users\Public\Startupscript\Ninites\steam.exe
IF %a%==5 call start powershell -executionpolicy remotesigned C:\Users\Public\Startupscript\Batch\gamelauncher.ps1
IF %a%==6 C:\Users\Public\Startupscript\Batch\menu.cmd

test&cls

GOTO Start

