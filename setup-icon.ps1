$TargetFile = "C:\flatcam\WPy64-310111\python-3.10.11.amd64\python.exe"
$ShortcutFile = "$Env:UserProfile\Desktop\FlatCAM EVO.lnk"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
$Shortcut.TargetPath = $TargetFile

# Set the arguments
$Shortcut.Arguments = "flatcam.py"

# Set the working directory
$Shortcut.WorkingDirectory = "C:\flatcam\flatcam_beta"

$Shortcut.IconLocation = "C:\flatcam\flatcam_beta\assets\resources\flatcam_icon256.ico"
$Shortcut.Save()
