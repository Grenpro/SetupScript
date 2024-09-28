powershell Install-PackageProvider -Name Nuget -MinimumVersion 2.8.5.201 -Force

powershell Install-Module PSWindowsUpdate -Force

timeout /T 5

call start powershell -executionpolicy remotesigned C:\Users\Public\Startupscript\Winupd\PS_WinUpdate.ps1

call start powershell -executionpolicy remotesigned C:\Users\Public\Startupscript\Winupd\network.ps1

exit






