# ============================================
# Get-DiskSpace.ps1
# Purpose: Check available disk space
# ============================================

# Display the script heading
Write-Host "===================================="
Write-Host "          DISK SPACE CHECK"
Write-Host "===================================="

# Get all local hard drives
$Drives = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3"

# Check whether any local drives were found
if (-not $Drives) {
    Write-Host "No local drives were found."
    exit
}

# Process each local drive
foreach ($Drive in $Drives) {

    # Convert total disk space from bytes to GB
    $TotalGB = [math]::Round($Drive.Size / 1GB, 2)

    # Convert free disk space from bytes to GB
    $FreeGB = [math]::Round($Drive.FreeSpace / 1GB, 2)

    # Calculate the percentage of free space
    $FreePercent = [math]::Round(
        ($Drive.FreeSpace / $Drive.Size) * 100,
        2
    )

    # Display disk information
    Write-Host ""
    Write-Host "Drive: $($Drive.DeviceID)"
    Write-Host "Total Space: $TotalGB GB"
    Write-Host "Free Space: $FreeGB GB"
    Write-Host "Free: $FreePercent%"

    # Check whether the drive has low free space
    if ($FreePercent -lt 15) {
        Write-Host "Status: WARNING - Low disk space"
    }
    else {
        Write-Host "Status: PASS - Disk space is OK"
    }
}

# Display completion message
Write-Host ""
Write-Host "===================================="
Write-Host "          CHECK COMPLETE"
Write-Host "===================================="
