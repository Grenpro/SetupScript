C:\Users\Public\Startupscript\Batch\setup.exe /download C:\Users\Public\Startupscript\Batch\ConfigurationStandard.xml

timeout /T 3

C:\Users\Public\Startupscript\Batch\setup.exe /configure C:\Users\Public\Startupscript\Batch\ConfigurationStandard.xml

timeout /T 3

powershell -executionpolicy remotesigned C:\Users\Public\Startupscript\Batch\shortcuts.ps1

exit

