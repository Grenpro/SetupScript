# Temporarily set execution policy for this process only.
try {
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned -Force -ErrorAction Stop
} catch {
    Write-Warning "Failed to set execution policy. If the script fails, run it from a terminal using:"
    Write-Warning "powershell.exe -ExecutionPolicy Bypass -File .\your_script_name.ps1"
}

# --- Script Setup ---
$repoUrl = "https://github.com/Grenpro/SetupScript/archive/refs/heads/main.zip"
$tempFolder = Join-Path $env:TEMP "SetupScript"
$zipPath = Join-Path $tempFolder "SetupScript.zip"
$thisScriptPath = $PSCommandPath 

# --- Main Logic ---
try {
    if (Test-Path -Path $tempFolder) {
        Remove-Item -Recurse -Force $tempFolder
    }
    New-Item -ItemType Directory -Path $tempFolder | Out-Null

    Write-Host "Downloading setup files..." -ForegroundColor Green
    Invoke-WebRequest -Uri $repoUrl -OutFile $zipPath

    Write-Host "Extracting files..." -ForegroundColor Green
    Expand-Archive -Path $zipPath -DestinationPath $tempFolder -Force

    # Define the path to the batch script
    $menuScript = Join-Path $tempFolder "SetupScript-main\Batch\Menu.cmd"
    if (!(Test-Path $menuScript)) {
        throw "ERROR: Menu.cmd was not found after extraction. Aborting."
    }

    # Get the directory where Menu.cmd is located
    $menuWorkingDirectory = Split-Path -Path $menuScript -Parent

    # --- Run the Interactive Menu ---
    Write-Host "Starting the menu. This script will wait for you to close the menu window." -ForegroundColor Yellow
    Write-Host "When you are finished with the menu, simply close its window to continue." -ForegroundColor Yellow
    
    # ==============================================================================
    # THE FIX IS HERE: We added the -WorkingDirectory parameter
    # This tells Menu.cmd to run from inside its own folder, so it can find its other scripts.
    # ==============================================================================
    Start-Process -FilePath $menuScript -WorkingDirectory $menuWorkingDirectory -Wait

    # --- The script will only continue from here AFTER Menu.cmd has been closed ---
    Write-Host "`nMenu has been closed." -ForegroundColor Green
    
    $choice = Read-Host "Do you want to clean up all downloaded files and this script? (Y/N)"

    if ($choice -eq 'y') {
        Write-Host "Cleaning up downloaded files..."
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
