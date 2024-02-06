$exePath = "$env:TEMP\git.exe"

# Download git installer
Invoke-WebRequest -Uri https://github.com/git-for-windows/git/releases/download/v2.43.0.windows.1/Git-2.43.0-64-bit.exe -UseBasicParsing -OutFile $exePath

# Execute git installer
Start-Process $exePath -ArgumentList '/VERYSILENT /NORESTART /NOCANCEL /SP- /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /COMPONENTS="icons,ext\reg\shellhere,assoc,assoc_sh"' -Wait

# Optional: For bash.exe, add 'C:\Program Files\Git\bin' to PATH
[Environment]::SetEnvironmentVariable('Path', "$([Environment]::GetEnvironmentVariable('Path', 'Machine'));C:\Program Files\Git\bin", 'Machine')

# Make new environment variables available in the current PowerShell session:
foreach($level in "Machine","User") {
   [Environment]::GetEnvironmentVariables($level).GetEnumerator() | % {
      # For Path variables, append the new values, if they're not already in there
      if($_.Name -match 'Path$') { 
         $_.Value = ($((Get-Content "Env:$($_.Name)") + ";$($_.Value)") -split ';' | Select -unique) -join ';'
      }
      $_
   } | Set-Content -Path { "Env:$($_.Name)" }
}
