@echo off
color 1F

@echo off
netsh wlan add profile filename="C:\Users\Public\Startupscript\XML\Wi-Fi-Support.xml"

:repeat
timeout 5 > nul
ping www.microsoft.com || goto :repeat

timeout /T 5

reg import C:\Users\Public\Startupscript\RegistryImport\AddOem.reg

call start C:\Users\Public\Startupscript\Winre\removewinre2.cmd

call start C:\Users\Public\Startupscript\Ninites\package.exe

call start C:\Users\Public\Startupscript\Batch\Retimer.cmd 

timeout /T 5

taskkill /F /IM msedge.exe

timeout /T 3

call start C:\Users\Public\Startupscript\Winupd\powershellupd.cmd

call start C:\Users\Public\Startupscript\Batch\power.cmd

call start C:\Users\Public\Startupscript\Batch\setdns.cmd

call start C:\Users\Public\Startupscript\Batch\turnoffbde.cmd

call start C:\Users\Public\Startupscript\Batch\winkey.cmd

timeout /T 10

@echo off
@echo off F | xcopy C:\Users\Public\Startupscript\Xcopy\startup2.lnk "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\startup2.lnk" /E /H /K /X /Y

call start C:\Users\Public\Startupscript\Batch\ChromeLink.cmd

call start powershell -executionpolicy remotesigned C:\Image\Users\Public\Startupscript\ChromeDefault\chrome.ps1

exit






