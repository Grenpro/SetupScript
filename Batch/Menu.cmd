:Start
test&cls
@echo off
color 1F

echo.
echo 1. Restart
echo 2. Mcafee and Cloud Link
echo 3. Office 365 Installer
echo 4. Auto Activator (CHECK THIS ON S MODE PC!!!)
echo 5. Windows Update
echo 6. Nvidia Driver Update
echo 7. AMD Driver Update
echo 8. Mcafee and Cloud Automation
echo 9. SuperCleanerv5
echo 10. Adwcleaner
echo 11. Startscript
echo 12. Programs
echo 13. Multicleaner
echo.

set /p choices=Enter choices separated by space (e.g., 1 3 5): 

for %%a in (%choices%) do (
    IF %%a==1 shutdown /r /t 5
    IF %%a==2 call start url.cmd
    IF %%a==3 call start officedownload365.cmd
    IF %%a==4 call start winkey.cmd
    IF %%a==5 call start powershell -executionpolicy remotesigned ..\Winupd\PS_WinUpdate.ps1
    IF %%a==6 call start powershell -executionpolicy remotesigned ..\NvidiaUpdater\nvidiadriver.cmd
    IF %%a==7 call start powershell -executionpolicy remotesigned ..\AMDUpdater\AMDDriver.cmd
    IF %%a==8 call start serverlogon.cmd
    IF %%a==9 call start SuperCleanerV5.cmd
    IF %%a==10 call start adwclean.cmd
    IF %%a==11 call start Startscript.cmd
    IF %%a==12 Programs.cmd
    IF %%a==13 call start ..\Multicleaner\Multiclean.cmd
)

test&cls
GOTO Start


