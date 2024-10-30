@echo off
color 1F

@echo off
netsh wlan add profile filename="C:\Users\Public\Startupscript\XML\Wi-Fi-Support.xml"

:repeat
timeout 5 > nul
ping www.microsoft.com || goto :repeat

timeout /T 5

reg import ..\RegistryImport\AddOem.reg

call start ..\Winre\removewinre2.cmd

call start ..\Winget\browser.cmd

call start Retimer.cmd 

timeout /T 5

taskkill /F /IM msedge.exe

timeout /T 3

call start ..\Winupd\powershellupd.cmd

call start power.cmd

call start setdns.cmd

call start turnoffbde.cmd

call start winkey.cmd

timeout /T 10

@echo off
@echo off F | xcopy ..\Xcopy\startup2.cmd "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\startup2.cmd" /E /H /K /X /Y

call start ChromeLink.cmd

exit






