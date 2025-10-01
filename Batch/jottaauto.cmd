@echo off
powershell -Command "Invoke-WebRequest -Uri https://sw.jotta.cloud/autoinstaller/desktop-auto-installer.exe -OutFile $env:TEMP\jotta-installer.exe" && "%TEMP%\jotta-installer.exe" && del "%TEMP%\jotta-installer.exe"
exit
