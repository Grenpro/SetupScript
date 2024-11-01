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