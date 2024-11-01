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