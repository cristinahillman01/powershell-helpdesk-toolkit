# ============================================
# Get-WindowsUpdateStatus.ps1
# Purpose: Check Windows Update status
# ============================================

# Display the script heading
Write-Host "===================================="
Write-Host "       WINDOWS UPDATE STATUS"
Write-Host "===================================="

# Get Windows operating system information
$OS = Get-CimInstance Win32_OperatingSystem

# Display Windows information
Write-Host ""
Write-Host "Computer: $env:COMPUTERNAME"
Write-Host "Operating System: $($OS.Caption)"
Write-Host "Version: $($OS.Version)"
Write-Host "Build: $($OS.BuildNumber)"
Write-Host "Last Boot: $($OS.LastBootUpTime)"

# Get the Windows Update service
try {
    $UpdateService = Get-Service -Name "wuauserv" -ErrorAction Stop
}
catch {
    Write-Host ""
    Write-Host "Unable to find the Windows Update service."
    exit
}

# Display Windows Update service information
Write-Host ""
Write-Host "Windows Update Service"
Write-Host "Name: $($UpdateService.Name)"
Write-Host "Status: $($UpdateService.Status)"

# Check whether the Windows Update service is running
if ($UpdateService.Status -eq "Running") {
    Write-Host "Service Health: PASS - Windows Update service is running."
}
else {
    Write-Host "Service Health: WARNING - Windows Update service is not running."
}

# Display completion message
Write-Host ""
Write-Host "===================================="
Write-Host "          CHECK COMPLETE"
Write-Host "===================================="
