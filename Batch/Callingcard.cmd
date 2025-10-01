@echo off
powershell -Command "Invoke-WebRequest -Uri https://elkitsupportstorage.blob.core.windows.net/supportagreement/Elkjop_CC.msi -OutFile $env:TEMP\Elkjop_CC.msi" && msiexec /i "%TEMP%\Elkjop_CC.msi" /qn /norestart && del "%TEMP%\Elkjop_CC.msi"
exit
