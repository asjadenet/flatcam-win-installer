# Define the path to the directory containing the wheel and tar.gz files
$packageDirectory = "C:\flatcam\whl"

# Get all .whl and .tar.gz files in the directory
$packageFiles = Get-ChildItem -Path $packageDirectory -Include *.whl, *.tar.gz -Recurse

# Loop through each file and install it using pip
foreach ($file in $packageFiles) {
    pip install $file.FullName
}
