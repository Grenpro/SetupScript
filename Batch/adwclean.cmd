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