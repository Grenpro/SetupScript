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