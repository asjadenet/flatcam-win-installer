# Run following when permissions are required:
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
.\checkgit.ps1
C:
cd \                                                                                                                                                                                                                                                        
mkdir flatcam                                                                                                                                                                                                                                               
cd flatcam  

mkdir installer                                                                                                                                                                                                                                             
cd .\installer\                                                                                                                                                                                                                                             
Invoke-WebRequest -Uri https://kumisystems.dl.sourceforge.net/project/winpython/WinPython_3.10/3.10.11.1/Winpython64-3.10.11.1dot.exe -OutFile Winpython64-3.10.11.1dot.exe                                                                                 
.\Winpython64-3.10.11.1dot.exe -o"..\" -y  
cd ..
git clone -b Beta_8.995 https://bitbucket.org/marius_stanciu/flatcam_beta 
mkdir whl  
cd .\flatcam_beta\  
$env:Path = "C:\flatcam\WPy64-310111\python-3.10.11.amd64;C:\flatcam\WPy64-310111\python-3.10.11.amd64\Scripts;"+[System.Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::Machine)   
python.exe -m pip install --upgrade pip
pip download -r requirements.txt -d ../whl    

# Define the path to the directory containing the wheel and tar.gz files
$packageDirectory = "C:\flatcam\whl"

# Get all .whl and .tar.gz files in the directory
$packageFiles = Get-ChildItem -Path $packageDirectory -Include *.whl, *.tar.gz -Recurse

# Loop through each file and install it using pip
foreach ($file in $packageFiles) {
    pip install $file.FullName
}

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


python .\flatcam.py  