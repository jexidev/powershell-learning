# Ask user for software to check
$softwareName = Read-Host "Enter programs to check (separate by comma)" | ForEach-Object {$_.Split(",")}

# Loop through user-provided list
foreach ($software in $softwareName) {
    $softwareCheck = Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" |
                     Select-Object DisplayName

    if ($softwareCheck) {
        Write-Output "$software is installed!"
    } else {
        Write-Output "$software is NOT installed"
    }
}
