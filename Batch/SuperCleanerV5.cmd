@echo off
:: Set Power configuration to prevent sleep/hibernate during script execution
powercfg -change -standby-timeout-ac 0
powercfg -change -monitor-timeout-ac 0

:: Set log file path
set LOGFILE=C:\maintenance_report.txt
set SCRIPT_START_TIME=%time%

:: Create or clear the log file
echo Maintenance Report (Quick Version) - %date% %SCRIPT_START_TIME% > "%LOGFILE%"
echo ======================================= >> "%LOGFILE%"

:: 1. Check for administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrative privileges. Please run as administrator.
    pause
    exit /b
)

:: 2. Run Windows Defender Quick Scan
echo Running malware scan (Quick Scan)...
echo [%time%] Running Windows Defender Quick Scan... >> "%LOGFILE%"
if exist "%ProgramFiles%\Windows Defender\mpcmdrun.exe" (
    :: -ScanType 1 is a Quick Scan. -ScanType 2 is a Full Scan.
    "%ProgramFiles%\Windows Defender\mpcmdrun.exe" -Scan -ScanType 1
    if !errorlevel! neq 0 (
        echo Windows Defender scan encountered an error. >> "%LOGFILE%"
    ) else (
        echo Quick malware scan completed successfully. >> "%LOGFILE%"
    )
) else (
    echo Windows Defender not found, skipping malware scan. >> "%LOGFILE%"
)

:: 3. Run DISM to repair the Windows image (Essential for stability, can be slow)
echo Running DISM to check and repair the system image...
echo [%time%] Running DISM RestoreHealth... >> "%LOGFILE%"
dism.exe /online /cleanup-image /restorehealth
if !errorlevel! neq 0 (
    echo DISM restorehealth encountered an error. >> "%LOGFILE%"
) else (
    echo DISM repair completed successfully. >> "%LOGFILE%"
)

:: 4. Run System File Checker (Essential for stability)
echo Running system file check...
echo [%time%] Running System File Checker (SFC)... >> "%LOGFILE%"
sfc /scannow
if !errorlevel! neq 0 (
    echo SFC encountered an error. >> "%LOGFILE%"
) else (
    echo System file check completed successfully. >> "%LOGFILE%"
)

:: 5. Run CHKDSK on next reboot
echo Scheduling disk check (CHKDSK) for the next reboot...
echo [%time%] Scheduling CHKDSK... >> "%LOGFILE%"
echo y | chkdsk C: /f
echo CHKDSK for C: has been scheduled. >> "%LOGFILE%"

:: 6. Clean up temporary files and caches
echo Cleaning up temporary files, folders, and caches...
echo [%time%] Cleaning up temporary files... >> "%LOGFILE%"
rd /s /q "%TEMP%" >nul 2>&1
rd /s /q "%WINDIR%\Temp" >nul 2>&1
rd /s /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache" >nul 2>&1
:: Below are caches for Chrome, Firefox, and Edge.
rd /s /q "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\Cache" >nul 2>&1
rd /s /q "%USERPROFILE%\AppData\Local\Mozilla\Firefox\Profiles\*.default*\cache2" >nul 2>&1
rd /s /q "%USERPROFILE%\AppData\Local\Microsoft\Edge\User Data\Default\Cache" >nul 2>&1
echo Temporary file cleanup complete. >> "%LOGFILE%"

:: 7. Clear all but the most recent system restore point
echo Clearing old system restore points...
echo [%time%] Clearing system restore points... >> "%LOGFILE%"
vssadmin delete shadows /for=c: /oldest
echo System restore points cleaned. >> "%LOGFILE%"

:: 8. Reset Windows Update Components
echo Resetting Windows Update components...
echo [%time%] Resetting Windows Update components... >> "%LOGFILE%"
net stop wuauserv
net stop cryptSvc
net stop bits
net stop msiserver
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old >nul 2>&1
ren C:\Windows\System32\catroot2 catroot2.old >nul 2>&1
net start wuauserv
net start cryptSvc
net start bits
net start msiserver
echo Windows Update component reset complete. >> "%LOGFILE%"

:: 9. Update installed apps using winget
echo Updating installed apps using winget...
echo [%time%] Updating installed apps via winget... >> "%LOGFILE%"

:: Define the path to winget.exe. This avoids PATH issues when running as Administrator.
set "WINGET_PATH=%LOCALAPPDATA%\Microsoft\WindowsApps\winget.exe"

:: Check if the winget executable exists at that specific path.
if not exist "%WINGET_PATH%" (
    echo Winget executable not found at the expected location. >> "%LOGFILE%"
    echo Skipping app updates. >> "%LOGFILE%"
) else (
    echo Found winget at %WINGET_PATH%. Proceeding with updates... >> "%LOGFILE%"
    "%WINGET_PATH%" upgrade --all --silent --accept-source-agreements --accept-package-agreements >> "%LOGFILE%" 2>&1
    echo App updates completed (see log for details). >> "%LOGFILE%"
)

:: 10. Defragment and Optimize Drives
echo Optimizing drives...
echo [%time%] Optimizing drives... >> "%LOGFILE%"
:: This command is safe for both SSDs (runs TRIM) and HDDs (runs Defrag).
defrag.exe C: /O
echo Drive optimization complete. >> "%LOGFILE%"

:: 11. Download and Run AdwCleaner (Excellent for Adware/PUPs)
echo Downloading and running AdwCleaner...
echo [%time%] Downloading AdwCleaner... >> "%LOGFILE%"
powershell -Command "Invoke-WebRequest -Uri 'https://adwcleaner.malwarebytes.com/adwcleaner?channel=release' -OutFile 'C:\adwcleaner.exe'"
if not exist "C:\adwcleaner.exe" (
    echo Download of AdwCleaner failed. >> "%LOGFILE%"
) else (
    echo Download complete. Running AdwCleaner silently... >> "%LOGFILE%"
    C:\adwcleaner.exe /clean /noreboot /eula
    echo AdwCleaner scan/clean process finished. >> "%LOGFILE%"
)

:: 12. Clear Event Logs
echo Clearing all event logs...
echo [%time%] Clearing event logs... >> "%LOGFILE%"
for /F "tokens=*" %%G in ('wevtutil el') DO (wevtutil cl "%%G")
echo Event logs cleared. >> "%LOGFILE%"

:: Final Steps
echo =================================================================
echo Maintenance script finished.
echo A reboot is required to complete the cleanup and disk check.
echo Check the report at %LOGFILE%
echo The computer will restart in 60 seconds. Press Ctrl+C to cancel.
echo =================================================================
shutdown /r /t 60

pause
exit /b

