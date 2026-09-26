# ============================================
# Get-RecentErrors.ps1
# Purpose: Check recent Windows errors
# ============================================

# Display the script heading
Write-Host "===================================="
Write-Host "       RECENT WINDOWS ERRORS"
Write-Host "===================================="

# Set the time range to the last 24 hours
$StartTime = (Get-Date).AddHours(-24)

# Try to retrieve recent error events
try {
    $Errors = Get-WinEvent -FilterHashtable @{
        LogName   = "System"
        Level     = 1,2
        StartTime = $StartTime
    } -MaxEvents 10 -ErrorAction Stop
}
catch {
    Write-Host "Unable to retrieve Windows event logs."
    exit
}

# Check whether any errors were found
if (-not $Errors) {
    Write-Host "No recent errors were found."
    exit
}

# Display the errors
foreach ($ErrorEvent in $Errors) {

    Write-Host ""
    Write-Host "Time:     $($ErrorEvent.TimeCreated)"
    Write-Host "Source:   $($ErrorEvent.ProviderName)"
    Write-Host "Event ID: $($ErrorEvent.Id)"
    Write-Host "Level:    $($ErrorEvent.LevelDisplayName)"
    Write-Host "Message:  $($ErrorEvent.Message)"
}

# Display completion message
Write-Host ""
Write-Host "===================================="
Write-Host "          CHECK COMPLETE"
Write-Host "===================================="
