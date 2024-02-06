Try {
    # Attempt to run 'git --version' to check if Git is installed
    $gitVersion = git --version
    Write-Host "Git is installed. Version: $gitVersion"
}
Catch {
    Write-Host "Git is not installed. Attempting to download and install..."
    # Specify the path to the script that downloads and installs Git
    $installerScriptPath = ".\downloadgit.ps1"
    # Check if the installer script exists
    If (Test-Path $installerScriptPath) {
        # Call the installer script
        & $installerScriptPath
    }
    Else {
        Write-Host "Installer script not found at $installerScriptPath"
    }
}
