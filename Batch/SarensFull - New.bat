@echo off

echo Running malware scan, please wait...

rem Run Windows Defender scan
"%ProgramFiles%\Windows Defender\mpcmdrun.exe" -scan

echo Scan complete.

echo Running DISM to repair the image and clean the image and winsxs folders, please wait...

rem Run DISM to repair the image and clean the image and winsxs folders
dism.exe /online /cleanup-image /restorehealth
dism.exe /online /cleanup-image /startcomponentcleanup
dism.exe /online /cleanup-image /spsuperseded

echo DISM repair and cleanup complete.

echo Running system file check, please wait...

rem Run System File Checker to repair any damaged system files
sfc /scannow

echo System file check complete.

echo Running disk cleanup, please wait...

rem Run Disk Cleanup to remove temporary files and other unnecessary system files
cleanmgr.exe /d C:

echo Disk cleanup complete.

echo Cleaning up temporary files and folders...

rem Remove temporary files and folders
rd /s /q "%USERPROFILE%\AppData\Local\Temp"
rd /s /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\Temporary Internet Files"
rd /s /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache"
rd /s /q "%WINDIR%\Temp"

echo Temporary file and folder cleanup complete.

echo Updating installed apps using winget, please wait...

rem Update installed apps using winget
winget update --all

echo App update complete.

echo Resetting Windows update components, please wait...

rem Reset Windows Update components
net stop wuauserv
net stop cryptSvc
net stop bits
net stop msiserver
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
ren C:\Windows\System32\catroot2 catroot2.old
net start wuauserv
net start cryptSvc
net start bits
net start msiserver

echo Windows update component reset complete.


@echo off

echo Downloading file from website, please wait...

rem Download file using bitsadmin
bitsadmin /transfer downloadJob /download /priority high https://adwcleaner.malwarebytes.com/adwcleaner?channel=release C:\adwcleaner.exe

echo Download complete.

echo Running file, please wait...

rem Run file
C:\adwcleaner.exe

echo File run complete.

echo Virus and malware cleanup complete. Please restart your computer to finish the cleanup process.

pause