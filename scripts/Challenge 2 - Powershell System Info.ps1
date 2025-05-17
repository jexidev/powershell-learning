<# PowerShell Script: System Information Reporter
------------------------------------------------
This script:
1 Retrieves the computer’s name
2 Lists running system services
3 Asks the user if they want to save the output to a text file
------------------------------------------------#>

# Step 1: Get the computer’s name
# `$env:COMPUTERNAME` pulls the machine name from the system’s environment variables
Write-Output "Computer Name: $env:COMPUTERNAME"

# Step 2: List all running services
# `Get-Service` retrieves all system services
# `ForEach-Object` loops through each service in the list
# `Write-Output "$($_.DisplayName)"` extracts and prints only the service name
Write-Output "Running Services:"
Get-Service | ForEach-Object { Write-Output "$($_.DisplayName)"}

# Step 3: Ask the user whether to save the output to a text file
# `Read-Host` prompts the user to enter "yes" or "no"
$userChoice = Read-Host "Would you like to save this output to file? (yes/no)"

# Step 4: Save the output if the user chooses "yes"
if ($userChoice -eq "yes") {
    Write-Output "Saving output to SystemInfo.txt..."

    # Write the computer name to the file
    # `Out-File` saves output to a file called "SystemInfo.txt"
    Write-Output "Computer Name: $env:COMPUTERNAME" | Out-File -FilePath .\SystemInfo.txt

    # Append the list of running services to the file
    # `-Append` ensures new data is added instead of overwriting the file
    Get-Service | ForEach-Object { Write-Output "$($_.DisplayName)"} | Out-File -FilePath .\SystemInfo.txt -Append
}

<# How This Works:
------------------------------------------------
🔹 `Write-Output` prints messages to the console (or file when piped).
🔹 `$env:COMPUTERNAME` fetches the computer’s name from environment variables.
🔹 `Get-Service` retrieves the list of services running on the machine.
🔹 `ForEach-Object { $_.DisplayName }` extracts the readable service name.
🔹 `Read-Host` collects user input for saving the output.
🔹 `If ($userChoice -eq "yes")` checks user input & runs the file-saving commands.
🔹 `Out-File` writes the data into "SystemInfo.txt".
🔹 `-Append` ensures running services are **added** to the file instead of overwriting previous data.
------------------------------------------------#>
