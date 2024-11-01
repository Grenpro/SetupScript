rem Check if winget is available and update apps if so
winget --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Winget not available, skipping app updates. >> "%LOGFILE%"
) else (
    winget update --all
    echo App updates completed. >> "%LOGFILE%"
)

echo App update complete.