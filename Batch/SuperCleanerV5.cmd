@echo off

powercfg -change -standby-timeout-ac 0
powercfg -change -monitor-timeout-ac 0

:: Set log file path
set LOGFILE=C:\maintenance_report.txt

:: Create or clear the log file
echo Maintenance Report - %date% %time% > "%LOGFILE%"
echo =============================== >> "%LOGFILE%"

:: Check for administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrative privileges. Please run as administrator.
    pause
    exit /b
)

echo Running malware scan, please wait...
echo Running malware scan... >> "%LOGFILE%"

rem Run Windows Defender scan if available
if exist "%ProgramFiles%\Windows Defender\mpcmdrun.exe" (
    "%ProgramFiles%\Windows Defender\mpcmdrun.exe" -scan
    if %errorlevel% neq 0 (
        echo Windows Defender scan encountered an error. >> "%LOGFILE%"
    ) else (
        echo Malware scan completed successfully. >> "%LOGFILE%"
    )
) else (
    echo Windows Defender not found, skipping malware scan. >> "%LOGFILE%"
)

echo Scan complete.

echo Running DISM to repair the image and clean the image and winsxs folders, please wait...
echo Running DISM repair... >> "%LOGFILE%"

rem Run DISM to repair the image and clean components
dism.exe /online /cleanup-image /restorehealth
if %errorlevel% neq 0 (
    echo DISM restorehealth encountered an error. >> "%LOGFILE%"
) else (
    echo DISM repair completed successfully. >> "%LOGFILE%"
)
dism.exe /online /cleanup-image /startcomponentcleanup
echo DISM cleanup completed. >> "%LOGFILE%"

echo DISM repair and cleanup complete.

echo Running system file check, please wait...
echo Running System File Checker... >> "%LOGFILE%"

rem Run System File Checker
sfc /scannow
if %errorlevel% neq 0 (
    echo SFC encountered an error. >> "%LOGFILE%"
) else (
    echo System file check completed successfully. >> "%LOGFILE%"
)

echo System file check complete.

echo Running disk cleanup, please wait...
echo Running Disk Cleanup... >> "%LOGFILE%"

rem Run Disk Cleanup silently
cleanmgr.exe /sagerun:1
echo Disk cleanup completed. >> "%LOGFILE%"

echo Disk cleanup complete.

echo Clearing event logs...
echo Clearing event logs... >> "%LOGFILE%"
for /F "tokens=*" %%G in ('wevtutil el') DO (
    wevtutil cl "%%G"
)
echo Event logs cleared. >> "%LOGFILE%"

echo Clearing Windows Update cache...
echo Clearing Windows Update cache... >> "%LOGFILE%"
net stop wuauserv
rd /s /q "C:\Windows\SoftwareDistribution\Download"
net start wuauserv
echo Windows Update cache cleared. >> "%LOGFILE%"

echo Clearing all but the most recent system restore point...
echo Clearing system restore points... >> "%LOGFILE%"
vssadmin delete shadows /for=c: /oldest
echo System restore points cleaned. >> "%LOGFILE%"

echo Removing unused Windows components...
echo Removing unused Windows components... >> "%LOGFILE%"
dism.exe /online /disable-feature /featurename:Printing-Foundation-InternetPrinting-Client /norestart
echo Unused components removed. >> "%LOGFILE%"

echo Cleaning up temporary files and folders...
echo Cleaning up temporary files... >> "%LOGFILE%"

rem Remove temporary files and folders
rd /s /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\Temporary Internet Files"
rd /s /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache"
rd /s /q "%WINDIR%\Temp"
echo Temporary file and folder cleanup complete. >> "%LOGFILE%"

echo Updating installed apps using winget, please wait...
echo Updating installed apps... >> "%LOGFILE%"

rem Check if winget is available and update apps if so
winget --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Winget not available, skipping app updates. >> "%LOGFILE%"
) else (
    winget update --all
    echo App updates completed. >> "%LOGFILE%"
)

echo App update complete.

echo Resetting Windows update components, please wait...
echo Resetting Windows Update components... >> "%LOGFILE%"

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
echo Windows update component reset complete. >> "%LOGFILE%"

echo Downloading file from website, please wait...
echo Downloading file... >> "%LOGFILE%"

rem Download file using PowerShell
powershell -Command "Invoke-WebRequest -Uri 'https://adwcleaner.malwarebytes.com/adwcleaner?channel=release' -OutFile 'C:\adwcleaner.exe'"

if %errorlevel% neq 0 (
    echo Download failed. >> "%LOGFILE%"
    exit /b
)

echo Download complete.

echo Running downloaded file, please wait...
echo Running downloaded file... >> "%LOGFILE%"

rem Run downloaded file
start /wait C:\adwcleaner.exe
echo Cleanup completed successfully. >> "%LOGFILE%"

echo Cleanup complete. Please restart your computer to finish the cleanup process.

call start power.cmd

echo Maintenance completed. Check the report at %LOGFILE%.
pause
