:Start
test&cls
@echo off
color 1F

echo.
echo 1. Mcafee and Cloud Link
echo 2. Office 365 Installer
echo 3. Auto Activator (CHECK THIS ON S MODE PC!!!)
echo 4. Windows Update
echo 5. Nvidia Driver Update
echo 6. AMD Driver Update
echo 7. SuperCleanerv5
echo 8. Adwcleaner
echo 9. Startscript
echo 10. Programs
echo 11. Multicleaner
echo 12. Calling Card
echo 13. Cloud Autoinstaller
echo.

set /p choices=Enter choices separated by space (e.g., 1 3 5): 

for %%a in (%choices%) do (
    IF %%a==1 call start url.cmd
    IF %%a==2 call start officedownload365.cmd
    IF %%a==3 call start winkey.cmd
    IF %%a==4 call start powershell -executionpolicy remotesigned ..\Winupd\PS_WinUpdate.ps1
    IF %%a==5 call start powershell -executionpolicy remotesigned ..\NvidiaUpdater\nvidiadriver.cmd
    IF %%a==6 call start powershell -executionpolicy remotesigned ..\AMDUpdater\AMDDriver.cmd
    IF %%a==7 call start SuperCleanerV5.cmd
    IF %%a==8 call start adwclean.cmd
    IF %%a==9 call start Startscript.cmd
    IF %%a==10 Programs.cmd
    IF %%a==11 call start ..\Multicleaner\Multiclean.cmd
    IF %%a==12 call start callingcard.cmd
    IF %%a==13 call start jottaauto.cmd
)

test&cls
GOTO Start






