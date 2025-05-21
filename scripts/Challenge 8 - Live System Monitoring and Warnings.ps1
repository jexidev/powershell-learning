<#
1. Prompt the user to set a refresh interval (e.g., every 5 seconds).  
2. Start a loop that continuously retrieves system resource usage.  
3. Use `Get-Counter` to fetch **CPU and RAM usage** dynamically.  
4. Extract the percentage values from the collected system data.  
5. Display resource usage in a **formatted output** (e.g., percentages).  
6. Apply thresholds to check if CPU or RAM usage is **too high**.  
7. If usage exceeds the threshold, show an **alert message** (color-coded).  
8. Use `Start-Sleep` inside the loop to refresh the monitor every X seconds.  
9. Allow the user to **exit the monitor** gracefully when needed.  
10. (Optional) Log high-usage events to a file for future analysis.  
#>

# Step 1 - Prompt the user to set a refresh interval.
$refreshInterval = Read-Host "Please enter a refresh interval (e.g. every 5 seconds)"

# Step 2 - Start a loop to continuously retrieve system resource usage

while ($true) {
    # Get System Data
    $processorUsage = Get-Counter "\Processor(_Total)\% Processor Time"
    $memoryUsage = Get-Counter "\Memory\Available MBytes"

    # Extract Memory and CPU value from output
    $cpuValue = $processorUsage.CounterSamples.CookedValue
    $ramValueMB = ($memoryUsage.CounterSamples.CookedValue)
    $ramValueGB = [math]::Round($ramValueMB / 1024, 2)  # Convert MB to GB

    # Set upper threshold for warnings
    $cpuThreshold = 80
    $ramThreshold = 500

    if ($cpuValue -gt $cpuThreshold) {
        Write-Host "WARNING: HIGH CPU USAGE! ($cpuValue%)" -ForegroundColor Red
    }
    else {
        Write-Host "CPU Usage: $cpuValue%" -ForegroundColor Green
    }

    if ($ramValueMB -lt $ramThreshold) {
        Write-Host "CRITICAL: LOW MEMORY AVAILABLE! ($ramValueGB)" -ForegroundColor Red
    }
    else {
        Write-Host "Memory Usage: $ramValueGB" -ForegroundColor Green
    }

    # Wait before repeating
    Start-Sleep -Seconds $refreshInterval
}