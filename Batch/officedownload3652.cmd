setup.exe /download ConfigurationStandard.xml

timeout /T 3

setup.exe /configure ConfigurationStandard.xml

timeout /T 3

powershell -executionpolicy remotesigned shortcuts.ps1

exit

