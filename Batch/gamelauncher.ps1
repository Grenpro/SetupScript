winget install EpicGames.EpicGamesLauncher
winget install Valve.Steam
winget install ElectronicArts.EADesktop
winget install Ubisoft.Connect

Start-Process -Wait -FilePath "C:\Users\Public\Startupscript\Exe\Battle.net-Setup.exe" -ArgumentList '/S','/v','/qn' -passthru

$env:UserProfile
$Path = "C:\Users\Public\Startupscript\Batch\Gaming\gaming.png"
Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $Path
rundll32.exe user32.dll, UpdatePerUserSystemParameters
rundll32.exe user32.dll, UpdatePerUserSystemParameters
Exit