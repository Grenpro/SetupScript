$env:UserProfile
$Path = "C:\Users\Public\Startupscript\Batch\Gaming\gaming.png"
Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $Path
rundll32.exe user32.dll, UpdatePerUserSystemParameters
rundll32.exe user32.dll, UpdatePerUserSystemParameters
Exit