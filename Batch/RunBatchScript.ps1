# Temporarily set execution policy for the session
Set-ExecutionPolicy -Scope LocalMachine -ExecutionPolicy RemoteSigned



# Define repository URL and local paths
$repoUrl = "https://github.com/Grenpro/SetupScript/archive/refs/heads/main.zip"
$tempFolder = "$env:TEMP\SetupScript"
$zipPath = "$tempFolder\SetupScript.zip"

# Ensure temp folder exists
if (!(Test-Path -Path $tempFolder)) {
    New-Item -ItemType Directory -Path $tempFolder | Out-Null
}

# Download the ZIP file
Invoke-WebRequest -Uri $repoUrl -OutFile $zipPath

# Extract the ZIP
Expand-Archive -Path $zipPath -DestinationPath $tempFolder -Force

# Change the working directory to the extracted folder
Set-Location "$tempFolder\SetupScript-main\Batch"

# Run the Menu.cmd script
$menuScript = "$tempFolder\SetupScript-main\Batch\Menu.cmd"
Start-Process -FilePath $menuScript -NoNewWindow -Wait

# Clean up
Remove-Item -Recurse -Force $tempFolder
Remove-Item -Recurse -Force "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\startup2.cmd"
