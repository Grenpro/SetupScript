# Temporarily set execution policy for this process only.
try {
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned -Force -ErrorAction Stop
} catch {
    Write-Warning "Failed to set execution policy. If the script fails, run it from a terminal using:"
    Write-Warning "powershell.e -ExecutionPolicy Bypass -File .\your_script_name.ps1"
}

# --- Script Setup ---

# $PSScriptRoot is a special variable for the directory where this script is located.
# This ensures the temp folder is created next to the script, keeping it safe from system cleaners.
$scriptParentFolder = $PSScriptRoot
$tempFolder = Join-Path $scriptParentFolder "SetupScript_Temp" # IMPORTANT CHANGE HERE

$repoUrl = "https://github.com/Grenpro/SetupScript/archive/refs/heads/main.zip"
$zipPath = Join-Path $tempFolder "SetupScript.zip"
$thisScriptPath = $PSCommandPath 

# --- Main Logic ---
try {
    Write-Host "This script will be downloaded to: $tempFolder" -ForegroundColor Cyan
    # Ensure a clean temp folder exists
    if (Test-Path -Path $tempFolder) {
        Remove-Item -Recurse -Force $tempFolder
    }
    New-Item -ItemType Directory -Path $tempFolder | Out-Null

    Write-Host "Downloading setup files..." -ForegroundColor Green
    Invoke-WebRequest -Uri $repoUrl -OutFile $zipPath

    Write-Host "Extracting files..." -ForegroundColor Green
    Expand-Archive -Path $zipPath -DestinationPath $tempFolder -Force

    $menuScript = Join-Path $tempFolder "SetupScript-main\Batch\Menu.cmd"
    if (!(Test-Path $menuScript)) {
        throw "ERROR: Menu.cmd was not found after extraction. Aborting."
    }
    $menuWorkingDirectory = Split-Path -Path $menuScript -Parent

    # --- Run the Interactive Menu ---
    Write-Host "Starting the menu. This script will wait for you to close the menu window." -ForegroundColor Yellow
    Write-Host "You can now safely use the cleaner option from the menu." -ForegroundColor Yellow
    
    Start-Process -FilePath $menuScript -WorkingDirectory $menuWorkingDirectory -Wait

    # --- After Menu.cmd is closed ---
    Write-Host "`nMenu has been closed." -ForegroundColor Green
    
    $choice = Read-Host "Do you want to clean up all downloaded files and this script? (Y/N)"

    if ($choice -eq 'y') {
        Write-Host "Cleaning up the temporary folder: $tempFolder"
        Remove-Item -Recurse -Force $tempFolder

        Write-Host "Staging self-destruction of this script. Goodbye!"
        $command = "ping 127.0.0.1 -n 4 > nul & del `"$thisScriptPath`""
        Start-Process cmd.exe -ArgumentList "/c $command" -WindowStyle Hidden
    
    } else {
        Write-Host "Cleanup skipped. The files are located in:" -ForegroundColor Yellow
        Write-Host "$tempFolder" -ForegroundColor Cyan
        Write-Host "You can delete that folder and this script manually when you are done." -ForegroundColor Yellow
    }

} catch {
    Write-Error "An error occurred: $_"
    if (Test-Path -Path $tempFolder) {
        Write-Warning "Attempting to clean up temporary folder due to error..."
        Remove-Item -Recurse -Force $tempFolder
    }
    Read-Host "Press Enter to exit."
}
