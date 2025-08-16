# Temporarily set execution policy for this process only.
try {
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned -Force -ErrorAction Stop
} catch {
    # This message is important for users who might have stricter policies.
    Write-Warning "Could not set execution policy. This might not be an issue."
}

# --- Script Setup ---
# We now use a stable folder on the C: drive, NOT the temp folder.
# This prevents the cleaner from deleting itself.
$workFolder = "C:\TempSetup"
$repoUrl = "https://github.com/Grenpro/SetupScript/archive/refs/heads/main.zip"
$zipPath = Join-Path $workFolder "SetupScript.zip"

Write-Host "--- Setup Initializing ---" -ForegroundColor Yellow
Write-Host "This script will download cleaner tools to: $workFolder"

# --- Main Logic ---
try {
    # Ensure a clean working folder exists
    if (Test-Path -Path $workFolder) {
        Write-Host "Removing old version of tools..."
        Remove-Item -Recurse -Force $workFolder
    }
    New-Item -ItemType Directory -Path $workFolder | Out-Null

    Write-Host "Downloading setup files..." -ForegroundColor Green
    Invoke-WebRequest -Uri $repoUrl -OutFile $zipPath

    Write-Host "Extracting files..." -ForegroundColor Green
    Expand-Archive -Path $zipPath -DestinationPath $workFolder -Force

    # Define paths based on the new, stable working folder
    $menuScript = Join-Path $workFolder "SetupScript-main\Batch\Menu.cmd"
    if (!(Test-Path $menuScript)) {
        throw "ERROR: Menu.cmd was not found after extraction. Aborting."
    }

    # Get the directory where Menu.cmd is located so it can find its other files
    $menuWorkingDirectory = Split-Path -Path $menuScript -Parent

    # --- Run the Interactive Menu ---
    Write-Host "Starting the menu. This script will wait for you to close the menu window." -ForegroundColor Cyan
    Write-Host "When you are finished, simply close the menu window to continue." -ForegroundColor Cyan
    
    # Run the menu from its own directory so all its sub-scripts work correctly
    Start-Process -FilePath $menuScript -WorkingDirectory $menuWorkingDirectory -Wait

    # --- The script only continues from here AFTER Menu.cmd has been closed ---
    Write-Host "`nMenu has been closed." -ForegroundColor Green
    
    # Prompt the user for cleanup action
    $choice = Read-Host "Do you want to clean up the downloaded tools from '$workFolder'? (Y/N)"

    if ($choice -eq 'y') {
        Write-Host "Cleaning up the tools folder: $workFolder"
        # The only cleanup needed is to remove the folder we created.
        # There is no script file to self-destruct because you used irm | iex.
        Remove-Item -Recurse -Force $workFolder
        Write-Host "Cleanup complete. Goodbye!"
    
    } else {
        Write-Host "Cleanup skipped. The tools are located in:" -ForegroundColor Yellow
        Write-Host "$workFolder" -ForegroundColor Cyan
        Write-Host "You can delete that folder manually when you are done." -ForegroundColor Yellow
    }

} catch {
    Write-Error "An error occurred: $_"
    # Even on error, we can offer to clean up the partial mess
    if (Test-Path -Path $workFolder) {
        Write-Warning "Attempting to clean up '$workFolder' due to error..."
        Remove-Item -Recurse -Force $workFolder
    }
    Read-Host "Press Enter to exit."
}
