$SourceFilePath = "C:\Program Files\Microsoft Office\root\Office16\WINWORD.exe"
$ShortcutPath = "C:\Users\Bruker\Desktop\Word.lnk"
$WScriptObj = New-Object -ComObject ("WScript.Shell")
$shortcut = $WscriptObj.CreateShortcut($ShortcutPath)
$shortcut.TargetPath = $SourceFilePath
$shortcut.Save()
$SourceFilePath = "C:\Program Files\Microsoft Office\root\Office16\POWERPNT.exe"
$ShortcutPath = "C:\Users\Bruker\Desktop\PowerPoint.lnk"
$WScriptObj = New-Object -ComObject ("WScript.Shell")
$shortcut = $WscriptObj.CreateShortcut($ShortcutPath)
$shortcut.TargetPath = $SourceFilePath
$shortcut.Save()
$SourceFilePath = "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.exe"
$ShortcutPath = "C:\Users\Bruker\Desktop\Outlook.lnk"
$WScriptObj = New-Object -ComObject ("WScript.Shell")
$shortcut = $WscriptObj.CreateShortcut($ShortcutPath)
$shortcut.TargetPath = $SourceFilePath
$shortcut.Save()
$SourceFilePath = "C:\Program Files\Microsoft Office\root\Office16\EXCEL.exe"
$ShortcutPath = "C:\Users\Bruker\Desktop\Excel.lnk"
$WScriptObj = New-Object -ComObject ("WScript.Shell")
$shortcut = $WscriptObj.CreateShortcut($ShortcutPath)
$shortcut.TargetPath = $SourceFilePath
$shortcut.Save()
Import-StartLayout -LayoutPath "C:\Users\Public\Startupscript\layoutmodificationnew.xml" -MountPath $env:SystemDrive\