:Start
test&cls
@echo off
color 1F

echo.
echo 1.Restart
echo 2.Delete Installation
echo 3.Ninite Installers
echo 4.Gaming Setups
echo 5.Mcafee and Cloud Link
echo 6.Office 365 Installer
echo 7.Auto Activator (CHECK THIS ON S MODE PC!!!)
echo 8.Windows Update
echo 9.Nvidia Driver Update
echo 10.Amd Driver Update
echo 11.Mcafee and Cloud Automation
echo.

set /p a=
IF %a%==1 shutdown /r /t 5
IF %a%==2 call start delete.cmd
IF %a%==3 ninites.cmd
IF %a%==4 gaming.cmd
IF %a%==5 call start url.cmd
IF %a%==6 call start officedownload365.cmd
IF %a%==7 call start winkey.cmd
IF %a%==8 call start powershell -executionpolicy remotesigned ..\Winupd\PS_WinUpdate.ps1
IF %a%==9 call start powershell -executionpolicy remotesigned ..\NvidiaUpdater\nvidiadriver.cmd
IF %a%==10 call start powershell -executionpolicy remotesigned ..\AMDUpdater\AMDDriver.cmd
IF %a%==11 call start serverlogon.cmd


test&cls

GOTO Start

