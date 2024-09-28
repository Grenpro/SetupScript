:Start
test&cls
@echo off
echo Press Number Then Enter
@echo off
color 0A


echo.
echo 1.Runtimes
echo 2.Spotify
echo 3.Skype
echo 4.Discord
echo 5.Steam
echo 6.Itunes
echo 7.LibreOffice
echo 8.OpenOffice
echo 9.Zoom
echo 10.Teamviewer
echo 11.Back
echo.

set /p a=
IF %a%==1 call start C:\Users\Public\Startupscript\Ninites\runtime.exe
IF %a%==2 call start C:\Users\Public\Startupscript\Ninites\spotify.exe
IF %a%==3 call start C:\Users\Public\Startupscript\Ninites\skype.exe
IF %a%==4 call start C:\Users\Public\Startupscript\Ninites\discord.exe
IF %a%==5 call start C:\Users\Public\Startupscript\Ninites\steam.exe
IF %a%==6 call start C:\Users\Public\Startupscript\Ninites\itunes.exe
IF %a%==7 call start C:\Users\Public\Startupscript\Ninites\libre.exe
IF %a%==8 call start C:\Users\Public\Startupscript\Ninites\openoffice.exe
IF %a%==9 call start C:\Users\Public\Startupscript\Ninites\zoom.exe
IF %a%==10 call start C:\Users\Public\Startupscript\Ninites\teamviewer.exe
IF %a%==11 C:\Users\Public\Startupscript\Batch\menu.cmd

test&cls

GOTO Start

